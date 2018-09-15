# Release PG and PDE

```c++
//page_remove_pte - free an Page sturct which is related linear address la
//                - and clean(invalidate) pte which is related linear address la
//note: PT is changed, so the TLB need to be invalidate 
static inline void
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
    /* LAB2 EXERCISE 3: YOUR CODE
     *
     * Please check if ptep is valid, and tlb must be manually updated if mapping is updated
     *
     * Maybe you want help comment, BELOW comments can help you finish the code
     *
     * Some Useful MACROs and DEFINEs, you can use them in below implementation.
     * MACROs or Functions:
     *   struct Page *page pte2page(*ptep): get the according page from the value of a ptep
     *   free_page : free a page
     *   page_ref_dec(page) : decrease page->ref. NOTICE: ff page->ref == 0 , then this page should be free.
     *   tlb_invalidate(pde_t *pgdir, uintptr_t la) : Invalidate a TLB entry, but only if the page tables being
     *                        edited are the ones currently in use by the processor.
     * DEFINEs:
     *   PTE_P           0x001                   // page table/directory entry flags bit : Present
     */
```

My code:

```c++
static inline void
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
if( *ptep & PTE_P){ //check if this page table entry is present		
     struct Page *page = pte2page(*ptep);//find corresponding page to pte
     if (page_ref_dec(page) == 0) {//decrease page reference and free this page when page reference reachs 0
        free_page(page);
    }
    *ptep = 0;//clear second page table entry
    tlb_invalidate(pde_t *pgdir, uintptr_t la);//flush tlb
}
```

Problem1:

