# implement to seek for virtual address of  correspond PT

## Theory Analysis

The 80368 uses a secondary page table to establish a mapping between linear addresses and physical addresses. Since we already have one The physical memory page manager default_pmm_manager, which supports the function of dynamically allocating and releasing memory pages, we can use it to get the free physical pages you need. In the secondary-level page table structure, the page directory table occupies 4KB space and can pass the alloc_page function gets a free physical page as a Page Directory Table (PDT). Similarly,Ucore also obtains the 4KB space required for a Page Table (PT) in this similar way.



The size of the entire page directory table and page table depends on the number of physical pages to be managed and mapped with the secondary page table. Assume current physics Memory 0~16MB, each physical page (also called Page Frame) is 4KB in size, there are 4096 physical pages, which means this
There are 4 page directory entries and 4096 page table entries that need to be set. a page directory entry (PDE) and a Page Table Entry (PTE) accounts for 4B. Even a four page directory entry requires a full page directory table (occupies 4KB). And 4096 page table entries require 16KB (that is, 4096*4B) space, that is, 4 physical pages, 16KB room. So to create a one-to-one 16MB virtual page for a 16MB physical page, you need 5(4+1) physical pages, that is, 20KB of space to form  the secondary page table.



To set 0~KERNSIZE (clear ucore setting actual physical memory can not exceed KERNSIZE value, that is  0x38000000 Bytes, 896MB, 3670016 physical pages) The physical address  map to the contents of the page directory entry and the page table entry.
The process is as follows:



1. First get a free physical page through alloc_page for the page directory table;

2. Call the boot_map_segment function to establish a one-to-one mapping relationship. The specific processing is set in units of pages, that is

  > <center>Virt addr = phy addr + 0xC0000000</center>

  Let a 32-bit linear address la have a corresponding 32-bit physical address pa, if the index of the upper 10 bits of la is used.The presence bit (PTE_P) in the page directory entry is 0, indicating that the corresponding page table space is missing, which can be obtained by alloc_page.Get a free physical page to the page table, the starting physical address of the page table is aligned by 4096 bytes, so fill in the page directory entry Content is

  Further, for the page table, the content of the page table entry corresponding to the 10th bit of the linear address la is

  > <center>Page Directory Item Contents = (Page Table Start Physical Address & ~0x0FFF) | PTE_U | PTE_W | PTE_P</center>

  among them:

3. PTE_U: Bit 3, indicate that the user mode software can read the physical memory page content of the corresponding address

4. PTE_W: Bit 2, indicate that the physical memory page content can be written

5. PTE_P: Bit 1, indicate the existence of physical memory pages
    Ucore's memory management often needs to look up the page table: Given a virtual address, find out the virtual address in the secondary page table.
    The item that should be. You can easily map a virtual address to another page by changing the value of this item. This can do this
    The function is the get_pte function. Its prototype is
    Pte_t *get_pte (pde_t *pgdir, uintptr_t la, bool create)

Ucore's memory management often needs to look up the page table: Given a virtual address, find out the virtual address in the secondary page table of the item that should be. You can easily map a virtual address to another page by changing the value of this item. This can do this the function is the get_pte function. Its prototype is 

```c++
Pte_t *get_pte (pde_t *pgdir, uintptr_t la, bool create)
```

The following contents is IA-32 Intel ® Architecture Software Developer’s Manual Volume 3:System Programming Guide

![](D:\Userlist\picture\computer\TIM截图20180914205447.png)

![](D:\Userlist\picture\computer\TIM截图20180914205554.png)



````c++
//get_pte - get pte and return the kernel virtual address of this pte for la
//        - if the PT contians this pte didn't exist, alloc a page for PT
// parameter:
//  pgdir:  the kernel virtual base address of PDT
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
    /* LAB2 EXERCISE 2: YOUR CODE
     *
     * If you need to visit a physical address, please use KADDR()
     * please read pmm.h for useful macros
     *
     * Maybe you want help comment, BELOW comments can help you finish the code
     *
     * Some Useful MACROs and DEFINEs, you can use them in below implementation.
     * MACROs or Functions:
     *   PDX(la) = the index of page directory entry of VIRTUAL ADDRESS la.
     *   KADDR(pa) : takes a physical address and returns the corresponding kernel virtual address.
     *   set_page_ref(page,1) : means the page be referenced by one time
     *   page2pa(page): get the physical address of memory which this (struct Page *) page  manages
     *   struct Page * alloc_page() : allocation a page
     *   memset(void *s, char c, size_t n) : sets the first n bytes of the memory area pointed by s
     *                                       to the specified value c.
     * DEFINEs:
     *   PTE_P           0x001                   // page table/directory entry flags bit : Present
     *   PTE_W           0x002                   // page table/directory entry flags bit : Writeable
     *   PTE_U           0x004                   // page table/directory entry flags bit : User can access
     */
#if 0
    pde_t *pdep = NULL;   // (1) find page directory entry
    if (0) {              // (2) check if entry is not present
                          // (3) check if creating is needed, then alloc page for page table
                          // CAUTION: this page is used for page table, not for common data page
                          // (4) set page reference
        uintptr_t pa = 0; // (5) get linear address of page
                          // (6) clear page content using memset
                          // (7) set page directory entry's permission
    }
    return NULL;          // (8) return page table entry
#endif
}
````

The following is the specific implementation process:

````
pte_t *
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
    pde_t *pdep = &pgdir[PDX(la)]; //  find page directory entry
    if(!(*pdep & PTE_P)) {        // check if entry is not present
        struct Page *page;
        if(!create || (page = alloc_page()) == NULL) {//  check if creating is needed, then alloc page for page table
            return NULL;
        }
        set_page_ref(page, 1);//  set page reference
        uintptr_t pa = page2pa(page);//  get linear address of page
        memset(KADDR(pa), 0, PGSIZE); //  clear page content using memset
        *pdep = pa | PTE_U | PTE_W | PTE_P;//  set page directory entry's permission
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep)))[PTX(la)];//  return page table entry
}
````

Note:

1. pde_t(page directory entry.pgdir actually is the first-level page table itself,rather table entry.As a matter of fact,a type of pgd_t that represents the first level page table itself )
2. pte_t(page table entry),represents the secondary-level page table entry
3. uintptr_t,represents linear address(logical address in segmentation memory management)
4. pgdir,gives the beginning address of page table
5. It is possible that there is no corresponding secondary-level page table, so the second level page table does not have to be allocated at the beginning, but wait until the need Add the corresponding secondary-level page table when you want to.If you find a secondary-level page table entry, you find that the corresponding secondary-level page table does not exist, then you need to handle creating a new secondary-level page table based on the value of the create parameter.If the create parameter is 0, the get_pte returns NULL, if the Create parameter is not 0, get_pte needs to request a new physical page (through alloc_page.Now, you can find its definition in mm/pmm.h), and then add a page catalog entry in the first-level page table to the table representing the secondary-level page's new physical page.Note that the newly requested page must all be set to zero, because the virtual address represented by this page is not mapped.

```CQL
 +--------10------+-------10-------+---------12----------+
 | Page Directory |   Page Table   | Offset within Page  |
 |      Index     |     Index      |                     |
 +----------------+----------------+---------------------+
 |--- PDX(la) ----|---- PTX(la) ---|---- PGOFF(la) ------|
 |----------- PPN(la) -------------|
```

