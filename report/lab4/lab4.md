



### 练习1

> 分配并初始化一个进程控制块（需要编程） 
>
>   alloc_proc函数(位于kern/process/proc.c中)负责分配并返回一个新的struct proc_struct结构，用于存储新建立的内核线程的管理信息。ucore需要对这个结构进行最基本的初始化，本练习要求完成这个初始化过程

- 内核线程与用户线程区别：内核线程只运行在内核态。用户进程会在在用户态和内核态交替运行所有内核线程共用ucore内核内存空间，不需为每个内核线程维护单独的内存空间，而用户进程需要维护各自的用户内存空间。

- 分析结构体

  proc_struct

  ```c
  struct proc_struct {
      int pid;                                    // Process ID,like identity card
  	char name[PROC_NAME_LEN + 1];               // Process name,like your name
  	
  	enum proc_state state;                      // Process state
      int runs;                                   // the running times of Proces
  	volatile bool need_resched;                 // bool value: need to be rescheduled to release CPU?
  	uint32_t flags;                             // Process flag   
  
      uintptr_t kstack;                           // Process kernel stack
  	uintptr_t cr3;                              // CR3 register: the base addr of Page Directroy Table(PDT)    
      struct mm_struct *mm;                       // Process's memory management field
  	
      struct context context;                     // Switch here to run process
      struct trapframe *tf;                       // Trap frame for current interrupt
  	
  	struct proc_struct *parent;                 // the parent process
      list_entry_t list_link;                     // Process link list 
      list_entry_t hash_link;                     // Process hash list
  };
  ```

  这里简单介绍下各个参数：

  1. mm：内存管理的信息，包括内存映射列表、页表指针等,即实验三中的描述进程虚拟内存的结构体. mm 里有个很重要的项pgdir，记录的是该进程使用的一级页表的物理地址。

  2. state：进程所处的状态。

     > PROC_UNINIT // 未初始状态
     > PROC_SLEEPING // 睡眠（阻塞）状态
     > PROC_RUNNABLE // 运行与就绪态
     > PROC_ZOMBIE // 僵死状态
     > pid：进程id号。

  3. parent：用户进程的父进程（创建它的进程）。在所有进程中，只有一个进程没有父进程，就是内核创建的第一个内核线程 idleproc。内核根据这个父子关系建立进程的树形结构，用于维护一些特殊的操作，例如确定哪些进程是否可以对另外一些进程进行什么样的操作等等。

  4. context：进程的上下文，用于进程切换。 在ucore 中，所有的进程在内核中也是相对独立的（例如独立的内核堆栈以及上下文等等）。使用context保存寄存器的目的就在于在内核态中能够进行上下文之间的切换。

  5. tf：中断帧的指针，总是指向内核栈的某个位置：当进程从用户空间跳到内核空间时，中断帧记录了进程在被中断前的状态。当内核需要跳回用户空间时，需要调整中断帧以恢复让进程继续执行的各寄存器值。除此之外，ucore 内核允许嵌套中断。因此为了保证嵌套中断发生时 tf 总是能够指向当前的 trapframe， ucore 在内核桟上维护了 tf 的链。

  6. cr3: cr3 保存页表的物理地址，目的就是进程切换的时候方便直接使用 lcr3 实现页表切换，避免每次都根据 mm 来计算 cr3。 mm 数据结构是用来实现用户空间的虚存管理的，但是内核线程没有用户空间，它执行的只是内核中的一小段代码（通常是一小段函数），所以它没有 mm 结构，也就是 NULL。当某个进程是一个普通用户态进程的时候， PCB 中的 cr3 就是 mm 中页表（ pgdir）的物理地址；而当它是内核线程的时候， cr3 等于 boot_cr3。 而 boot_cr3 指向了 ucore 启动时建立好的栈内核虚拟空间的页目录表首地址。

  7. kstack:每个进程都有一个内核桟，并且位于内核地址空间的不同位置。对于内核线程， 该桟就是运行时的程序使用的桟；而对于普通进程，该桟是发生特权级改变的时候使保存被打断的硬件信息用的桟。 Ucore 在创建进程时分配了 2 个连续的物理页作为内核栈的空间。这个桟很小，所以内核中的代码应该尽可能的紧凑，并且避免在桟上分配大的数据结构，以免桟溢出，导致系统崩溃。 kstack 记录了分配给该进程/线程的内核桟的位置。 

     1. 主要作用有以下几点: 
     2. 当内核准备从一个进程切换到另一个的时候，需要根据 kstack 的值正确的设置好 tss ，以便在进程切换以后再发生中断时能够使用正确的桟。
     3. 内核桟位于内核地址空间，并且是不共享的（每个进程/线程都拥有自己的内核桟），因此不受到 mm 的管理，当进程退出的时候，内核能够根据 kstack 的值快速定位桟的位置并进行回收。

  8. need_resched：是否需要调度

  #### alloc_proc()

  ```c
  alloc_proc(void) {
      struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
      if (proc != NULL) {
  
      //LAB4:EXERCISE1 YOUR CODE
      /*
       * below fields in proc_struct need to be initialized
       *       enum proc_state state;                      // Process state
       *       int pid;                                    // Process ID
       *       int runs;                                   // the running times of Proces
       *       uintptr_t kstack;                           // Process kernel stack
       *       volatile bool need_resched;                 // bool value: need to be rescheduled to release CPU?
       *       struct proc_struct *parent;                 // the parent process
       *       struct mm_struct *mm;                       // Process's memory management field
       *       struct context context;                     // Switch here to run process
       *       struct trapframe *tf;                       // Trap frame for current interrupt
       *       uintptr_t cr3;                              // CR3 register: the base addr of Page Directroy Table(PDT)
       *       uint32_t flags;                             // Process flag
       *       char name[PROC_NAME_LEN + 1];               // Process name
       */
  		proc->state = PROC_UNINIT;//设置进程为未初始化状态
          proc->pid = -1;       //未初始化的进程id=-1
          proc->runs = 0;       //初始化时间片
          proc->kstack = 0;     //初始化内存栈的地址
          proc->need_resched = 0;   //是否需要调度设为不需要
          proc->parent = NULL;      //置空父节点
          proc->mm = NULL;      //置空虚拟内存
          memset(&(proc->context), 0, sizeof(struct context));//初始化上下文
          proc->tf = NULL;      //中断帧指针设置为空
          proc->cr3 = boot_cr3;     //页目录设为内核页目录表的基址
          proc->flags = 0;      //初始化标志位
          memset(proc->name, 0, PROC_NAME_LEN);//置空进程名
      }
      return proc;
  }
  ```

### 练习2

> 为新创建的内核线程分配资源
>
> 创建一个内核线程需要分配和设置好很多资源。kernel_thread函数通过调用do_fork函数完成具体内核线程的创建工作。do_kernel函数会调用alloc_proc函数来分配并初始化一个进程控制块，但alloc_proc只是找到了一小块内存用以记录进程的必要信息，并没有实际分配这些资源。ucore一般通过do_fork实际创建新的内核线程。do_fork的作用是，创建当前内核线程的一个副本，他们呢的执行上下文、代码、数据都一样，但是存储位置不同。在这个过程中，需要给新内核线程分配资源，并且复制原进程的状态。
>
> ##### do_fork函数的大致执行步骤包括：
>
> 1. 调用alloc_proc，首先获得一块用户信息块。
> 2. 为进程分配一个内核栈。
> 3. 复制原进程的内存管理信息到新进程（但内核线程不必做此事）
> 4. 复制原进程上下文到新进程
> 5. 将新进程添加到进程列表
> 6. 唤醒新进程
> 7. 返回新进程号

程序

```c
/* do_fork -     parent process for a new child process
 * @clone_flags: used to guide how to clone the child process
 * @stack:       the parent's user stack pointer. if stack==0, It means to fork a kernel thread.
 * @tf:          the trapframe info, which will be copied to child process's proc->tf
 */
int
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
    int ret = -E_NO_FREE_PROC;
    struct proc_struct *proc;
    if (nr_process >= MAX_PROCESS) {
        goto fork_out;
    }
    ret = -E_NO_MEM;
    //LAB4:EXERCISE2 YOUR CODE
    /*
     * Some Useful MACROs, Functions and DEFINEs, you can use them in below implementation.
     * MACROs or Functions:
     *   alloc_proc:   create a proc struct and init fields (lab4:exercise1)
     *   setup_kstack: alloc pages with size KSTACKPAGE as process kernel stack
     *   copy_mm:      process "proc" duplicate OR share process "current"'s mm according clone_flags
     *                 if clone_flags & CLONE_VM, then "share" ; else "duplicate"
     *   copy_thread:  setup the trapframe on the  process's kernel stack top and
     *                 setup the kernel entry point and stack of process
     *   hash_proc:    add proc into proc hash_list
     *   get_pid:      alloc a unique pid for process
     *   wakeup_proc:  set proc->state = PROC_RUNNABLE
     * VARIABLES:
     *   proc_list:    the process set's list
     *   nr_process:   the number of process set
     */

    //    1. call alloc_proc to allocate a proc_struct
    //    2. call setup_kstack to allocate a kernel stack for child process
    //    3. call copy_mm to dup OR share mm according clone_flag
    //    4. call copy_thread to setup tf & context in proc_struct
    //    5. insert proc_struct into hash_list && proc_list
    //    6. call wakeup_proc to make the new child process RUNNABLE
    //    7. set ret vaule using child proc's pid
	
	//调用alloc_proc()函数申请分配内存块
	if ((proc = alloc_proc() == NULL)
	{
	goto fork_out;
	}
	
		//设置父节点为当前进程
	proc->parent = current;		
	//分配内核栈
	if (setup_kstack(proc) != 0) {
		goto bad_fork_cleanup_proc;		
	}
	//调用copy_mm()函数复制父进程的内存信息到子进程
	if (copy_mm(clone_flags,proc)!=0) {
		goto bad_fork_cleanup_kstack;
	//调用copy_thread()函数复制父进程的中断帧和上下文信息
	copy_thread(proc,stack,tf);
	
	bool intr_flag;
    local_intr_save(intr_flag);
    {
        proc->pid = get_pid();
        hash_proc(proc);//将新进程加入hash_list
        list_add(&proc_list, &(proc->list_link));//将新进程加入proc_list
        nr_process ++;//进程数加1
    }
    local_intr_restore(intr_flag);
    //唤醒进程，等待调度
    wakeup_proc(proc);
    //返回子进程的pid
    ret = proc->pid;
	
fork_out:
    return ret;

bad_fork_cleanup_kstack:
    put_kstack(proc);
bad_fork_cleanup_proc:
    kfree(proc);
    goto fork_out;
}
```



### 练习3

> 执行流程-执行第一个内核线程
>
> 1. begin schedule           
> 2. unable reschedule 
> 3. find a ready process 
> 4. begin execute initproc 
> 5. switch kstack 
> 6. switch page table 
> 7. switch context 
> 8. return

由于之前的`proc_init()`函数已经完成了 **idleproc* 和 **initproc** 内核线程的初始化。所在`kern_init()` 最后，它通过 `cpu_idle()`唤醒了0号 **idle** 进程,首先分析调度函数 `schedule()` 。

1. schedule（）

   ```c
   void
   schedule(void) {
       bool intr_flag;
       list_entry_t *le, *last;
       struct proc_struct *next = NULL;
       local_intr_save(intr_flag);
       {
           current->need_resched = 0;
           last = (current == idleproc) ? &proc_list : &(current->list_link);
           le = last;
           do {
               if ((le = list_next(le)) != &proc_list) {
                   next = le2proc(le, list_link);
                   if (next->state == PROC_RUNNABLE) {
                       break;
                   }
               }
           } while (le != last);
           if (next == NULL || next->state != PROC_RUNNABLE) {
               next = idleproc;
           }
           next->runs ++;
           if (next != current) {
               proc_run(next);
           }
       }
       local_intr_restore(intr_flag);
   }
   ```

   实验4只实现了一个最简单的FIFO调度器，其核心就是schedule函数。它的执行逻辑如下： 
   - 设置当前内核线程current->need_resched为 0; 
   - 在* proc_list* 队列中查找下一个处于就绪态的线程或进程 next; 
   - 找到这样的进程后，就调用 proc_run函数，保存当前进程 current 的执行现场(进程上下文)，恢复新进程的执行现场，完成进程切换。

     至此新的进程开始执行。由于只有两个内核线程，要让出CPU给initproc执行，即schedule 函数通过查找* proc_list 进程队列,只能找到一个处于就绪态的 initproc* 内核线程。于是通过 proc_run和进一步的 switch_to 函数完成两个执行现场的切换。

2. proc_run()

   ```c
   // proc_run - make process "proc" running on cpu
   // NOTE: before call switch_to, should load  base addr of "proc"'s new PDT
   void
   proc_run(struct proc_struct *proc) {
       if (proc != current) {
           bool intr_flag;
           struct proc_struct *prev = current, *next = proc;
           local_intr_save(intr_flag);
           {
               current = proc;
               load_esp0(next->kstack + KSTACKSIZE);
               lcr3(next->cr3);
               switch_to(&(prev->context), &(next->context));
           }
           local_intr_restore(intr_flag);
       }
   }
   ```

   1. 让 current 指向 next 内核线程 initproc；
   2. 设置任务状态段* ts* 中特权态 0 下的栈顶指针 esp0为 next 内核线程* initproc* 的内核栈的栈顶，即next->kstack + KSTACKSIZE；
   3. 设置 CR3 寄存器的值为* next* 内核线程* initproc* 的页目录表起始地址 next->cr3，这实际上是完成进程间的页表切换；
   4. 由switch_to函数完成具体的两个线程的执行现场切换，即切换各个寄存器，当 switch_to函数执行完“ret”指令后，就切换到initproc执行了。

   <u>在页表设置方面，考虑到以后的进程有各自的页表，其起始地址各不相同，只有完成页表切换，才能确保新的进程能够正确执行。</u>

3. switch_to()

   ```assembly
   .text
   .globl switch_to
   switch_to:                      # switch_to(from, to)
   
       # save from's registers
       movl 4(%esp), %eax          # eax points to from
       popl 0(%eax)                # save eip !popl
       movl %esp, 4(%eax)          # save esp::context of from
       movl %ebx, 8(%eax)          # save ebx::context of from
       movl %ecx, 12(%eax)         # save ecx::context of from
       movl %edx, 16(%eax)         # save edx::context of from
       movl %esi, 20(%eax)         # save esi::context of from
       movl %edi, 24(%eax)         # save edi::context of from
       movl %ebp, 28(%eax)         # save ebp::context of from
   
       # restore to's registers
       movl 4(%esp), %eax          # not 8(%esp): popped return address already
                                   # eax now points to to
       movl 28(%eax), %ebp         # restore ebp::context of to
       movl 24(%eax), %edi         # restore edi::context of to
       movl 20(%eax), %esi         # restore esi::context of to
       movl 16(%eax), %edx         # restore edx::context of to
       movl 12(%eax), %ecx         # restore ecx::context of to
       movl 8(%eax), %ebx          # restore ebx::context of to
       movl 4(%eax), %esp          # restore esp::context of to
   
       pushl 0(%eax)               # push eip
   
       ret
   ```

   - 然后接下来的七条汇编指令完成了保存前一个进程的其他 7 个寄存器到 context 中的相应成员变量中。至此前一个进程的执行现场保存完毕。 再往后是恢复向一个进程的执行现场，这其实就是上述保存过程的逆执行过程，即从** context 的高地址的成员变量 **ebp 开始，逐一把相关域的值赋值给对应的寄存器。 

   - pushl 0(%eax)其实把* context* 中保存的下一个进程要执行的指令地址 context.eip 放到了堆栈顶，这样接下来执行最后一条指令“ret”时,会把栈顶的内容赋值给 EIP 寄存器，这样就切换到下一个进程执行了，即当前进程已经是下一个进程了，从而完成了进程的切换。
