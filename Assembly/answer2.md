## Chapter 11

1. test11.1

   > 写出下面每条指令执行后,ZF.PF.SF等标志位的值
   >
   > sub al,al		ZF=1	  PF=1	  SF=0
   >
   > mov al,1                1		1		0(有问题)
   >
   > push ax 			1		1		0
   >
   > pop	  bx			1		1		0
   >
   > add  al,bl		0		0              0
   >
   > add al,10		0       	1		0
   >
   > mul al			0		1		0
   >
   >
   >
   > -  PF是flag的第2位，奇偶标志位，记录指令执行后结果二进制中1的个数是否为偶数，结果为偶数时，PF=1
   >
   > - ZF是flag的第6位，零标志位，记录指令执行后结果是否为0，结果为0时，ZF=1
   >
   > -  SF是flag的第7位，符号标志位，记录有符号运算结果是否为负数，结果为负数时，SF=1
   >
   >  add、sub、mul、div 、inc、or、and等运算指令影响标志寄存器
   >
   >  mov、push、pop等传送指令对标志寄存器没影响。

   ![1538225007332](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1538225007332.png)

2. test 11.2

   > ​				CF			OF			SF			ZF			PF
   >
   > sub al,al			0			0			0			1			1
   >
   > mov al,10h		0			0			0			1			1	
   >
   > add al,90h		0			0			1			0			1
   >
   > mov al,80h		0			0			1			0			1
   >
   > add al,80h		1			1			0			1			1
   >
   > mov al,0fch		1			1			0			1			1
   >
   > add al,05h		1			0			0			0			0
   >
   > mov al,7dh		1			0			0			0			0
   >
   > add al,0bh 		0			1			1			0			1
   >
   >
   >
   > 检测点涉及的相关内容：
   >
   > -  CF是flag的第0位，进位标志位，记录无符号运算结果是否有进/借位，结果有进/借位时，SF=1
   >
   > -  PF是flag的第2位，奇偶标志位，记录指令执行后结果二进制数中1的个数是否为偶数，结果为偶数时，PF=1 
   >
   > -  ZF是flag的第6位，零标志位，记录指令执行后结果是否为0，结果为0时，ZF=1 
   >
   > -  SF是flag的第7位，符号标志位，记录有符号运算结果是否为负数，结果为负数时，SF=1 
   >
   > -  OF是flag的第11位，溢出标志位，记录有符号运算结果是否溢出，结果溢出时，OF=1
   >
   >  add、sub、mul、div 、inc、or、and等运算指令影响flag
   >
   >  mov、push、pop等传送指令对flag没影响

   ![1538291451642](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1538291451642.png)

   ![1538295448326](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1538295448326.png)

   ![1538295469723](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1538295469723.png)

3. test 11.3

   ```assembly
   ;统计F000:0处32个字节中,大小在[32,128]的数据的个数
   assume cs:code
   code segment
   start:
   mov	ax,0f000h
   mov ds,ax
   
   mov bx,0
   mov dx,0		;初始化累加器
   mov cx,32
   
   s:	mov al,ds:[bx]
   	cmp al,32	
   	jb  s0		;当小于32,跳到s0,继续循环
   	cmp al,128
   	ja  s0		;当大于128,跳到s0,继续循环
   	inc dx
   s0: inc bx
   	loop s
   	
   	mov ax,4c00h
   	int 21h
   		
   code ends
   end start
   
   ;统计F000:0处32个字节中,大小在(32,128)的数据的个数
   assume cs:code
   code segment
   start:
   mov	ax,0f000h
   mov ds,ax
   
   mov bx,0
   mov dx,0		;初始化累加器
   mov cx,32
   
   s:	mov al,ds:[bx]
   	cmp al,32	
   	jna  s0		;当不大于32,跳到s0,继续循环
   	cmp al,128
   	jnb  s0		;当不小于128,跳到s0,继续循环
   	inc dx
   s0: inc bx
   	loop s
   	
   	mov ax,4c00h
   	int 21h
   		
   code ends
   end start
   ```

4. test 11.4

   ```assembly
   mov ax,0				;ax=0
   push ax					;
   popf					;
   mov ax,0fff0h			;ax=fff0h 
   add ax,0010h			;
   pushf					;
   pop ax					;ax=0047h   因为flag寄存器中的次低位(第1bit)为1
   and al,11000101B		;ax=0045h	与SF ZF PF CF 相与
   and ah,00001000B		;ax=0045h
   ```

### lab 11

1. 转换大写

   ```assembly
   assume cs:code
   
   data segment
   	db "Beginner's All-purpose Symbolic Instruction Code.",0
   data ends
   
   code segment
   	begin:
   			mov ax,data
   			mov ds,ax
   			mov si,0	;ds:si同时指向源以及目的地址
   			call letterc
   			
   			mov ax,4c00h
   			int 21h
   	
   	;名称;letterc
   	;功能:将以0结尾的字符串中的小写字母转变为大写字母
   	;参数:ds:si指向字符串的首地址
   
   	letterc:
   			push si
   			push cx
   			
   		s1: push cx
   			mov cx,ds:[si]
   			jcxz ok		;当为0时,则结束循环
   			and byte ptr ds:[si],11011111B;否则,转换为大写
   			inc si
   			pop cx
   			loop s1
   		ok:
   			pop cx
   			pop si
   			ret
   		
   code ends
   end begin
   ```

   ![1538300660264](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1538300660264.png)

## Chapter 12

-  我们如何让一个内存单元成为栈顶?将它的地址放入SS:SP中
- 我们如何让一个内存单元中的信息被CPU当做指令来执行?将它的地址放入CS:IP中
- 我们如何让一段程序成为N号中断的中断处理程序?将它的入口地址放入中断向量表的N号表项中偏移地址放入0:4N字单元中,段地址放入0:4N+2字单元中

1. test 12.1

   > <img src=http://thyrsi.com/t6/378/1538301220x-1566688526.png />
   >
   > (1)0070:018b
   >
   > (2)<u>4N</u>    <u>0000</u>

2. 中断的详细过程

   > 中断过程(中断向量:中断处理程序的入口地址)
   >
   > 1. 取得中断类型码N
   > 2. pushf
   > 3. TF=0,IF=0
   > 4. push CS
   > 5. push IP
   > 6. (IP)=(N * 4)   (CS)=(N * 4+2)
   >
   > 中断处理程序
   >
   > 1. 保存用到的寄存器
   > 2. 处理中断
   > 3. 恢复用到的寄存器
   > 4. 用iret指令返回   pop IP  pop CS   popf
   >
   > 编写0号中断向量中断处理程序
   >
   > 1. 编写可以显示"overflow!"的中断处理程序:do0:
   > 2. 将do0送入内存0000:0200处
   > 3. 将do0的入口地址0000:0200存储在中断向量表0号表项中
   >
   >

3. 基本流程

   ```assembly
   assume cs:code
   
   code segment
   start: do0安装程序
   		设置中断向量表
   		mov ax,4c00h
   		int 21h
   
   do0:    保存现场
   		显示字符串"overflow!"
   		恢复现场
   		mov ax,4c00h
   		int 21h
   		
   code ends
   
   end start
   ```

### lab 12

1. example

   ```assembly
   assume cs:code
   
   code segment
   
   start: 
   		mov ax,cs
   		mov ds,ax
   		mov si,offset do0	;设置ds:si指向源地址
   		
   		mov ax,0			
   		mov es,ax
   		mov di,200h			;设置es:di指向目的地址
   		
   		mov cx,offset do0end-offset do0			;设置cx为传输长度,利用编译器来计算do0长度;
   		;因为汇编编译器可以处理表达式
   		
   		cld					;设置传输方向为正
   
   		rep movsb
   		
   		
   		mov ax,0
   		mov es,ax
   		mov word ptr es:[0*4],200h
   		mov word ptr es:[0*4+2],0   ;设置中断向量表
   		
   		mov ax,4c00h
   		int 21h
   		
   	do0:jmp short do0start	;指令占2B
   		db "overflow!"
   		
   do0start:
   		mov ax,cs
   		mov ds,ax
   		mov si,202h		;设置ds:si指向字符串(字符串存放在代码段中,偏移地址,0:200处的指令为jmp short do0start,这条指令占两个字节,所以"overflow!"的偏移地址为202h
   		
   		mov ax,0b800h
   		mov es,ax
   		mov di,12*160+36*2 ;设置es:di指向显存空间的中间位置
   		
   		mov cx,9		;设置显示字符串长度
   	 s: mov al,ds:[si]
   		mov es:[di],al
   		inc si
   		add di,2
   		loop s
   		
   		mov ax,4c00h
   		int 21h		;用来返回DOS的
   	
   do0end:nop
   		
   code ends
   end start
   ```

2. 实验源码

   ```assembly
   assume cs:code
   
   code segment
   
   start:
   		;安装,主程序负责将中断处理程序转移到起始地址为0:200内存单元中.
   		mov ax,cs
   		mov ds,ax
   		mov si,offset do0		;ds:si指向源地址
   		
   		mov ax,0
   		mov es,ax
   		mov di,200h				;es:di指向目的地址(即中断处理程序的起始地址)
   		
   		mov cx,offset do0end - offset do0	;设置程序所占的字节数大小
   		
   		cld						;设置df=0,正向传送
   		
   		rep movsb				;循环传送
   		
   		mov ax,0
   		mov es,ax
   		mov word ptr es:[0*4],200h
   		mov word ptr es:[0*4+2],0	;设置中断向量
   		
   		
   		
   		mov ax,4c00h
   		int 21h					;返回DOS
   		
   		;do0即为中断处理程序,负责显示.
   	
   		
   		do0:jmp short do0start	;指令占2B
   		db "divide error!"		;字符共13个
   		
   do0start:
   							;flag,cs,ip已经由中断过程保存了
   		push ds
   		push es
   		push si
   		push di					;保存现场
   		push ax
   		push cx
   
   		mov ax,cs
   		mov ds,ax
   		mov si,202h				;ds:si指向字符地址,此处可以使用绝对地址,因为这是固定在底部
   		
   		mov ax,0b800h			
   		mov es,ax
   		mov di,12*160+34*2		;es:di指向显存地址
   		
   		mov cx,13				;设置循环次数
   		mov ah,2				;设置为绿色
   	s:  mov al,ds:[si]
   		mov es:[di],ax
   		inc si
   		add di,2
   		loop s
   		
   		pop cx
   		pop ax
   		pop di					;恢复现场
   		pop si
   		pop es
   		pop ds
   		
   		
   		mov ax,4c00h
   		int 21h				;默认情况下是返回到导致中断的程序处(iret),这里执行中断处理程序后返回DOS系统
   		;iret:pop IP;pop CS;popf
   		;int :push popf;push CS;push IP
   		
   		
   do0end:nop
   		
   		
   code ends
   end start
   ```

   <img src=http://thyrsi.com/t6/378/1538314045x1822611431.png />

## Chapter 13

1. 问题一:编写,安装中断7ch的中断例程

   ```assembly
   ;功能:求一word型数据的平方
   ;参数:(ax)=要计算的数据
   ;返回值:dx,ax中存放结果的高16位和低16位
   assume cs:code
   
   code segment
   
   start:
   		mov ax,cs		;安装,主程序负责将中断处理程序转移到起始地址为0:200内存单元中
   		mov ds,ax
   		mov si,offset sqr
   		
   		mov ax,0
   		mov es,ax
   		mov di,200h
   		
   		mov cx,offset sqrend-offset sqr
   		
   		cld
   		
   		rep movsb
   		
   		
   		mov ax,0
   		mov es,ax
   		mov word ptr es:[7ch*4],200h
   		mov word ptr es:[7ch*4+2],0		;设置中断向量
   		
   		mov ax,4c00h
   		int 21h
   		
   	sqr:mul ax
   		iret
   sqrend: nop
   
   code ends
   end start
   ```

2. 问题一:编写,安装中断7ch的中断例程

   ```assembly
   ;功能:将一个全是字母,以0结尾的字符串,转化为大写
   ;参数:ds:si指向字符串的首地址
   ;返回值:无
   assume cs:code
   
   code segment
   
   start:
   		;安装,主程序负责将中断处理程序转移到起始地址为0:200内存单元中
   		mov ax,cs
   		mov ds,ax
   		mov si,offset capital	
   		
   		mov ax,0			
   		mov es,ax		
   		mov di,200h			;目的地址
   		
   		mov cx,offset capitalend-offset capital
   		
   		cld
   		
   		rep movsb
   		
   		mov ax,0
   		mov es,ax
   		mov word ptr es:[7ch*4],200h
   		mov word ptr es:[7ch*4+2],0	;设置中断向量
   		
   		mov ax,4c00h
   		int 21h
   		
   capital:push cx
   		push si
   		
   change: mov cl,[si]
   		mov ch,0
   		jcxz ok
   		and byte ptr ds:[si],11011111b
   		inc si
   		jmp short change
   		
   	ok: pop si
   		pop cx
   		iret
   		
   capitalend: 	
   		nop
   
   code ends
   end start
   
   ;use
   assume cs:code
   
   data segment
   	db 'conversation',0
   data ends
   
   code segment
   start:	
   		mov ax,data
   		mov ds,ax
   		mov si,0
   		int 7ch
   		
   		mov ax,4c00h
   		int 21h
   code ends
   end start
   ```

   <img src=http://thyrsi.com/t6/379/1538399316x1822611359.png />

3. 对int,iret和栈的深入理解

   ```assembly
   assume cs:code 
   
   code segment
   
   	start:
   			mov ax,0b800h
   			mov es,ax
   			mov di,160*12
   			
   			mov bx,offset s-offset se	;设置从标号se到标号s的转移位移
   			mov cx,80
   			
   		s:	mov byte ptr es:[di],'!'
   			add di,2
   			int 7ch			;如果(cx)不等于0,转移到标号s处
   		se: nop
   		
   			mov ax,4c00h
   			int 21h
   			
   			
   		lp: push bp
   			mov bp,sp
   			dec cx
   			jcxz lpret
   			add [bp+2],bx
   	 lpret: pop bp
   			iret
   			
   code ends
   
   end start
   			
   ```

4. test 13.1

   > <img src=http://thyrsi.com/t6/379/1538466579x1822611383.png />
   >
   > (1)ffffh
   >
   > (2)源代码
   >
   > ```assembly
   > ;安装程序
   > ;功能:使用7ch中断例程完成jmp near ptr s指令的功能
   > ;参数:cx:循环次数		bx:传送转移位移
   > ;返回值:无
   > assume cs:code
   > 
   > code segment
   > 
   > start:
   > 		;安装,主程序负责将中断处理程序转移到起始地址为0:200内存单元中
   > 		mov ax,cs
   > 		mov ds,ax
   > 		mov si,offset lp	
   > 		
   > 		mov ax,0			
   > 		mov es,ax		
   > 		mov di,200h			;目的地址
   > 		
   > 		mov cx,offset lpend-offset lp
   > 		
   > 		cld
   > 		
   > 		rep movsb
   > 		
   > 		mov ax,0
   > 		mov es,ax
   > 		mov word ptr es:[7ch*4],200h
   > 		mov word ptr es:[7ch*4+2],0	;设置中断向量
   > 		
   > 		mov ax,4c00h
   > 		int 21h
   > 		
   > lp:     push bp
   > 
   > 		mov bp,sp		;保存bp
   > 		dec cx
   > 		jcxz lpret
   > 		add [bp+2],bx	;调用指令的下一条指令的IP+跳转的偏移量
   > 		
   > lpret:  pop bp			;恢复bp
   > 		iret
   > 
   > 		
   > lpend:  nop
   > 
   > code ends
   > end start
   > 
   > ;调用程序
   > ;在屏幕的第12行,显示data段中以0结尾的字符串
   > assume cs:code
   > 
   > data segment
   > 	db 'conversation',0
   > data ends
   > 
   > code segment
   > start:	
   > 		mov ax,data
   > 		mov ds,ax
   > 		mov si,0
   > 		
   > 		mov ax,0b800h
   > 		mov es,ax
   > 		mov di,12*160
   > 		
   > 	s:	cmp byte ptr ds:[si],0
   > 		je	ok	;如果是0跳出循环
   > 		mov ah,2		;设置绿色
   > 		mov al,ds:[si]
   > 		mov es:[di],ax
   > 		inc si
   > 		add di,2
   > 		mov bx,offset s- offset ok	;跳转的偏移量
   > 		int 7ch
   > 		
   > 	ok:	mov ax,4c00h
   > 		int 21h
   > code ends
   > end start
   > ```
   >
   > 运行结果:
   >
   > <img src=http://thyrsi.com/t6/379/1538470663x-1376440090.png />

5. test 13.2

   > (1)我们可以编程改变ffff:0处的指令,使得CPU不去执行BIOS中的硬件系统检测和初始化程序. ×
   >
   > (2)int 19h中断例程,可以由DOS提供	×
   >
   > <img src=http://thyrsi.com/t6/379/1538472352x-1376440090.png />

6. BIOS和DOS提供的中断例程,都用ah来传递内部子程序的编号

   1. BIOS:int 10h

      ```assembly
      mov ah,2	;置光标 表示调用第10h号中断例程的2号子程序
      mov bh,2	;第0页
      mov dh,5	;行号
      mov dl,12	;列号
      int 10h
      
      ;在屏幕的5行12列显示3个红底高亮闪烁绿色的'a' (bl=0cah)
      assume cs:code
      code segment
      start:
      		mov ah,2	;置光标 表示调用第10h号中断例程的2号子程序
      		mov bh,2	;第0页
              mov dh,5	;行号
              mov dl,12	;列号
              int 10h
              
              mov ah,9	;在光标位置显示字符
              mov al,'a'	;字符
              mov bl,0cah	;红底高亮闪烁绿色
              mov bh,0	;第0页
              mov cx,3	;字符重复个数
              int 10h
              
              mov ax,4c00h	;mov al,4ch	;程序返回
              				;mov al,0	;返回值
              int 21h			
              
      code ends
      end start
      ```

   2. DOS:int 21h

      ```assembly
      ;在屏幕的5行12列显示字符串"Welcome to masm!"
      assume cs:code
      
      data segment
      	db 'Welcome to masm','$'
      data ends
      
      code segment
      start:
      		mov ah,2	;置光标 表示调用第10h号中断例程的2号子程序
      		mov bh,2	;第0页
              mov dh,5	;行号
              mov dl,12	;列号
              int 10h
              
      		mov ax,data	
      		mov ds,ax
      		mov dx,0	;ds:dx指向字符串的首地址data:0
      		mov ah,9
      		int 21h
              
              mov ax,4c00h	;mov al,4ch	;程序返回
              				;mov al,0	;返回值
              int 21h			
              
      code ends
      end start
      ```

### lab 13

1. 编写并安装int 7ch中断例程,功能为显示一个用0结束的字符串,中断例程安装在0:200处

   ```assembly
   
   ```
