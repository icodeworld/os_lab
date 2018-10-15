练习1：分配并初始化一个进程控制块

练习2：为新创建的内核线程分配资源

练习3：理解如何完成进程切换

> 1. 执行流程-执行第一个内核线程
>    1. begin schedule           
>    2. unable reschedule 
>    3. find a ready process 
>    4. begin execute initproc 
>    5. switch kstack 
>    6. switch page table 
>    7. switch context 
>    8. return

