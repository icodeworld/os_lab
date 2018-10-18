<!-- TOC -->

- [Lab 7](#lab-7)
    - [练习1](#练习1)
        - [同步互斥的设计与实现](#同步互斥的设计与实现)
    - [练习2](#练习2)

<!-- /TOC -->

# Lab 7

## 练习1

> ##### 理解内核级信号量的实现和基于内核级信号量的哲学家就餐问题（不需要编码）
>
> 1. 请在实验报告中给出内核级信号量的设计描述，并说其大致流程。
> 2. 请在实验报告中给出给用户态进程/线程提供信号量机制的设计方案，并比较说明给内核级提供信号量机制的异同。

简单说明如下：

1. kern/schedule/{sched.h,sched.c}: 增加了定时器（timer）机制，用于进程/线程的do_sleep功能。
2. kern/sync/sync.h: 去除了lock实现（这对于不抢占内核没用）。
3. kern/sync/wait.[ch]: 定义了等待队列wait_queue结构和等待entry的wait结构以及在此之上的函数，这是ucore中的信号量semophore机制和条件变量机制的基础，在本次实验中你需要了解其实现。
4. kern/sync/sem.[ch]:定义并实现了ucore中内核级信号量相关的数据结构和函数，本次试验中你需要了解其中的实现，并基于此完成内核级条件变量的设计与实现。
5. user/ libs/ {syscall.[ch],ulib.[ch] }与kern/sync/syscall.c：实现了进程sleep相关的系统调用的参数传递和调用关系。
6. user/{ sleep.c,sleepkill.c}: 进程睡眠相关的一些测试用户程序。
7. kern/sync/monitor.[ch]:基于管程的条件变量的实现程序，在本次实验中是练习的一部分，要求完成。
8. kern/sync/check_sync.c：实现了基于管程的哲学家就餐问题，在本次实验中是练习的一部分，要求完成基于管程的哲学家就餐问题。
9. kern/mm/vmm.[ch]：用信号量mm_sem取代mm_struct中原有的mm_lock。（本次实验不用管）

### 同步互斥的设计与实现

- 实验七设计实现了多种同步互斥手段，包括时钟中断管理、等待队列、信号量、管程机制（包含条件变量设计）等，并基于信号量实现了哲学家问题的执行过程。而本次实验的练习是要求用管程机制实现哲学家问题的执行过程。

1. ### 底层支撑

   由于有处理器调度的存在，且进程在访问某类资源暂时无法满足的情况下，进程会进入等待状态。这导致了多进程执行时序的不确定性和潜在执行结果的不确定性。为了确保执行结果的正确性，本试验需要设计更加完善的进程等待和互斥的底层支撑机制，确保能正确提供基于信号量和条件变量的同步互斥机制。根据操作系统原理的知识，我们知道如果没有在硬件级保证读内存-修改值-写回内存的原子性，我们只能通过复杂的软件来实现同步互斥操作。但由于有定时器、屏蔽/使能中断、等待队列wait_queue支持test_and_set_bit等原子操作机器指令（在本次实验中没有用到）的存在，使得我们在实现进程等待、同步互斥上得到了极大的简化。下面将对定时器、屏蔽/使能中断和等待队列进行进一步讲解。

   1. #### 定时器

      在传统的操作系统中，定时器是其中一个基础而重要的功能.它提供了基于时间事件的调度机制。在ucore 中，时钟（timer）中断给操作系统提供了有一定间隔的时间事件，操作系统将其作为基本的调度和计时单位（我们记两次时间中断之间的时间间隔为一个时间片，timersplice）。基于此时间单位，操作系统得以向上提供基于时间点的事件，并实现基于时间长度的睡眠等待和唤醒机制。在每个时钟中断发生时，操作系统产生对应的时间事件。应用程序或者操作系统的其他组件可以以此来构建更复杂和高级的进程管理和调度算法。本次实验中定时器的数据结构：

      ```c
      typedef struct {
          unsigned int expires;
          struct proc_struct *proc;
          list_entry_t timer_link;
      } timer_t;
      ```

   2. #### 屏蔽和使能中断

      在ucore中提供的底层机制包括中断屏蔽/使能控制等。kern/sync.c中实现的开关中断的控制函数local_intr_save(x)和local_intr_restore(x)，它们是基于kern/driver文件下的intr_enable()、intr_disable()函数实现的。具体调用关系为：

      ```assembly
      关中断：local_intr_save --> __intr_save --> intr_disable --> cli
      开中断：local_intr_restore--> __intr_restore --> intr_enable --> sti
      ```

      最终的cli和sti是x86的机器指令，最终实现了关（屏蔽）中断和开（使能）中断，即设置了eflags寄存器中与中断相关的位。通过关闭中断，可以防止对当前执行的控制流被其他中断事件处理所打断。既然不能中断，那也就意味着在内核运行的当前进程无法被打断或被重新调度，即实现了对临界区的互斥操作。所以在单处理器情况下，可以通过开关中断实现对临界区的互斥保护，需要互斥的临界区代码的一般写法为：

      ```assembly
      local_intr_save(intr_flag);
      {
      临界区代码
      }
      local_intr_restore(intr_flag);
      ……
      ```

      由于目前ucore只实现了对单处理器的支持，所以通过这种方式，就可简单地支撑互斥操作了。在多处理器情况下，这种方法是无法实现互斥的，因为屏蔽了一个CPU的中断，只能阻止本地CPU上的进程不会被中断或调度，并不意味着其他CPU上执行的进程不能执行临界区的代码。所以，开关中断只对单处理器下的互斥操作起作用。在本实验中，开关中断机制是实现信号量等高层同步互斥原语的底层支撑基础之一。

   3. #### 等待队列

      在课程中提到用户进程或内核线程可以转入等待状态以等待某个特定事件（比如睡眠,等待子进程结束,等待信号量等），当该事件发生时这些进程能够被再次唤醒。内核实现这一功能的一个底层支撑机制就是等待队列wait_queue，等待队列和每一个事件（睡眠结束、时钟到达、任务完成、资源可用等）联系起来。需要等待事件的进程在转入休眠状态后插入到等待队列中。当事件发生之后，内核遍历相应等待队列，唤醒休眠的用户进程或内核线程，并设置其状态为就绪状态（PROC_RUNNABLE），并将该进程从等待队列中清除。ucore在kern/sync/{ wait.h,wait.c }中实现了等待项wait结构和等待队列wait queue结构以及相关函数），这是实现ucore中的信号量机制和条件变量机制的基础，进入wait queue的进程会被设为等待状态（PROC_SLEEPING），直到他们被唤醒。

      ```c
      typedef struct {
      struct proc_struct *proc; 		//等待进程的指针
      uint32_t wakeup_flags; //进程被放入等待队列的原因标记
      wait_queue_t *wait_queue;	 	//指向此wait结构所属于的wait_queue
      list_entry_t wait_link; 		//用来组织wait_queue中wait节点的连接
      } wait_t;
      
      typedef struct {	
      list_entry_t wait_head;	 		//wait_queue的队头
      } wait_queue_t;
      
      le2wait(le, member)		 		//实现wait_t中成员的指针向wait_t 指针的转化
      
      ```

2. ### 信号量

   信号量是一种同步互斥机制的实现，普遍存在于现在的各种操作系统内核里。相对于spinlock的应用对象，信号量的应用对象是在临界区中运行的时间较长的进程。等待信号量的进程需要睡眠来减少占用CPU的开销。信号量的数据结构定义如下：

   ```c
   typedef struct {
   int value; //信号量的当前值
   wait_queue_t wait_queue; //信号量对应的等待队列
   } semaphore_t;
   ```

   在ucore中最重要的信号量操作是P操作函数down(semaphore_t *sem)和V操作函数up(semaphore_t *sem)。但这两个函数的具体实现是__down(semaphore_t *sem, uint32_twait_state) 函数和__up(semaphore_t *sem, uint32_t wait_state)函数，二者的具体实现描述如下：

   up(semaphore_t *sem)。但这两个函数的具体实现是__down(semaphore_t *sem, uint32_t

   wait_state) 函数和__up(semaphore_t *sem, uint32_t wait_state)函数，二者的具体实现描述

   如下：

   -  __down(semaphore_t *sem, uint32_t wait_state, timer_t *timer)：具体实现信号量的P操作，首先关掉中断，然后判断当前信号量的value是否大于0。如果是>0，则表明可以获得信号量，故让value减一，并打开中断返回即可；如果不是>0，则表明无法获得信号量，故需要将当前的进程加入到等待队列中，并打开中断，然后运行调度器选择另外一个进程执行。如果被V操作唤醒，则把自身关联的wait从等待队列中删除（此过程需要先关中断，完成后开中断）。具体实现如下所示：

     ```
     static __noinline uint32_t __down(semaphore_t *sem, uint32_t wait_state) {
     bool intr_flag;
     local_intr_save(intr_flag);
     if (sem->value > 0) {
     sem->value --;
     local_intr_restore(intr_flag);
     return 0;
     }
     wait_t __wait, *wait = &__wait;
     wait_current_set(&(sem->wait_queue), wait, wait_state);
     local_intr_restore(intr_flag);
     schedule();
     local_intr_save(intr_flag);
     wait_current_del(&(sem->wait_queue), wait);
     local_intr_restore(intr_flag);
     if (wait->wakeup_flags != wait_state) {
     return wait->wakeup_flags;
     }
     return 0;
     }
     ```

   - __up(semaphore_t *sem, uint32_t wait_state)：具体实现信号量的V操作，首先关中断，如果信号量对应的wait queue中没有进程在等待，直接把信号量的value加一，然后开中断返回；如果有进程在等待且进程等待的原因是semophore设置的，则调用wakeup_wait函数将waitqueue中等待的第一个wait删除，且把此wait关联的进程唤醒，最后开中断返回。具体实现如下所示：

     ```c
     static __noinline void __up(semaphore_t *sem, uint32_t wait_state) {
     bool intr_flag;
     local_intr_save(intr_flag);
     {
     wait_t *wait;
     if ((wait = wait_queue_first(&(sem->wait_queue))) == NULL) {
     sem->value ++;
     }
     else {
     wakeup_wait(&(sem->wait_queue), wait, wait_state, 1);
     }
     }
     local_intr_restore(intr_flag);
     }
     ```

     > 我们可以看出信号量的计数器value具有有如下性质：
     > value>0，表示共享资源的空闲数
     > vlaue<0，表示该信号量的等待队列里的进程数
     > value=0，表示等待队列为空

3. ### 管程和条件变量

   引入了管程是为了将对共享资源的所有访问及其所需要的同步操作集中并封装起来。Hansan为管程所下的定义：“一个管程定义了一个数据结构和能为并发进程所执行（在该数据结构上）的一组操作，这组操作能同步进程和改变管程中的数据”。有上述定义可知，管程由四部分组成：

   1. 管程内部的共享变量；
   2. 管程内部的条件变量；
   3. 管程内部并发执行的进程；
   4. 对局部于管程内部的共享数据设置初始值的语句。

   局限在管程中的数据结构，只能被局限在管程的操作过程所访问，任何管程之外的操作过程都不能访问它；另一方面，局限在管程中的操作过程也主要访问管程内的数据结构。由此可见，管程相当于一个隔离区，它把共享变量和对它进行操作的若干个过程围了起来，所有进程要访问临界资源时，都必须经过管程才能进入，而管程每次只允许一个进程进入管程，从而需要确保进程之间互斥。

   1. 关键数据结构

      ucore中的管程机制是基于信号量和条件变量来实现的。

      - ucore中的管程的数据结构monitor_t定义如下：

        ```c
        typedef struct monitor{
        semaphore_t mutex; // the mutex lock for going into the routines in monitor,
        should be initialized to 1
        // the next semaphore is used to
        // (1) procs which call cond_signal funciton should DOWN next sema after UP cv.
        sema
        // OR (2) procs which call cond_wait funciton should UP next sema before DOWN cv.s
        ema
        semaphore_t next;
        int next_count; // the number of of sleeped procs which cond_signal funcit
        on
        condvar_t *cv; // the condvars in monitor
        } monitor_t;
        ```

        管程中的成员变量mutex是一个二值信号量，是实现每次只允许一个进程进入管程的关键元素，确保了互斥访问性质。管程中的条件变量cv通过执行wait_cv ，会使得等待某个条件Cond为真的进程能够离开管程并睡眠，且让其他进程进入管程继续执行；而进入管程的某进程设置条件Cond为真并执行signal_cv 时，能够让等待某个条件Cond为真的睡眠进程被唤醒，从而继续进入管程中执行。
        注意：管程中的成员变量信号量next和整型变量next_count是配合进程对条件变量cv的操作而设置的，这是由于发出signal_cv 的进程A会唤醒由于wait_cv 而睡眠的进程B，由于管程中只允许一个进程运行，所以进程B执行会导致唤醒进程B的进程A睡眠，直到进程B离开管程，进程A才能继续执行，这个同步过程是通过信号量next完成的；而next_count表示了由于发出singal_cv 而睡眠的进程个数。

      - 管程中的条件变量的数据结构condvar_t定义如下：

        ```c
        typedef struct condvar{
        semaphore_t sem; // the sem semaphore is used to down the waiting proc, and th
        e signaling proc should up the waiting proc
        int count; 　// the number of waiters on condvar
        monitor_t * owner; // the owner(monitor) of this condvar
        } condvar_t;
        ```

        条件变量的定义中也包含了一系列的成员变量，信号量sem用于让发出wait_cv 操作的等待某个条件Cond为真的进程睡眠，而让发出signal_cv 操作的进程通过这个sem来唤醒睡眠的进程。count表示等在这个条件变量上的睡眠进程的个数。owner表示此条件变量的宿主是哪个管程。

   2. 条件变量的signal和wait的设计 

      函数cond_wait(condvar_t *cvp,semaphore_t *mp) 和cond_signal (condvar_t *cvp) 的实现原理参考了《OS Concept》一书中的6.7.3小节“用信号量实现管程”的内容。

      1. wait_cv 的原理实现：

         ```c
         cv.count++;
         if(monitor.next_count > 0)
         sem_signal(monitor.next);
         else
         sem_signal(monitor.mutex);
         sem_wait(cv.sem);
         cv.count -- ;
         ```

      2. signal_cv的原理实现：

         ```c
         if( cv.count > 0) {
         monitor.next_count ++;
         sem_signal(cv.sem);
         sem_wait(monitor.next);
         monitor.next_count -- ;
         }
         ```

## 练习2

> ##### 完成内核级条件变量和基于内核级条件变量的哲学家就餐问题（需要编码）
>
> 执行：make grade。如果所显示的应用程序检测都输出OK，则基本正确。如果只是某程序过不去，比如matrix.c，则可执行make run-matrix

如上分析，只需修改cond_signal (condvar_t *cvp)、cond_wait (condvar_t *cvp)、phi_take_forks_condvar(int i)、phi_put_forks_condvar(int i)

1. cond_signal (condvar_t *cvp)

   ```c
   void cond_signal (condvar_t *cvp) {
      //LAB7 EXERCISE1: YOUR CODE
      cprintf("cond_signal begin: cvp %x, cvp->count %d, cvp->owner->next_count %d\n", cvp, cvp->count, cvp->owner->next_count);  
     /*
      *      cond_signal(cv) {
      *          if(cv.count>0) {
      *             mt.next_count ++;
      *             signal(cv.sem);
      *             wait(mt.next);
      *             mt.next_count--;
      *          }
      *       }
      */
      if(cvp->count > 0) {
   	   cvp->owner->next_count ++;
   	   up(&(cvp->sem));
   	   down(&(cvp->owner->next));
   	   cvp->owner->next_count --;
      }
      cprintf("cond_signal end: cvp %x, cvp->count %d, cvp->owner->next_count %d\n", cvp, cvp->count, cvp->owner->next_count);
   }
   ```

2. cond_wait (condvar_t *cvp)

   ```c
   void
   cond_wait (condvar_t *cvp) {
       //LAB7 EXERCISE1: YOUR CODE
       cprintf("cond_wait begin:  cvp %x, cvp->count %d, cvp->owner->next_count %d\n", cvp, cvp->count, cvp->owner->next_count);
      /*
       *         cv.count ++;
       *         if(mt.next_count>0)
       *            signal(mt.next)
       *         else
       *            signal(mt.mutex);
       *         wait(cv.sem);
       *         cv.count --;
       */
   	cvp->count ++;
   	if(cvp->owner->next_count > 0)
   		up(&(cvp->owner->next));
   	else
   		up(&(cvp->owner->mutex));
   	down(&(cvp->sem));
   	cvp->count --;
       cprintf("cond_wait end:  cvp %x, cvp->count %d, cvp->owner->next_count %d\n", cvp, cvp->count, cvp->owner->next_count);
   }
   ```

3. phi_take_forks_condvar(int i)

   ```c
   void phi_take_forks_condvar(int i) {
        down(&(mtp->mutex));						//进入管程
   	 
   //--------into routine in monitor--------------
        // LAB7 EXERCISE1: YOUR CODE
        // I am hungry
        // try to get fork
   	 
   	 // I am hungry
   	 state_condvar[i]=HUNGRY; 
   	 
   	 //try to get fork，尝试测试左邻右舍
   	  phi_test_condvar(i); 
         if (state_condvar[i] != EATING) {
             cprintf("phi_take_forks_condvar: %d didn't get fork and will wait\n",i);
             cond_wait(&mtp->cv[i]);
         }
   	  
   //--------leave routine in monitor--------------
         if(mtp->next_count>0)
            up(&(mtp->next));						//唤醒等待队列中的一个进程B	
         else
            up(&(mtp->mutex));						//唤醒由于互斥条件限制而无法进入管程的进程
   }
   ```

4. phi_put_forks_condvar(int i)

   ```c
   void phi_put_forks_condvar(int i) {
        down(&(mtp->mutex));
   
   //--------into routine in monitor--------------
        // LAB7 EXERCISE1: YOUR CODE
        // I ate over
        // test left and right neighbors
   	 
   	 //I ate over 
   	 state_condvar[i]=THINKING;
   	 
   	 // test left and right neighbors
         phi_test_condvar(LEFT);
         phi_test_condvar(RIGHT);
   //--------leave routine in monitor--------------
        if(mtp->next_count>0)
           up(&(mtp->next));
        else
           up(&(mtp->mutex));
   }
   ```

