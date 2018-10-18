## lab 3

1. 题目

1. 问题分析

   当启动分页机制后，如果一条指令或者数据的虚拟地址所对应的物理页不在内存，或者访问权限不够，那么就会产生页错误异常。其具体原因有以下三点：

   1. 页表项全为0——虚拟地址与物理地址未建立映射关系或已被撤销。
   2. 物理页面不在内存中——需要进行换页机制。
   3. 访问权限不够——应当报错。

   当出现上面情况之一,那么就会产生页面page fault(#PF)异常。产生异常的线性地址存储在 
   CR2中,并且将是page fault的产生类型保存在 error code 中