# implement the algorithm of first-fit continue physical memory allocation

## 1 necessary theory

- ### 1.1 the structure of page


```c++
struct Page {
    int ref;					//page frame's reference counter
    uint32_t flags;				//array of flags that describe the status of the page frame
    unsigned int property;		//the total num of free block,used in first fit pm management
    list_entry_t page_link;		//free list link	
};
```

1. ref: represents the virtual page counter of reference  the page frame(physical page).++ref:there are new virtual page mapping the page frame.else,detaching.
2. flags: it have two flag bits.One is meaning whether it was kept.if kept,set 1.The another is meaning whether it is free.if free,it can be allocated,whereas it cannot be allocated.
3. property: the size of continue free block.(it must be the beginning address of the continue block if the member is used).
4. page_link: the doubly linked list pointer so as to link several continue block.         

- ### 1.2 List implementation


```c++
struct list_entry {		//Simple doubly linked list implementation...
	struct list_entry *prev, *next;
};
typedef struct list_entry list_entry_t;
```

- define a S-d-l structure of list_entry_t.

```c++
typedef stuct {
    list_entry_t free_list;		//the list header
    unsigned int nr_free;		//of free pages in this free list
}tree_area_t;
```

- free_list is the pointer of list_entry structure.
- nr_free is recording the total number for free mem blocks.

## 2 implementation

- 2.1 default_init()__no revised

```c++
#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
}
```

- 2.2 default_init_memmap() this function uses to init the free pages linked list.It includes initialization every free page and then count the total number of free pages.The following is the explanation of this function.

````c++
 This fun is used to init a free block (with parameter: addr_base, page_number).
 *              First you should init each page (in memlayout.h) in this free block, include:
 *                  p->flags should be set bit PG_property (means this page is valid. In pmm_init fun (in pmm.c),
 *                  the bit PG_reserved is setted in p->flags)
 *                  if this page  is free and is not the first page of free block, p->property should be set to 0.
 *                  if this page  is free and is the first page of free block, p->property should be set to total num of block.
 *                  p->ref should be 0, because now p is free and no reference.
 *                  We can use p->page_link to link this page to free_list, (such as: list_add_before(&free_list, &(p->page_link)); )
 *              Finally, we should sum the number of free mem block: nr_free+=n
````

````c++
static void default_init_memmap(struct Page *base, size_t n) {   
    assert(0 < n);
    struct Page *p = base;
    for(;p != base + n;p++){
        assert(PageReserved(p));//ensure the page is reserved
        p->flags = 0;//set the flag bit
        SetPageProperty(p);
        p->property = 0;
        set_page_ref(p,0);//clean the reference
        list_add_before(&free_list,&(p->page_link));//insert the free page list
        nr_free += n;//illustrate having continue n free blocks that belong to free linked list
        base->property = n;//the continue memory free blocks size is n that is ppmll
     }
}
````

- 2.3 default_alloc_pages()  the following explanation:

````c++
search find a first free block (block size >=n) in free list and reszie the free block, return the addr
 *              of malloced block.
 *              (4.1) So you should search freelist like this:
 *                       list_entry_t le = &free_list;
 *                       while((le=list_next(le)) != &free_list) {
 *                       ....
 *                 (4.1.1) In while loop, get the struct page and check the p->property (record the num of free block) >=n?
 *                       struct Page *p = le2page(le, page_link);
 *                       if(p->property >= n){ ...
 *                 (4.1.2) If we find this p, then it' means we find a free block(block size >=n), and the first n pages can be malloced.
 *                     Some flag bits of this page should be setted: PG_reserved =1, PG_property =0
 *                     unlink the pages from free_list
 *                     (4.1.2.1) If (p->property >n), we should re-caluclate number of the the rest of this free block,
 *                           (such as: le2page(le,page_link))->property = p->property - n;)
 *                 (4.1.3)  re-caluclate nr_free (number of the the rest of all free block)
 *                 (4.1.4)  return p
 *               (4.2) If we can not find a free block (block size >=n), then return NULL
````

````c++
static struct Page *default_alloc_pages(size_t n) {
	assert(0 < n);
    if(nr_free < n) 
        return NULL;//if the sum of all free pages size isnnot enough
    list_entry_t *len;
    list_entry_t le = &free_free_list;//begin from the head pointer of free block list 
    while((le = list_next(le)) != &free_list) {//trace entire linked list 
        struct Page *p = le2page(le, page_link);//transform address into the structure of page
        if(p->property >= n){//choose it when coming across the first block that is greater than N
            int i;
            for(i=0;i<n;i++){//recursively init every page structure from the selected free block list}
                len = list_next(le);
                struct Page *pp = le2page(le,page_link);
                SetPageReserved(pp);
                ClearPageProperty(pp);
                list_del(le);//delete the pointer of this dll from the free page linked list
                le = len;
            }
            if(p->property>n) 
                (le2page(le,page_link))->property = p->property - n;
            ClearPageProperty(p);
            SetPageReserved(p);
            nr_free -= n;//the total number of current free pages substract n
            return p;
        }
    }
    return NULL;
}
````
