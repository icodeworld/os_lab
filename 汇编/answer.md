# Assemble Language

## [Chapter 2]()

1. 检测点2.1

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

   也即当段地址给定<u>less than1001H or more than 2000H</u>时，CPU无论怎么变化偏移值都无法寻到20000H单元。

3. 检测点2.3

   下面的3条指令执行后，CPU几次修改IP？都是在什么时候？最后IP中的值是什么？

   ```assembly
   mov ax,bx
   sub ax,ax
   jmp ax
   ```

   all times is four times.The first times changes after reading 1 instruction.The second times changes after reading 2 instruction.The third times changes after reading 3 instruction.the last times changes after performing 3 instruction.在执行完jmp ax后。最后IP中的值是0。

4. laboratory task

   (1)Use Debug to write the following procedure segmentation into the memory,performing line by line,at the same time, watching the change regard the contents of relative registers.

   ![1537367338769](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537367338769.png)

   ![1537367398520](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537367398520.png)

   ![1537367780423](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537367780423.png)

   ![1537368417040](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537368417040.png)

    -a

   ![1537426960490](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537426960490.png)

   ![1537426993151](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537426993151.png)

   ...

   CS:IP always points to the next instruction that is to perform.

   (2)

   ```assembly
   mov ax,1
   add ax,ax
   jmp 2000:0003
   ```

   the result:

   ![1537430223830](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537430223830.png)

   ![1537430325118](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537430325118.png)

   can't revise the data.

   ![1537430490117](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537430490117.png)


## [Chapter 3]()





1. test 3.1

   (1)![1537434050330](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537434050330.png)

   ```assembly
   mov ax,1
   
   mov ds,ax
   
   mov ax,[0000]  ax= 2662H 
   
   mov bx,[0001]  bx= E626H 
   
   mov ax,bx      ax= E626H 
   
   mov ax,[0000]  ax= 2662H 
   
   mov bx,[0002]  bx= D6E6H 
   
   add ax,bx      ax= FD48H 
   
   add ax,[0004]  ax= 2C14H 
   
   mov ax,0       ax=   0   
   
   mov al,[0002]  ax= 00e6H 
   
   mov bx,0       bx=   0   
   
   mov bl,[000c]  bx= 0026H 
   
   add al,bl      ax= 000CH 
   ```

   (2)![1537434559944](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537434559944.png)

   ![1537434577965](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537434577965.png)

   ```assembly
   mov ax,6622H	cs= 2000H   ip= 0003H   ds= 1000H   ax= 6622H 	bx= 0
   jmp 0ff0:0100    	0ff0H		0100H  		1000H		6622H		0	
   mov ax,2000H		0ff0H		0103H		1000H		2000H		0
   mov ds,ax			0ff0H		0105H		2000H		2000H		0
   mov ax,[0008]		0ff0H		0108H		2000H		C389H		0
   mov ax,[0002]		0ff0H		010BH		2000H		EA66H		0
   ```

   ![1537435878321](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537435878321.png)

   ![1537436200904](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537436200904.png)

   There are no differences between data and procedure.

   ```assembly
   3.8
   mov ax,1000H
   mov ss,ax
   mov sp,0010H               //init the stack top
   
   mov ax,001AH
   mov bx,001BH              //give value
   
   push ax
   push bx				      //bx is at the top
   
   pop ax
   pop bx					  //exchange
   
   3.10
   mov ax,1000H
   mov ss,ax
   mov sp,2                  //need attention
   
   mov ax,2266H
   push ax
   ```

2. test 3.2

   ![1537447243665](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537447243665.png)

   ```assembly
   mov ax,1000H
   mov ds,ax
   
   mov bx,2000H
   mov ss,bx
   mov sp,0010H
   
   push [0]
   push [2]
   push [4]
   push [6]
   push [8]
   push [a]
   push [b]
   push [c]
   push [e]
   
   
   (2)just need revise the ss 
   mov bx,1000H
   mov ss,bx
   mov sp,0   //need attention
   ```

3. laboratory 2

   ```assembly
   mov ax,ffff
   mov ds,ax
   
   mov ax,2200
   mov ss,ax
   
   mov sp,0100
   
   mov ax,[0]          ;ax=C0EAH
   add ax,[2]			;ax=C0FCH
   mov bx,[4]			;bx=30F0H
   add bx,[6]			;bx=6021H
   
   push ax				;sp=00FEH; the address of revised store unit is 220FEH, the content is C0FCH 
   push bx				;sp=00FCH; the address of revised store unit is 220FCH, the content is 6021H 
   pop ax				;sp=00FEH; ax=6021H
   pop bx				;sp=0100H; bx=C0FCH
   
   push [4]			;sp=00FEH; the address of revised store unit is 220FEH, the content is 30F0H 
   push [6]			;sp=00FCH; the address of revised store unit is 220FCH ,the content is 2F31H
   ```

4. 








