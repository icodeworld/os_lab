## 第二章

1. ##### 检测点2.1

   (1)写出每条汇编指令执行后相关寄存器中的值。

   mov  ax,62627		AX=0xF3A3H

   mov  ah,31H			AX=    31A3H

   mov  al, 23h			AX=    3123H

   add   ax,ax			AX=    6246H

   mov  bx,826CH		BX=	   826CH

   mov  cx,ax			CX=    6246H

   mov  ax,bx			AX=    826CH

   add   ax,bx			AX=    04D8H(overflow)

   mov  al, bh			AX=	   0482H

   mov  ah,bl			AX=     6C82H

   add   ah,ah			AX=0xD882H

   add	  al, 6 			AX=0xD888H

   add   al, al   			AX=0xD810H(overflow)

   mov  ax,cx			AX=     6246H

   (2)只能使用目前学过的汇编指令，最多使用4条指令，编程计算2的4次方。

   mov ax,2			AX=2

   add ax,ax			AX=4

   add ax,ax			AX=8

   add ax,ax			AX=16

2. 检测点2.2

   (1)给定段地址为0001H，仅通过变化便宜地址寻址，CPU的寻址范围是<u>00010H~1000FH</u>。

   (2)有一数据存放在内存20000H单元中，现给定段地址为SA,若想用偏移地址寻到此单元。则SA应满足的条件是：最小为<u>1001H</u>，最大为<u>2000H</u>。

   也即当段地址给定<u>1000H</u>时，CPU无论怎么变化偏移值都无法寻到20000H单元。

3. 检测点2.3

   下面的3条指令执行后，CPU几次修改IP？都是在什么时候？最后IP中的值是什么？

   ```assembly
   mov ax,bx
   sub ax,ax
   jmp ax
   ```

   一次修改IP,在执行完jmp ax后。最后IP中的值是0。

4. laboratory task

   (1)Use Debug to write the following procedure segmentation into the memory,performing line by line,at the same time, watching the change regard the contents of relative registers.

   ![1537367179710](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537367179710.png)

   ![1537367338769](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537367338769.png)

   ![1537367398520](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537367398520.png)

   ![1537367780423](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537367780423.png)

   ![1537368417040](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537368417040.png)

5. 

6. 



