## Chapter 11

1. test11.1

   > 写出下面每条指令执行后,ZF.PF.SF等标志位的值
   >
   > ```assembly
   > sub al,al	;ZF=1	PF=1	SF=0
   > 
   > mov al,1	;1		1		0
   > 
   > push ax		;1		1		0
   > 
   > pop bx		;1		1		0
   > 
   > add al,bl	;0		0		0
   > 
   > add al,10	;0		1		0
   > 
   > mul al		;0		1		0
   > ```
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

   <img src=http://thyrsi.com/t6/380/1538619636x1822611383.png />

2. test 11.2

   > ```assembly
   >       		    ;CF			;OF			;SF			;ZF			;PF
   > 
   > sub al,al		;0			0			0			1			1
   > 
   > mov al,10h		;0			0			0			1			1	
   > 
   > add al,90h		;0			0			1			0			1
   > 
   > mov al,80h		;0			0			1			0			1
   > 
   > add al,80h		;1			1			0			1			1
   > 
   > mov al,0fch		;1			1			0			1			1
   > 
   > add al,05h		;1			0			0			0			0
   > 
   > mov al,7dh		;1			0			0			0			0
   > 
   > add al,0bh 		;0			1			1			0			1
   > ```
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

   <img src=http://thyrsi.com/t6/380/1538619695x-1404755462.png />

   <img src=http://thyrsi.com/t6/380/1538619811x-1376440090.png />



   <img src=http://thyrsi.com/t6/380/1538619724x-1404755462.png />

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

   <img src=http://thyrsi.com/t6/380/1538619842x-1376440090.png />

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

   > 1.调用程序
   >
   > ```assembly
   > ;功能:显示一个用0结束的字符串
   > ;参数:(dh)=行号,(dl)=列号,(cl)=颜色,ds:si指向字符串首地址
   > ;返回:无
   > 
   > assume cs:code
   > data segment
   > 	db "welcome to hujie!",0
   > data ends
   > 
   > code segment
   > start:
   > 		mov dh,10
   > 		mov dl,10
   > 		mov cl,2
   > 		mov ax,data
   > 		mov ds,ax
   > 		mov si,0
   > 		int 7ch
   > 		mov ax,4c00h
   > 		int 21h
   > 		
   > 		
   > 
   > code ends
   > end start
   > 		
   > ```
   >
   > 2.安装程序
   >
   > ```assembly
   > ;安装程序:中断向量号:7ch,中断向量: 0:200处
   > assume cs:code
   > 
   > code segment
   > start:
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
   > lp:     push es
   > 		push ax	
   > 		push cx
   > 		push bx	
   > 		push di			;保存现场
   > 		
   > 		mov ax,0b800h
   > 		mov es,ax
   > 		dec dh			;行
   > 		mov al,dh
   > 		mov bl,160
   > 		mul bl
   > 		mov di,ax
   > 		
   > 		dec dl			;列
   > 		mov al,dl
   > 		mov bl,2
   > 		mul bl
   > 		add di,ax		;es:bx指向显存地址
   > 		
   > change:	push cx
   > 		mov ah,cl		;保存颜色
   > 		mov al,ds:[si]
   > 		mov es:[di],ax	;字符显示
   > 	
   > 		mov cl,al
   > 		sub ch,ch		;cx中存放的是对应的ASCII码
   > 			
   > 		jcxz ok			;判断其字符码是否为0
   > 		inc si			;指向下一个字符
   > 		add di,2		;指向下一个显存地址
   > 		pop cx			;恢复颜色
   > 		jmp short change
   > 				
   > ok:		pop di
   > 		pop bx
   > 		pop cx
   > 		pop ax
   > 		pop es
   > 		iret
   > 
   > lpend:  nop
   > 
   > code ends
   > end start
   > ```
   >
   > 3.程序结果
   >
   > <img src=http://thyrsi.com/t6/380/1538532113x-1376440138.png />

2. 编写并安装int 7ch中断例程,功能为完成loop指令的功能

   > 1.调用程序
   >
   > ```assembly
   > ;功能:在屏幕中间显示80个"❤"黑底红色030ch
   > ;参数:(cx)=循环次数,(bx)=位移
   > ;返回:无
   > 
   > assume cs:code
   > 
   > code segment
   > start:
   > 		mov ax,0b800h
   > 		mov es,ax
   > 		mov di,160*12
   > 		mov bx,offset s-offset se		;设置se到s的转移位移
   > 		mov cx,80
   > 	s:	mov word ptr es:[di],403h
   > 		add di,2
   > 		int 7ch					;如果(cx)不等于0,转移到标号s处
   > 	se:	nop
   > 		mov ax,4c00h
   > 		int 21h
   > 
   > code ends
   > end start
   > 		
   > ```
   >
   > 2.安装程序
   >
   > ```assembly
   > ;安装程序:中断向量号:7ch,中断向量: 0:200处
   > assume cs:code
   > 
   > code segment
   > start:
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
   > lp:    	push bp
   > 		mov bp,sp
   > 		dec cx
   > 		jcxz	lpret
   > 		add [bp+2],bx				;完成IP+base从而转到标号s处
   > 
   > lpret:	pop bp
   > 		iret
   > 
   > lpend:  nop
   > 
   > code ends
   > end start
   > ```
   >
   > 3.程序结果
   >
   > <img src=http://thyrsi.com/t6/380/1538552467x1822611263.png />

3. 分别在屏幕的第2,4,6,8行显示4句英文诗,补全程序

   > 1.程序
   >
   > ```assembly
   > assume cs:code
   > code segment
   > 	s1:	db 'Good,better,best,','$'
   > 	s2:	db 'Never let it rest,','$'
   > 	s3: db 'Till good is better,','$'
   > 	s4:	db 'And better,best.','$'
   > 	s : dw offset s1,offset s2,offset s3,offset s4
   > 	row:db	2,4,6,8
   > 	
   > 	start:  mov ax,cs
   > 			mov ds,ax
   > 			mov bx,offset s
   > 			mov si,offset row
   > 			mov cx,4
   > 		ok: mov bh,0			;第0页
   > 			mov dh,ds:[si]		;行
   > 			mov dl,0			;列
   > 			mov ah,2			;置光标
   > 			int 10h
   > 			
   > 			mov dx,ds:[bx]			;ds:dx指向字符串的首地址
   > 			mov ah,9			;在光标位置处显示字符
   > 			int 21h
   > 			inc si					;指向需要显示的下一行的行数的偏移地址
   > 			add bx,2			;指向下下一行字符串的首地址
   > 			loop ok
   > 			
   > 			mov ax,4c00h
   > 			int 21h
   > code ends
   > end start
   > ```
   >
   > 2.运行结果
   >
   > <img src=http://thyrsi.com/t6/380/1538554412x-1376440138.png />
   >
   > 3.分析
   >
   > 由于是不同的行显示不同内容,故最好的策略是将行号与要内容分开,具体实现是
   >
   > 1. 将每行的内容分别放在标号也即该行的首地址中
   > 2. 采用字大小,用标号记录其各行的标号
   > 3. 采用字节大小(屏幕总共25行),用标号记录相应的行号
   > 4. 将以上内容放入cs段的起始位置

## Chapter 14

1. test 14.1

   > 1.编程,读取CMOS RAM的2号单元的内容
   >
   > ```assembly
   > mov al,2
   > out 70h,al	;往70h端口写入2
   > in al,71h	;从71h端口读入2号单元的一个字节(mov)
   > ```
   >
   > 2.编程,向CMOS RAM的2号单元写入0
   >
   > ```assembly
   > mov al,2
   > out 70h,al	;往70h端口写入2
   > mov al,0
   > out 71h,al	;往71h端口写入0字节
   > ```

2. test 14.2

   > 编程,用加法和移位指令计算(ax)=(ax)*10
   >
   > ```assembly
   > shl ax,1
   > mov bx,ax
   > mov cl,2
   > shl ax,cl
   > add bx,ax
   > ```

### lab 14

1. 编程,以"年/月/日 时:分:秒"的格式,显示当前的日期,时间.

   > 1.编程思路
   >
   > 若单独显示不同的年 月 日 时 分 秒,则代码变得过于冗长和重复,考虑到代码的精简性,于是将将其单元号都放入一个标号单元中,同理单独显示的字符也都放入一个标号中.考虑到程序的移植性,将其放入CS段中.
   >
   > 2.程序
   >
   > ```assembly
   > assume cs:code
   > 
   > stack segment 
   > 	db 16 dup (0)
   > stack ends
   > 
   > code segment
   > 		s: db	9,8,7,4,2,0			;年 月 日 时 分 秒
   > 		s1:db	47,47,32,58,58,0	;单独显示符号的ASCII码
   > start:	
   > 		mov cx,6
   > 		mov ax,stack
   > 		mov ss,ax
   > 		mov sp,16
   > 		
   > 		mov ax,cs
   > 		mov ds,ax
   > 		mov bp,offset s
   > 		mov di,offset s1
   > 		mov si,64
   > 		
   > change:	push cx
   > 		mov al,ds:[bp]
   > 		out 70h,al
   > 		in al,71h
   > 		mov ah,al
   > 		mov cl,4
   > 		shr ah,cl
   > 		and al,00001111b		;转成两位十进制数
   > 		
   > 		add ah,30h
   > 		add al,30h
   > 		
   > 		mov bx,0b800h
   > 		mov es,bx
   > 		mov byte ptr es:[160*12+si],ah	;显示年 月 日 时 分 秒的十位数码
   > 		mov byte ptr es:[160*12+si+2],al;显示年 月 日 时 分 秒的个位数码
   > 		mov al,ds:[di]					
   > 		mov byte ptr es:[160*12+si+4],al;显示单独字符
   > 		
   > 		pop cx
   > 		inc bp
   > 		inc di
   > 		add si,6
   > 		loop change
   > 		
   > 		mov ax,4c00h
   > 		int 21h
   > 		
   > code ends
   > end start
   > ```
   >
   > 3.运行结果
   >
   > <img src=http://thyrsi.com/t6/380/1538636170x-1566688371.png />



## Chapter 15

1. 可屏蔽中断(外中断)

   > 1. 取中断类型码n;(从数据总线送入CPU)
   > 2. 标志寄存器入栈,IF=0,TF=0;
   > 3. CS,IP入栈;
   > 4. (IP)=(n * 4),(CS)=(n * 4+2)

2. 不可屏蔽中断(外中断)

   > 1. 标志寄存器入栈,IF=0,TF=0;
   > 2. CS,IP入栈
   > 3. (IP)=(8),(CS)=(0AH)

3. 在BIOS键盘缓冲区中,一个键盘输入用一个字单元存放,高位字节存放扫描码,低位字节存放字符码

   1. 键盘产生扫描码
   2. 扫描码送入60h端口
   3. 引发9号中断
   4. CPU执行int 9中断例程处理键盘输入(这步能改变)

4. int过程的模拟过程变为

   1. 标志寄存器入栈

   2. IF=0,TF=0

   3. call dword ptr ds:[0]

      ```assembly
      pushf				;标志寄存器入栈
      
      pushf
      pop ax
      and ah,11111100h
      push ax
      popf				;IF=0,TF=0
      
      call dword ptrds:[0];CS,IP入栈	
      ```

### lab 15

1. 编程,安装一个新的int9中断例程,功能:在DOS下,按下"A"键后,除非不再松开,如果松开,就显示满屏幕的"A",其他的键照常处理

   > 1.程序
   >
   > ```assembly
   > ;t152
   > assume cs:code
   > 
   > stack segment
   > 	db 128	dup (0)
   > stack ends
   > 
   > code  segment
   > start:	mov ax,stack
   > 		mov ss,ax
   > 		mov sp,128
   > 		
   > 		push cs
   > 		pop ds								;用栈传值
   > 		
   > 		mov ax,0
   > 		mov es,ax
   > 		
   > 		mov si,offset int9					;设置ds:si指向源地址
   > 		mov di,204h							;设置es:di指向目的地址
   > 		mov cx,offset int9end-offset int9	;设置cx为传输长度
   > 		cld									;设置传输方向为正
   > 		
   > 		rep movsb
   > 		
   > 		push es:[9*4]						;保存原先int9中断地址到0:200
   > 		pop  es:[200h]
   > 		push es:[9*4+2]
   > 		pop  es:[202h]
   > 		
   > 		cli									;屏蔽中断
   > 		mov  word ptr es:[9*4],204h
   > 		mov  word ptr es:[9*4+2],0
   > 		sti									;开启中断
   > 		
   > 		mov ax,4c00h
   > 		int 21h
   > 		
   > int9:	push ax
   > 		push bx
   > 		push cx
   > 		push es
   > 		
   > 		mov ax,0b800h
   > 		mov es,ax
   > 		mov bx,0
   > 		mov cx,2000
   > 		
   > 	s1: in al,60h							;从60h端口读取数据
   > 											;送入原来的int9处理得到键值
   > 		pushf
   > 		call dword ptr   cs:[200h]			;当此中断例程执行时(CS)=0
   > 		
   > 		cmp al,1Eh							;判断是否为"A"
   > 		je 	s1								;如果是"A"就循环扫描键值
   > 		
   > 		cmp al,9eh							;判断是否松开
   > 		jne	int9ret							;如果松开则显示满屏幕的"A"
   > 		
   > 		
   > 		
   >     s2:	mov byte ptr es:[bx],65	
   > 		inc byte ptr es:[bx+1]				;每重复一次改变颜色				
   > 		add bx,2
   > 		loop s2
   > 											;显示满屏幕的"A",颜色改变
   > int9ret:pop es
   > 		pop cx
   > 		pop bx
   > 		pop ax
   > 		iret
   > 		
   > int9end:nop
   > 		
   > code ends
   > end start
   > ```
   >
   > 2.结果
   >
   > <img src=http://thyrsi.com/t6/381/1538809122x1822611431.png />

## Chapter 16

1. test 16.1

   > 下面的程序将code段中a处的8个数据累加,结果存储到b处的双字中,补全程序
   >
   > ```assembly
   > assume cs:code
   > code segment
   > 	a dw 1,2,3,4,5,6,7,8
   > 	b dd 0
   > 	
   > start:
   >    	mov si,0
   >    	mov cx,8
   >   s:mov ax,a[si]
   >   	add b[0],ax		;低位相加
   >   	adc b[2],0		;高位相加
   >   	add si,2
   >   	loop s
   >   	
   >   	mov ax,4c00h
   >   	int 21h
   >   	
   > code ends
   > end start
   > ```
   >
   >

2. test 16.2

   下面的程序将data段中a处的8个数据累加,结果存储到b处的字中,补全程序

   ```assembly
   assume cs:code,es:data
   
   data segment
   	a db 1,2,3,4,5,6,7,8
   	b dw 0
   data ends
   
   code segment
   start:
   	mov ax,data
   	mov es,ax			
   	mov si,0
   	mov cx,8
   s:	mov al,a[si]
   	mov ah,0
   	add b,ax
   	inc si
   	loop s
   	
   	mov ax,4c00h
   	int 21h
   
   code ends
   end start
   ```

   根据debug上的调试,得到如下解释:

   1. 若14行不强加限制段寄存器,则会默认会assume的段寄存器,在本例中为es,若强加限制,如cs,则会编译通过,并使段地址为cs
   2. 若11行的段寄存器不与约定相同,则默认assume的段寄存器,在本例中若只改成mov ds,ax,则不会起到作用
   3. 由以上两条可知,必须约定,必须相同

3. 映射

   > 1.子程序
   >
   > ```assembly
   > ;用al传送要显示的数据
   > 
   > showbyte:	jmp short show
   > 			
   > 			table	db	'0123456789ABCDEF'	;字符表
   > 			
   > 	show:	push bx
   > 			push es
   > 			
   > 			mov ah,al
   > 			shr ah,1
   > 			shr ah,1
   > 			shr ah,1
   > 			shr ah,1			;右移4位,ah中得到高4位的值
   > 			and al,00001111b	;al中为低4位的值
   > 			
   > 			mov bl,ah
   > 			mov bh,0
   > 			mov ah,table[bx]	;用高四位的值作为相对于table的偏移,取得对应的字符
   > 			
   > 			mov bx,0b800h
   > 			mov es,bx
   > 			mov es:[160*12+40*2],ah
   > 			
   > 			mov bl,al
   > 			mov bh,0
   > 			mov al,talbe[bx]	;用低四位的值作为相对于table的偏移,取得对应的字符
   > 			
   > 			mov es:[160*12+40*2+2],al
   > 			
   > 			pop es
   > 			pop bx
   > 			
   > 			ret
   > ```
   >
   > 目的:
   >
   > 1. 为了算法的清晰和简洁
   > 2. 为了加快运算速度
   > 3. 为了使程序易于扩充

4. sin(x)

   > 1.程序
   >
   > ```assembly
   > assume cs:code
   > 
   > code segment
   > start:
   > 	mov si,160*12+80
   > 	mov ax,55
   > 	call showsin
   > 	
   > 	mov si,160*13+80
   > 	mov ax,190
   > 	call showsin
   > 	
   > 	mov si,160*14+80
   > 	mov ax,-1
   > 	call showsin
   > 	
   > 	mov si,160*15+80
   > 	mov ax,95
   > 	call showsin
   > 	
   > 	mov ax,4c00h
   > 	int 21h
   > 	
   > ;用ax向子程序传递角度
   > showsin:	jmp short show
   > 
   > 	table	dw	ag0,ag30,ag60,ag90,ag120,ag150,ag180	;字符串偏移地址表
   > 	ag0			db	'0',0		;sin(0)对应的字符串"0"
   > 	ag30		db	'0.5',0		;sin(30)对应的字符串"0.5"
   > 	ag60		db	'0.866',0	;sin(60)对应的字符串"0.866"
   > 	ag90		db	'1',0		;sin(90)对应的字符串"1"
   > 	ag120		db	'0.866',0	;sin(120)对应的字符串"0.866"
   > 	ag150		db	'0.5',0		;sin(150)对应的字符串"0.5"
   > 	ag180		db	'0',0		;sin(180)对应的字符串"0"
   > 	
   > show:	push bx
   > 		push es
   > 		
   > 		cmp al,0
   > 		jb showret	;如果角度小于0,跳出
   > 		cmp al,180	
   > 		ja	showret	;如果角度大于180,跳出
   > 		
   > 		mov bx,0b800h
   > 		mov es,bx
   > 		
   > ;以下用角度值/30作为相对于table的偏移,取得对应的字符串的偏移地址,放在bx中
   > 		mov ah,0
   > 		mov bl,30
   > 		div bl		;商在al中
   > 		mov bl,al
   > 		mov bh,0
   > 		add bx,bx	;类型为word
   > 		mov bx,table[bx]
   > 		
   > ;以下显示sin(x)对应的字符串
   > shows:	mov ah,cs:[bx]
   > 		cmp ah,0
   > 		je	showret		
   > 		mov es:[si],ah
   > 		inc bx
   > 		add si,2
   > 		jmp short shows
   > 		
   > showret:pop es
   > 		pop bx
   > 		ret
   > 
   > code ends
   > end start
   > ```
   >
   > 2.结果
   >
   > <img src=http://thyrsi.com/t6/382/1538816613x-1376440090.png />
   >
   > 3.本例侧重展示其用法及区别,未做错误显示处理,标号仅仅是一个标记,并不占用实际的空间
   >
   > <img src=http://thyrsi.com/t6/382/1538827536x-1566688347.png />

### lab 16

1. 安装一个新的int 7ch中断例程,为显示输出提供如下功能子程序

   > 1. 程序
   >
   > ```assembly
   > ;功能:
   > ;清屏			;空格
   > ;设置前景色		;当前屏幕中处于奇地址的属性字节的第0.1.2位
   > ;设置背景色		;当前屏幕中处于奇地址的属性字节的第4.5.6位
   > ;向上滚动一行	        ;依次将第n+1行的内容复制到第n行处:最后一行为空
   > ;参数
   > ;ah传递功能号:0表示清屏,1表示设置前景色,2表示设置背景色,3表示向上滚动一行
   > ;对于1,2号功能,用al传送颜色值,(al)∈{0,1,2,3,4,5,6,7}
   > 
   > assume cs:code
   > 
   > stack segment
   > 	db 128	dup (0)
   > stack ends
   > 
   > code segment
   > 
   > start:
   > 		;安装,主程序负责将中断处理程序转移到起始地址为0:200内存单元中.
   > 		mov ax,stack
   > 		mov ss,ax
   > 		mov sp,128
   > 		push cs
   > 		pop ds
   > 		mov ax,0
   > 		mov es,ax
   > 		
   > 		mov si,offset setscreen	;ds:si指向源地址
   > 		mov di,204h				;es:di指向目的地址(即中断处理程序的起始地址)
   > 		
   > 		mov cx,offset setend - offset setscreen	;设置程序所占的字节数大小
   > 		
   > 		cld						;设置df=0,正向传送
   > 		
   > 		rep movsb				;循环传送
   > 		
   > 		push es:[7ch*4]
   > 		pop	 es:[200h]
   > 		push es:[7ch*4+2]
   > 		pop es:[202h]	;原中断向量地址保存至es:[200h]
   > 		
   > 		cli
   > 		mov word ptr es:[7ch*4],204h
   > 		mov word ptr es:[7ch*4+2],0	;设置中断向量
   > 		sti
   > 		
   > 		mov ah,2				;功能号2,设置背景色
   > 		mov al,4				;设置红色
   > 		int 7ch
   > 		
   > 		push es:[200h]
   > 		pop es:[7ch*4]
   > 		push es:[202h]
   > 		pop es:[7ch*4+2]		;恢复原中断向量int 7ch中断例程的入口地址
   > 		
   > 		mov ax,4c00h
   > 		int 21h					;返回DOS
   > 
   > ;名称:setscreen,中断处理程序
   > ;功能:1.清屏	;空格
   > ;	  2.设置前景色		;当前屏幕中处于奇地址的属性字节的第0.1.2位
   > ;	  3.设置背景色		;当前屏幕中处于奇地址的属性字节的第4.5.6位
   > ;	  4.向上滚动一行	;依次将第n+1行的内容复制到第n行处:最后一行为空
   > ;参数
   > ;(1)ah传递功能号:0表示清屏,1表示设置前景色,2表示设置背景色,3表示向上滚动一行
   > ;(2)对于1,2号功能,用al传送颜色值,(al)∈{0,1,2,3,4,5,6,7}
   > ;返回:根据功能号调用相应子程序的返回值
   > 
   > org	204h	;表示下一指令的地址从偏移地址204h开始
   > 
   > setscreen:	jmp short set
   > 
   > 	table	dw sub1,sub2,sub3,sub4
   > 	
   > 	set:	push bx
   > 			
   > 			cmp ah,3
   > 			ja sret
   > 			mov bl,ah
   > 			mov bh,0
   > 			add bx,bx	;根据ah中的功能号计算对应子程序在table表中的偏移
   > 			call word ptr table[bx]	;调用对应的功能子程序
   > 			;此处易犯错,由于table为数据标号,已经包含了段地址,故不能指定
   > 			
   > 	sret:	pop bx
   > 			ret
   > 			
   > 	sub1:	push bx
   > 			push cx
   > 			push es
   > 			mov bx,0b800h
   > 			mov es,bx
   > 			mov bx,0
   > 			mov cx,2000
   > 	sub1s:	mov byte ptr es:[bx],' '
   > 			add bx,2
   > 			loop sub1s
   > 			pop es
   > 			pop cx
   > 			pop bx
   > 			ret
   > 			
   > 	sub2:	push bx
   > 			push cx
   > 			push es
   > 			mov bx,0b800h
   > 			mov es,bx
   > 			mov bx,1
   > 			mov cx,2000
   > 	sub2s:	and byte ptr es:[bx],11111000b
   > 			or es:[bx],al		;设置成需要的颜色
   > 			add bx,2
   > 			loop sub2s
   > 			pop es
   > 			pop cx
   > 			pop bx
   > 			ret
   > 			
   > 	sub3:	push bx
   > 			push cx
   > 			push es
   > 			mov cl,4
   > 			shl al,cl			;将低4位左移4位成为高4位
   > 			mov bx,0b800h
   > 			mov es,bx
   > 			mov bx,1
   > 			mov cx,2000
   > 	sub3s:	and byte ptr es:[bx],10001111b
   > 			or es:[bx],al
   > 			add bx,2
   > 			loop sub3s
   > 			pop es
   > 			pop cx
   > 			pop bx
   > 			ret
   > 			
   > 	sub4:	push cx
   > 			push si
   > 			push di
   > 			push es
   > 			push ds
   > 			
   > 			mov si,0b800h
   > 			mov es,si
   > 			mov ds,si
   > 			mov si,160		;ds:si指向第n+1行,源地址
   > 			mov di,0		;es:di指向第n行,目的地址
   > 			cld				;传输方向为正
   > 			mov cx,24		;传输长度
   > 	sub4s:	push cx
   > 			mov cx,160
   > 			rep movsb		;复制一行(包括颜色)
   > 			pop cx	
   > 			loop sub4s		;复制24行
   > 			
   > 			mov cx,80
   > 			mov si,0
   > 	sub4s1:	mov byte ptr [160*24+si],' '	;最后一行清空
   > 			add si,2
   > 			loop sub4s1
   > 			
   > 			pop ds
   > 			pop es
   > 			pop di
   > 			pop si
   > 			pop cx
   > 			ret		
   > 			
   > 	setend:	nop
   > 	
   > code ends
   > end start
   > ```
   >
   > 2.结果
   >
   > ![1538913353517](E:\icodeworld.github.io\os_lab\Assembly\1538913353517.png)
   >
   > 3.反思
   >
   > - 由于在83行处加入了"mov ax,0"以及"mov ds,ax"从而无法正确执行程序,实际上,数据标号既包括偏移地址又包括段地址.故不另加入段
   > - 此外,org	204h,使下一条指令的偏移地址为204h,与装入的程序一致,目的是保证table数据标号的正确指向

## Chapter 17

1. 颜色

   ```assembly
   ;技巧:利用颜色的位分布,RGB分别位于210位,故移位更为简单,从而B无需移位,G移位一次,R移位两次
   assume cs:code
   
   code segment
   start:	mov ah,0
   		int 16h
   		
   		mov ah,1
   		cmp al,'r'
   		je red 
   		cmp al,'g'
   		je green
   		cmp al,'b'
   		je blue
   		jmp short sret
   		
   	red:
   		shl ah,1
   	
   	green:
   		shl ah,1
   		
   	blue:
   		mov bx,0b800h
   		mov es,bx
   		mov bx,1
   		mov cx,2000
   	s:  and byte ptr es:[bx],11111000b
   		or es:[bx],ah
   		add bx,2
   		loop s
   	
   	sret:
   		mov ax,4c00h
   		int 21h
   
   code ends
   end start
   ```

2. test 17.1

   > ##### "在int 16h中断例程中,一定有设置IF=1的指令."这种说法对吗?
   >
   > - 对
   > - 8086的中断，分为内部中断、外部中断、软件中断三类。
   >   1. 内部中断的中断号是0~7，除了2号是外部硬件发起的不可屏蔽中断外，其它由CPU发起。比如0号中断是除法溢出中断，只要执行除法指令时被除数的高一半大于或等于除数，CPU就自动调用这个中断。这8个都是不受IF控制的。
   >   2. 外部中断的中断号是8~0FH（286以后的CPU增加了7个外部中断，这里不讨论）。它们由外部硬件发起，比如键盘、硬盘等。它们都是可屏蔽中断。IF设置为0的时候，影响的就是这8个。
   >   3. 从10H开始往后，直到FFH，全是软件中断。它们也全部不受IF控制。
   >
   > - 将IF置0，不会影响0 ~ 7这8个内部中断，不会影响10H往后（包括16H）所有中断指令。它只会影响8 ~ F之间这8个，并且，只是由CPU外部引脚的 IRQ端子上收到的外部硬件中断请求会被屏蔽。（如果你在程序中用一条 INT  08H指令，这次就是指令软中断，它也不会受IF的影响）。
   >
   > -   你的程序中, 程序开头cli指令设置"IF = 0". 但由于"int x"属于内中断。 忽略IF值, int 16h 照常执行。
   >     "r还是 可以让字符变红"? 。 因为PC在"int 16h"例程中， 响应了外中断信息。
   >
   >   原理： "int 16h" 例程里含有sti指令, 设置IF=1. 这个时候按下"r"键，响应外中断请求，从而 "int 9h"例程得到执行。 最终 "int 16h"获取键盘信息"R" 并置于 ah=“通码", al="Ascii"中.  
   >
   > - 我们不能确保键盘缓冲区中会一直有数据，如果没有键盘缓冲区中没有数据，那马将会造成死锁。所以我们还是要设置IF=1使得能够响应int 9的中断。便于int 9向键盘缓冲区中写入数据，以便int 16h能个取得键盘缓冲区中的数据。
   >
   >   综上所述，此句话的说法是正确的。

3. 字符串的输入

   > 1. 程序的处理过程
   >
   >    1. 调用int 16h读取键盘输入
   >    2. 如果是字符,进入字符栈,显示字符栈中的所有字符;继续执行1
   >    3. 如果是退格符,从字符栈中弹出一个字符,显示字符栈中的所有字符,继续执行1
   >    4. 如果是Enter键,向字符栈中压入0,返回
   >
   > 2. 子程序:字符栈的入栈,出栈和显示
   >
   >    ```assembly
   >    ;名称:字符栈的入栈,出栈和显示
   >    ;参数说明:	(ah)=功能号,0表示入栈,1表示出栈,2表示显示;ds:si指向字符栈空间
   >    ;对于0号功能:(al)=入栈字符
   >    ;对于1号功能:(al)=返回的字符
   >    ;对于2号功能:(dh),(dl)=字符串在屏幕上显示的行,列位置
   >    
   >    charstack:	jmp short charstart
   >    
   >    table		dw charpush,charpop,charshow
   >    top 		dw 0							;栈顶
   >    
   >    charstart:	push bx
   >    			push dx
   >    			push di
   >    			push es
   >    			
   >    			cmp ah,2
   >    			ja sret
   >    			mov bl,ah
   >    			mov bh,0
   >    			add bx,bx
   >    			jmp word ptr table[bx]
   >    			
   >    charpush:	mov bx,top 
   >    			mov [si][bx],al
   >    			inc top
   >    			jmp sret
   >    			
   >    charpop:	cmp top,0
   >    			je sret
   >    			dec top
   >    			mov bx,top
   >    			mov al,[si][bx]
   >    			jmp sret
   >    			
   >    charshow:	mov bx,0b800h
   >    			mov es,bx
   >    			mov al,160
   >    			mov ah,0
   >    			mul dh
   >    			mov di,ax
   >    			add dl,dl
   >    			mov dh,0
   >    			add di,dx		:es:di指向显存地址
   >    			
   >    			mov bx,0
   >      charshows:cmp bx,top
   >    			jne noempty
   >    			mov byte ptr es:[di],' '
   >    			jmp sret
   >    	noempty:mov al,[si][bx]
   >    			mov es:[di],al
   >    			mov byte ptr es:[di+2],' '
   >    			inc bx
   >    			add di,2
   >    			jmp charshows
   >    	
   >    sret:		pop es
   >    			pop si
   >    			pop dx
   >    			pop bx
   >    			ret
   >    ```
   >
   > 3. 完整的接收字符串输入的子程序
   >
   >    ```assembly
   >    assume cs:code
   >    
   >    data segment	
   >    	db 256 dup(' ')
   >    data ends 
   >    
   >    stack segment	
   >    	db 64 dup (0)
   >    stack ends 
   >    
   >    code segment
   >    start:
   >    			mov ax, stack			
   >                mov ss, ax			
   >                mov sp, 64		
   >                
   >                mov ax, data				
   >                mov ds, ax								
   >                mov ax, 0				
   >                mov si, 0								
   >                mov dh, 5				
   >                mov dl, 0				
   >                call getstr								
   >                mov ax, 4c00h				
   >                int 21h
   >    
   >    getstr:		push ax
   >    			
   >    	getstrs:mov ah,0
   >    			int 16h
   >    			cmp al,20h
   >    			jb nochar						;ASCII码小于20h,说明不是字符
   >    			mov ah,0
   >    			call charstack					;字符入栈
   >    			mov ah,2
   >    			call charstack					;显示栈中的字符
   >    			jmp getstrs
   >    			
   >    nochar:		cmp ah,0eh						;退格键的扫描码
   >    			je	backspace
   >    			cmp ah,1ch						;Enter键的扫描码
   >    			je enter
   >    			jmp getstrs
   >    			
   >    backspace:	mov ah,1
   >    			call charstack					;字符出栈
   >    			mov ah,2
   >    			call charstack					;显示栈中的字符
   >    			jmp getstrs
   >    			
   >    enter:		mov al,0
   >    			mov ah,0
   >    			call charstack					;0入栈
   >    			mov ah,2
   >    			call charstack					;显示栈中的字符
   >    			pop ax
   >    			ret
   >    			
   >    ;名称:字符栈的入栈,出栈和显示
   >    ;参数说明:	(ah)=功能号,0表示入栈,1表示出栈,2表示显示;ds:si指向字符栈空间
   >    ;对于0号功能:(al)=入栈字符
   >    ;对于1号功能:(al)=返回的字符
   >    ;对于2号功能:(dh),(dl)=字符串在屏幕上显示的行,列位置
   >    
   >    charstack:	jmp short charstart
   >    
   >    table		dw charpush,charpop,charshow
   >    top 		dw 0							;栈顶
   >    
   >    charstart:	push bx
   >    			push dx
   >    			push di
   >    			push es
   >    			
   >    			cmp ah,2
   >    			ja sret
   >    			mov bl,ah
   >    			mov bh,0
   >    			add bx,bx
   >    			jmp word ptr table[bx]
   >    			
   >    charpush:	mov bx,top 
   >    			mov [si][bx],al
   >    			inc top
   >    			jmp sret
   >    			
   >    charpop:	cmp top,0
   >    			je sret
   >    			dec top
   >    			mov bx,top
   >    			mov al,[si][bx]
   >    			jmp sret
   >    			
   >    charshow:	mov bx,0b800h
   >    			mov es,bx
   >    			mov al,160
   >    			mov ah,0
   >    			mul dh
   >    			mov di,ax
   >    			add dl,dl
   >    			mov dh,0
   >    			add di,dx						;es:di指向显存地址
   >    			
   >    			mov bx,0
   >      charshows:cmp bx,top
   >    			jne noempty
   >    			mov byte ptr es:[di],' '
   >    			jmp sret
   >    	noempty:mov al,[si][bx]
   >    			mov es:[di],al
   >    			mov byte ptr es:[di+2],' '
   >    			inc bx
   >    			add di,2
   >    			jmp charshows
   >    	
   >    sret:		pop es
   >    			pop si
   >    			pop dx
   >    			pop bx
   >    			ret
   >    code ends
   >    end start
   >    ```
   >
   > 4. 结果![1538901916990](E:\icodeworld.github.io\os_lab\Assembly\1538901916990.png)

4. 读取或者写入0面0道1扇区的内容到0:200

   ```assembly
    ;参数:  (ah)=int 13h的功能号(2表示读扇区)
   		;(al)=读取的扇区数
   		;(ch)=磁道号
   		;(cl)=扇区号
   		;(dh)=磁头号
   		;(dl)=驱动器号	软驱  0:软驱A  1:软驱B
   					   ;硬盘  80h:硬盘C	81h:硬盘D
   		;es:bx指向接收从扇区读入数据的内存区
   ;返回:  成功: (ah)=0,(al)=读入的扇区数
   	   ;失败: (ah)=出错代码
    mov ax,0
    mov es,ax
    mov bx,200h
    
    mov al,1
    mov ch,0
    mov cl,1
    mov dl,0
    mov dh,0
    
    mov ah,2
    int 13h
    
     ;参数:  (ah)=int 13h的功能号(3表示写扇区)
   		;(al)=写入的扇区数
   		;(ch)=磁道号
   		;(cl)=扇区号
   		;(dh)=磁头号
   		;(dl)=驱动器号	软驱  0:软驱A  1:软驱B
   					   ;硬盘  80h:硬盘C	81h:硬盘D
   		;es:bx指向将写入磁盘的数据
   ;返回:  成功: (ah)=0,(al)=写入的扇区数
   	   ;失败: (ah)=出错代码
   	   
    mov ax,0
    mov es,ax
    mov bx,200h
    
    mov al,1
    mov ch,0
    mov cl,1
    mov dl,0
    mov dh,0
    
    mov ah,3
    int 13h
   ```

### lab 17

1. 程序

   > 1.程序
   >
   > ```assembly
   > assume cs:code
   > stack segment
   > 	db 64 dup(0)
   > stack ends
   > 
   > code segment
   > 
   > start:
   > 			;安装,主程序负责将中断处理程序转移到起始地址为0:200内存单元中.
   > 		mov ax,stack
   > 		mov ss,ax
   > 		mov sp,64
   > 		
   > 		push cs
   > 		pop ds
   > 		
   > 		mov ax,0
   > 		mov es,ax
   > 		
   > 		mov si,offset int7ch	;ds:si指向源地址
   > 		mov di,204h				;es:di指向目的地址(即中断处理程序的起始地址)
   > 		
   > 		mov cx,offset int7chend - offset int7ch	;设置程序所占的字节数大小
   > 		
   > 		cld						;设置df=0,正向传送
   > 		
   > 		rep movsb				;循环传送
   > 		
   > 		push es:[7ch*4]
   > 		pop	 es:[200h]
   > 		push es:[7ch*4+2]
   > 		pop es:[202h]	;原中断向量地址保存至es:[200h]
   > 		
   > 		cli
   > 		mov word ptr es:[7ch*4],204h
   > 		mov word ptr es:[7ch*4+2],0	;设置中断向量
   > 		sti
   > 		
   > 		mov ah,0				;功能号0,表示读
   > 		mov dx,2879				;逻辑扇区号为2879
   > 		mov bx,0
   > 		mov es,bx				;es:bx=0:0
   > 		int 7ch
   > 		
   > 		push es:[200h]
   > 		pop es:[7ch*4]
   > 		push es:[202h]
   > 		pop es:[7ch*4+2]		;恢复原中断向量int 7ch中断例程的入口地址
   > 		
   > 		mov ax,4c00h
   > 		int 21h					;返回DOS		
   > 		
   >  ;功能:实现通过逻辑扇区号对软盘进行读写
   >  ;参数:
   > 	  ;(1)用ah传递功能号:0表示读,1表示写
   > 	  ;(2)用dx传递要读写的扇区的逻辑扇区号
   > 	  ;(3)用es:bx指向存储读出数据或写入数据的内存区	
   > 	   ;参数:  (ah)=int 13h的功能号(2表示读扇区)
   > 		;(al)=读取的扇区数
   > 		;(ch)=磁道号
   > 		;(cl)=扇区号
   > 		;(dh)=磁头号
   > 		;(dl)=驱动器号	软驱  0:软驱A  1:软驱B
   > 					   ;硬盘  80h:硬盘C	81h:硬盘D
   > 		;es:bx指向接收从扇区读入数据的内存区
   > ;返回:  成功: (ah)=0,(al)=读入的扇区数
   > 	   ;失败: (ah)=出错代码
   > org	204h	;表示下一指令的地址从偏移地址204h开始
   > 
   > int7ch:		jmp short set
   > 
   > 	table	dw read,write
   > 	
   > set:		
   > 			push cx
   > 			push dx
   > 			push ax			;便于恢复
   > 			
   > 			cmp ah,1
   > 			ja sret
   > 			
   > 			cmp dx,2879
   > 			ja errors		;若大于软盘的最大扇区,报错
   > 			
   > 			mov ax,dx		;(ax)=逻辑扇区号
   > 			mov dx,0		;高位置0
   > 			mov bx,1440
   > 			div bx			;(ax)=面号,dx为剩余的磁道号
   > 			
   > 			push dx			;保存余下的磁道号								
   > 			mov dh,al		;(dh)=磁头号
   > 			mov dl,0		;(dl)=驱动器号
   > 			
   > 			pop ax			;剩余的磁道号赋给ax
   > 			mov bl,18
   > 			div bl			;(al)为为磁道号,(ah)为剩余的扇区号
   > 			
   > 			mov ch,al		;(ch)=磁道号
   > 			mov cl,ah
   > 			inc cl			;(cl)=扇区号
   > 			
   > 			
   > 			pop ax			;恢复功能号
   > 			mov al,1		;读写一个扇区
   > 			
   > 			mov bl,ah
   > 			mov bh,0
   > 			add bx,bx	;根据ah中的功能号计算对应子程序在table表中的偏移
   > 			mov si,0
   > 			mov ds,si
   > 			call word ptr table[bx]	;调用对应的功能子程序
   > 			
   > 			
   > sret:		pop ax
   > 			pop dx
   > 			pop cx
   > 			iret
   > 			
   > read:		
   > 			mov ah,2			
   > 			int 13h
   > 			
   > write:		
   > 			mov ah,3
   > 			int 13h
   > 				
   > errors:			mov ah,0		;返回错误
   > 
   > int7chend:		nop
   > 
   > code ends
   > end start
   > ```
   >
   > 2、总结
   >
   > 在debug下进行测试，当给定<u>mov dx,2879   ;逻辑扇区号为2879</u>时，下面参数显示正确，由于时间不足，未在软盘上进行测试。
   >
   > <img src=http://thyrsi.com/t6/385/1539165723x1822611263.png />
   >
   > 犯过的错误：
   >
   > 1. 栈指针设置错误，致使程序执行第35行时出现未知程序，原因是sp刚开始设置成128（将db看成dw，造成误设），由于程序也在这个溢出的栈空间中，当29行与31行执行时，其内容便覆盖到该处（35行处对应的地址）本应该是正确指令的位置，从而当执行35行时便会是执行覆盖的指令。
   > 2. 在使用书中算法进行逻辑扇区号与各种参数的转换过程中，由于未及时恢复ah入口参数，造成数据标号偏移地址计算不准确，解决方法便是在子程序起始处保存在末尾，计算偏移地址之前先恢复，由于sret 和 read或者write只会执行其中一种情形，故不会造成重复弹出。

## End

1. 通过这次汇编语言学习，对计算机底层有了一定的了解，能够写些简单的程序，行数500行左右，寒假需要深入学习计算机从加电开始到把控制权交给OS的完整的过程，并能自己动手按照自己的要求进行编程，此外，能够自己写些对自己实用的小程序。

