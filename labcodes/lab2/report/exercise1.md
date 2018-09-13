

#implement the algorithm of first-fit continue physical memory allocation

##necessary theory

###the structure of page

````c++
struct Page {
    
    
}
````



1. ref: represents the virtual page counter of reference  the page frame(physical page).++ref:there are new virtual page mapping the page frame.else,detaching.

2. flags: it have two flag bits.One is meaning whether it was kept.if kept,set 1.The another is meaning whether it is free.if free,it can be allocated,whereas it cannot be allocated.

3. property: the size of continue free block.(it must be the beginning address of the continue block if the member is used).

4. page_link: the doubly linked list pointer so as to link several continue block.

   ###List implementation

````c++
struct list_entry {		//Simple doubly linked list implementation...
	struct list_entry *prev, *next;
};
typedef struct list_entry list_entry_t;
````

- define a S-d-l structure of list_entry_t.

````c++
typedef stuct {
    list_entry_t free_list;		//the list header
    unsigned int nr_free;		//of free pages in this free list
}tree_area_t;
````

- free_list is the pointer of list_entry structure.
- nr_free is recording the number of free pages.

```c++
typedef stuct {
    list_entry_t free_list;		//the list header
    unsigned int nr_free;		//of free pages in this free list
}tree_area_t;
```

