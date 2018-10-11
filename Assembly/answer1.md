# Assembly

## Chapter 2

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

lab1

1. (1)Use Debug to write the following procedure segmentation into the memory,performing line by line,at the same time, watching the change regard the contents of relative registers.


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




## Chapter 3





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
   mov sp,0010H               ;init the stack top
   
   mov ax,001AH
   mov bx,001BH              ;give value
   
   push ax
   push bx				      ;bx is at the top
   
   pop ax
   pop bx					  ;exchange
   
   3.10
   mov ax,1000H
   mov ss,ax
   mov sp,2                  ;need attention
   
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
   mov sp,0   ;need attention
   ```

### lab2

1. 

   ```
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

   store the address of next instruction so as to find the entry address of keeping the state before using the stack. 



## Chapter 4





1. complete procedure:

   ```assembly
   assume cs:abc
   
   abc segment
   	
     mov ax,2
     add ax,ax
     add ax,ax
     
     mov ax,4c00H
     int 21H
     
   abc ends
   
   end
   ```

### lab3



- ```assembly
  sume cs:codesg
  
  codesg segment
  
     mov ax,2000H         ax= 2000H
  
     mov ss,ax		    			ss= 2000H   sp= 0 
  
     mov sp,0				
     add sp,10						ss= 2000H   sp= 000AH	top= 
  
     pop ax				ax=	0000H	ss= 2000H   sp= 000CH
  
     pop bx				bx= 0000H	ss= 2000H   sp= 000EH
  
     push ax              ax= 0000H   ss= 2000H	sp= 000CH
  
     push bx				bx= 0000H	ss= 2000H	sp= 000AH
  
     pop ax				ax= 0000H	ss= 2000H	sp= 000CH
  
     pop bx				bx= 0000H	ss= 2000H	sp= 000EH
  
     mov ax,4c00H
  
     int 21H
  
  codesg ends
  
  end 
  
  
  ```



## Chapter 5



1. ```assembly
   ;5.1
   
   mov ax,2000H
   mov ds,ax
   
   mov bx,1000H
   mov ax,[bx]
   
   inc bx
   inc bx              21000H  BE 
   					21001H	00
   mov [bx],ax    		21002H  BE
   					21003H  00
   inc bx				21004H  BE
   inc bx				21005H	BE
   					21006H  BE
   mov [bx],ax			21007H
   
   
   inc bx
   mov [bx],al
   
   inc bx
   mov [bx],al
   ```

   ```assembly
   ;task 1:
   assume cs:code 
   
   code segment
   
       mov ax,2
       mov cx,11
     
   s:	add ax,ax
       loop s
       
       mov ax,4c00H
       int 21H
     
    code ends
   
    end
   ```

   ```assembly
   ;problem 5.2
   assume cs:abc
   
   abc segment 
   
      mov ax,0
      mov cx,123
      
   s: add ax,236
      loop s
      
      mov ax,4c00H
      int 21H
      
   abc ends
   
   end
   ```

   ```assembly
   ;problem 5.3
   assume cs:abc
   
   abc segment 
      
      mov ax,0FFFFH
      mov ds,ax
      mov bx,6      ;or mov al,ds:[0]
      mov al,[bx]   ;set ds:bx point to ffff:6
      
      mov ah,0
    
      mov dx,0     ;accumulate register clear 0
      mov cx,3		;loop 3 times
      
   s: add dx,ax    ;accumulate (ax)*3
      loop s
      
      mov ax,4c00H
      int 21H      ;return
      
   abc ends
   
   end
   ```

   ```assembly
   ;problem 5.4
   assume cs:abc
   
   abc segment 
      
      mov ax,0FFFFH
      mov ds,ax
      mov bx,0
      mov dx,0           ;init
      mov cx,12
        
   s: mov al,[bx]
      mov ah,0
      add dx,ax
      inc bx
      loop s
      
      mov ax,4c00H
      int 21H      ;return
      
   abc ends
   
   end
   ```

   ```assembly
   assume cs:code
   code segment
   
      mov ax,0
      mov ds,ax
      mov ds:[26h],ax
      
      mov ax,4c00h
      int 21h
      
   code ends
   end
   ```

   ```assembly
   ;problem 5.8
   assume cs:abc
   
   abc segment 
      
      mov bx,0
      mov cx,12
      
   s: mov ax,0ffffh
      mov ds,ax
      mov dl,[bx]      ;(dl)=((ds)*16+(bx))
      
      mov ax,0020h
      mov ds,ax
      mov [bx],dl      ;((ds)*16+(bx))=(dl)
      
      inc bx           ;(bx)=(bx)+1
      loop s
      
      mov ax,4c00H
      int 21H      ;return
      
   abc ends
   
   end
   
   ;improved
   
   assume cs:abc
   
   abc segment 
      
      mov bx,0
      mov cx,12
      
      mov ax,0ffffh
      mov ds,ax
      
      mov ax,0020h
      mov es,ax
     
   s: mov dl,[bx]      ;(dl)=((ds)*16+(bx))
      mov es:[bx],dl      ;((ds)*16+(bx))=(dl)
      
      inc bx           ;(bx)=(bx)+1
      loop s
      
      mov ax,4c00H
      int 21H      ;return
      
   abc ends
   
   end
   ```

### lab4

1. programming.convert data from 0~63(3FH) to 0:200~0:23F in memory in turn.

   ```assembly
   assume cs:code 
   
   code segment
   
       mov bx,0
       mov cx,64
       
       mov ax,0020H
       mov ds,ax
       
   s:  mov [bx],bx
       inc bx
       loop s
       
       mov ax,4c00H
       int 21H
     
    code ends
    
    end
   ```

   ![1537535647261](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537535647261.png)

2. programming.like above

3. programming.cope data from the instruction before "mov ax,4c00h" to 0:200 in memory

   (1)What is the content of copy?where is it from to?

   (2)What is the content of copy?How many Byte they have?How to know?  



   1. the content are the machine code of instruction.from "mov ax,cx" to "loop s"
   2. the content are the machine code of instruction.The total Byte are shown in the value of cs().We can derive the information through counting the Byte number of content that we are to copy,that is to say, the machine code that is correspond to the instruction.

   ```assembly
   assume cs:code
   code segment
   
   	mov ax,cs
   	mov ds,ax
   
    	mov ax,0020h
   	mov es,ax
   
   	mov bx,0
   	mov cx,001ch
     
     s:mov al,ds:[bx]
   	mov es:[bx],al
   
   	inc bx
   	loop s
   
   	mov ax,4c00h
   	int 21h
   code ends
   end
   	
   
   
   
   ```

   ![1537580080802](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537580080802.png)

   ![1537580249005](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537580249005.png)

  

## Chapter 6



1. ```assembly
   assume cs:code
   
   code segment
   
   	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
   	
   	mov bx,0
   	mov ax,0
   	
   	mov cx,8
     s:add ax,cs:[bx]
       add bx,2
       loop s 
       
       mov ax,4c00h
       int 21h
       
   code ends
   end
   ```

2. 

   ```assembly
   ;entry
   assume cs:code
   
   code segment
   
   	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
   
       start:      mov bx,0
                   mov ax,0
   
                   mov cx,8
           s:      add ax,cs:[bx]
                   add bx,2
                   loop s 
   
                   mov ax,4c00h
                   int 21h
   
   code ends
   end start
   ```

   ```assembly
   ;6.2
   assume cs:code
   
   codesg segment
   
   	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
   
   	dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0   ;derive the meoroty space or define 16 word type of data.
   	
       start:      mov ax,cs
                   mov ss,ax
                   mov sp,30h
                   
                   mov bx,0
                   mov cx,8
           s:      push cs:[bx]
           		add bx,2
           		loop s
           		
           		mov bx,0
           		mov cx,8
           s0:		pop cs:[bx]
           		add bx,2
           		loop s0
           		
                   mov ax,4c00h
                   int 21h
   
   codesg ends
   end start
   ```

   ### test 6.1

   The following program increments the function that using the content of 0:0~0:15 in memory unit revises the data of program in turn.

   ```assembly
   assume cs:codesg
   
   codesg segment
   
       dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
       
   start:		    mov ax,0
       			mov ds,ax
       			mov bx,0
       			
       			mov cx,8
       	  s:	mov ax,ds:[bx]
       	  		mov cs:[bx],ax
   		    	add bx,2
   		    	loop s
   		    	
   		    	mov ax,4c00h
   		    	int 21h
   codesg ends
   end start
   ```

   (2)use stack to accomplish the above function.

   ```assembly
   assume cs:codesg
   
   codesg segment
   
       dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
       dw 0,0,0,0,0,0,0,0,0,0   ;use 20B to be stack. 
       
   start:		    mov ax,cs
       			mov ss,ax
       			mov sp,36
       			
       		    mov ax,0
       		    mov ds,ax
       		    mov bx,0
       		    mov cx,8
   		    	
   		   s:   push ds:[bx]
   		        pop  cs:[bx]
   		        add bx,2
   		        loop s
   		        
   		    	mov ax,4c00h
   		    	int 21h
   codesg ends
   end start
   ```

   ![1537603305459](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537603305459.png)

   ```assembly
   ;6.4
   assume cs:code,ds:data,ss:stack
   
   data segment
   
       dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
       
   data ends
   
   stack segment
   
       dw 0,0,0,0,0,0,0,0,0,0   ;use 20B to be stack. 
   
   stack ends
   
   code segment
   
   start:    mov ax,stack  
   	      mov ss,ax
   	      mov sp,20h    ;ss:sp points to stack:20
   	      
   	      mov ax,data
   	      mov ds,ax     ;ds points to data segment
   	      
   	      mov bx,0      ;ds:bx points to the first unit of data segment
   	      
   	      mov cx,8
   	   s: push [bx]
   	      add bx,2
   	      loop s        ;out stack
   	      
   	      mov bx,0
   	      mov cx,8
   	   s0:pop [bx]
   	      add bx,2
   	      loop s0       ;in stack
   	      
   	      mov ax,4c00h
   	      int 21h
   	      
   code ends
   end start
   ```

### lab5

1. ```assembly
   assume cs:code,ds:data,ss:stack
   
   data segment
   	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
   data ends
   
   stack segment
   	dw 0,0,0,0,0,0,0,0
   stack ends
   
   code segment
   
   start:	mov ax,stack
   		mov ss,ax
   		mov sp,16
   		
   		mov ax,data
   		mov ds,ax
   		
   		push ds:[0]
   		push ds:[2]
   		pop  ds:[2]
   		pop  ds:[0]
   		
   		mov ax,4c00h
   		int 21h
   code ends
   
   end start
   ```

   ![1537605562692](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537605562692.png)

   1.  above

   2. cs= 076CH、ss= 076BH、ds= 076AH

   3. ss= x-0001H

      ds=x-0002H

2. 

   ```assembly
   assume cs:code,ds:data,ss:stack
   
   data segment
   	dw 0123h,0456h
   data ends
   
   stack segment
   	dw 0,0
   stack ends
   
   code segment
   
   start:	mov ax,stack
   		mov ss,ax
   		mov sp,16
   		
   		mov ax,data
   		mov ds,ax
   		
   		push ds:[0]
   		push ds:[2]
   		pop ds:[2]
   		pop ds:[0]
   		
   		mov ax,4c00h
   		int 21h
   code ends
   
   end start
   ```

   ![1537606502921](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537606502921.png)

   1. above

   2. cs= 076CH、ss= 076BH、ds= 076AH

   3. ss= x-0001H

      ds=x-0002H

   3

   ```assembly
   assume cs:code,ds:data,ss:stack
   
   code segment
   
   start:	mov ax,stack
   		mov ss,ax
   		mov sp,16
   		
   		mov ax,data
   		mov ds,ax
   		
   		push ds:[0]
   		push ds:[2]
   		pop  ds:[2]
   		pop  ds:[0]
   		
   		mov ax,4c00h
   		int 21h
   code ends
   
   data segment
   	dw 0123H,0456H
   data ends
   
   stack segment
   	dw 0,0
   stack ends
   
   end start
   ```

   ![1537616395409](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537616395409.png)

   1. above
   2. cs=  076AH  ss= 076EH ds= 076DH
   3. ​                            X+4H          X+3H

   4

   ![1537617621089](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537617621089.png)

   ![1537617644618](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537617644618.png)

   ![1537617664048](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537617664048.png)

   There is only (3) can perform correctly.Because code segment is the first code to perform ,that means cs:ip points to the instruction "mov ax,stack", when loaded in memory unit.

   5

   ```assembly
   assume cs:code
   
   a segment
   	db 1,2,3,4,5,6,7,8
   a ends
   
   b segment
   	db 1,2,3,4,5,6,7,8
   b ends
   
   c segment
   	db 0,0,0,0,0,0,0,0
   c ends
   
   code segment
   
   start:
   	mov ax,a
   	mov ds,ax
   	
   	mov ax,b
   	mov es,ax
   	
   	mov bx,0
   	mov cx,8
   	
     s:mov al,ds:[bx]   
       add al,es:[bx]
     	mov dx,c
     	mov ss,dx
     	mov ss:[bx],al;    
     	inc bx
     	loop s
     	
   ;s: mov ax,b
     ;	mov es,ax
     ;	mov al,ds:[bx]
     ; add al,es:[bx]
     ;	mov dx,c
     ;	mov es,dx
     ;	mov es:[bx],al;
     ;	inc bx
     ;	loop s
     
     	mov ax,4c00h
     	int 21h
     	
   code ends
   
   end start
     	
   	
   ```

   ![1537619701998](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537619701998.png)

   ![1537620110747](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537620110747.png)

   6 use push to accomplish the function.

   ```assembly
   assume cs:code
   
   a segment
   	dw 1,2,3,4,5,6,7,8,9,0ah,0bh,0ch,0dh,0eh,0fh,0ffh
   a ends
   
   b segment
   	dw 0,0,0,0,0,0,0,0
   b ends
   
   code segment
   
   start:
   	mov ax,b
   	mov ss,ax
   	mov sp,16   ;init the stack
   	
   	mov bx,0
   	mov cx,8
   	
   	mov ax,a
   	mov ds,ax
   	
     s:push ds:[bx]
       add bx, 2
       loop s
       
       mov ax,4c00h
       int 21h
       
   code ends
   
   end start	 
   ```

   ![1537621367582](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537621367582.png)



## Chapter 7

1. 

   ```assembly
   ;7.4
   assume cs:codesg,ds:datasg
   
   datasg segment
   	db 'BaSiC'
   	db 'iNfOrMation'
   datasg ends
   
   codesg segment
   start:
   	mov ax,datasg
   	mov ds,ax
   	
   	mov bx,0
   	mov cx,5
   	
     s:mov al,[bx]
     	and al,11011111B
     	mov [bx],al
     	inc bx
     	loop s
     	
     	mov bx,5
     	mov cx,11
    s0:mov al,[bx]
   	or  al,00100000B
   	mov [bx],al
   	inc bx
   	loop s0
   	
   	mov ax,4c00h
   	int 21h
   
   codesg ends
   
   end start
   ```

   ![1537623409369](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537623409369.png)

   ```assembly
   ;7.6 improved 
   assume cs:codesg,ds:datasg
   
   datasg segment
   	db 'BaSiC'
   	db 'iNfOrMation'
   datasg ends
   
   codesg segment
   start:
   	mov ax,datasg
   	mov ds,ax
   	
   	mov bx,0
   	mov cx,5
   	
     s:
       mov al,0[bx]      ;locate the character of the first string 
     	and al,11011111B
     	mov 0[bx],al      
     	
     	mov al,5[bx]      ;locate the character of the second string
   	or  al,00100000B
   	mov 5[bx],al
   	
     	inc bx
     	loop s
     	
     	mov bx,5
     	mov cx,11
   
   	mov ax,4c00h
   	int 21h
   
   codesg ends
   
   end start
   
   ```

   ```assembly
   ;problem7.2
   ;7.6 improved 
   assume cs:codesg,ds:datasg
   
   datasg segment
   	db 'welcome to masm!'
   	db '................'
   datasg ends
   
   codesg segment
   start:
   	mov ax,datasg
   	mov ds,ax
   	
   	mov si,0
   	mov di,16
   	
   	mov cx,8
     s:
       mov ax,[si]      
       mov [di],ax
     	add si,2
       add di,2
     	loop s
     	
     	mov bx,5
     	mov cx,11
   
   	mov ax,4c00h
   	int 21h
   
   codesg ends
   
   end start
   ```

   ```assembly
   ;problem7.2
   ;7.6 improved 
   assume cs:codesg,ds:datasg
   
   datasg segment
   	db 'welcome to masm!'
   	db '................'
   datasg ends
   
   codesg segment
   start:
   	mov ax,datasg
   	mov ds,ax
   	
   	mov si,0
   	
   	mov cx,8
     s:
       mov ax,[si]      
       mov 16[si],ax
     	add si,2
     	
     	loop s
     	
     	mov bx,5
     	mov cx,11
   
   	mov ax,4c00h
   	int 21h
   
   codesg ends
   
   end start
   ```

   ```assembly
   assume cs:codesg,ds:datasg
   
   datasg segment
   	db	'1. file         '
   	db	'2. edit	 	 '
   	db 	'3. search		 '
   	db	'4.	view		 '
   	db 	'5.	options      '
   	db	'6.	help		 '
   datasg ends
   
   codesg segment
    start:
    		mov ax,datasg
    		mov ds,ax
    		
    		mov bx,0
    		mov cx,6
    		
    	  s:mov al,3[bx]
    	    and al,1101111b
    	    mov 3[bx],al
    	    add bx,16
    	    loop s
    	    
    		mov ax,4c00h
   		int 21h
   
   codesg ends
   
   end start
   ```

   ```assembly
   assume cs:codesg,ds:datasg
   
   datasg segment
   	db	'ibm             '
   	db	'dec             '
   	db 	'dos             '
   	db	'vax         	 '
   datasg ends
   
   codesg segment
    start:
    		mov ax,datasg
    		mov ds,ax
    		
    		mov bx,0
    		mov cx,4
    		
    	 s0:mov dx,cx		;store the outer cx value
    	 	mov si,0
    		mov cx,3		;set the inner cricumstance times
    	  s:mov al,[bx][si]
    	    and al,1101111b
    	    mov [bx][si],al
    	    inc si
    	    loop s
    	    
    	    add bx,16
    	    mov cx,dx		;recover the outer cs value
    	    loop s0			;cx--
    	    
    		mov ax,4c00h
   		int 21h
   
   codesg ends
   
   end start
   ```

   ```assembly
   assume cs:codesg,ds:datasg
   
   datasg segment
   	db	'ibm             '
   	db	'dec             '
   	db 	'dos             '
   	db	'vax         	 '
   	dw 0		;define a word to temporarily store cx value
   datasg ends
   
   codesg segment
    start:
    		mov ax,datasg
    		mov ds,ax
    		
    		mov bx,0
    		mov cx,4
    		
    	 s0:mov ds:[40H],cx		;store the outer cx value
    	 	mov si,0
    		mov cx,3		;set the inner cricumstance times
    	  s:mov al,[bx][si]
    	    and al,1101111b
    	    mov [bx][si],al
    	    inc si
    	    loop s
    	    
    	    add bx,16
    	    mov cx,ds:[40H]		;recover the outer cs value
    	    loop s0			;cx--
    	    
    		mov ax,4c00h
   		int 21h
   
   codesg ends
   
   end start
   ```

   ##### Generally speaking,we should both use stack when needing to store data temporarily

   ```assembly
   assume cs:codesg,ss:stacksg ds:datasg
   
   datasg segment
   	db	'ibm             '
   	db	'dec             '
   	db 	'dos             '
   	db	'vax         	 '
   datasg ends
   
   stacksg segment
   	dw 0,0,0,0,0,0,0,0;define a stack using to be stack segment,capacity is 16B
   stacksg ends
   	
   codesg segment
    start:
    		mov ax,stacksg
    		mov ss,ax	
    		mov sp,16	;init stack
    		
    		mov ax,datasg
    		mov ds,ax	;init ds
    		
    		mov bx,0
    		mov cx,4
    		
    	 s0:push cx			;push the outer cx value
    	 	mov si,0
    		mov cx,3		;set the inner cricumstance times
    	  s:mov al,[bx][si]
    	    and al,1101111b
    	    mov [bx][si],al
    	    inc si
    	    loop s
    	    
    	    add bx,16
    	    pop cx			;recover the outer cs value
    	    loop s0			;cx--
    	    
    		mov ax,4c00h
   		int 21h
   
   codesg ends
   
   end start
   ```



### lab6

- 1 11011111B no identify
  2 TAB can't replace space

- ```assembly
  assume cs:codesg,ss:stacksg,ds:datasg
  
  stacksg segment
  	dw 0,0,0,0,0,0,0,0
  stacksg ends
  
  datasg segment
  	db	'1. display      '
  	db	'2. brows        '
  	db 	'3. replace      '
  	db	'4. modify       '
  datasg ends
  	
  codesg segment
   start:
   		mov ax,stacksg
   		mov ss,ax	
   		mov sp,16	;init stack
   		
   		mov ax,datasg
   		mov ds,ax	;init ds
   		
   		mov bx,0
   		mov cx,4
   		
   	 s0:push cx			;push the outer cx value
   	 	mov si,0
   		mov cx,4		;set the inner cricumstance times
   	  s:mov al,3[bx][si]
   	    and al,0dfh
   	    mov 3[bx][si],al
   	    inc si
   	    loop s
   	    
   	    add bx,16
   	    pop cx			;recover the outer cs value
   	    loop s0			;cx--
   	    
   		mov ax,4c00h
  		int 21h
  
  codesg ends
  
  end start
  ```


![1537690828918](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537690828918.png)



## Chapter 8

1. Detail revise thinking process

   ```assembly
   mov ax,seg
   mov ds,ax
   mov bx,60h		;find the record address,ds:bx
   
   mov word ptr [bx+0ch],38
   mov word ptr [bx+0eh],70
   
   mov si,0
   mov byte ptr [si+bx+10h],'V'
   
   inc si
   mov byte ptr [si+bx+10h],'A'
   
   inc si
   mov byte ptr [si+bx+10h],'X'
   ```

   ```c
   struct company {	/*define  struct of a company record
   	char cn[3];
   	char hn[9];
       int pm;
       int sr;
       char cp[3];		
   	};
   struct company dec={"DEC","Ken Olsen",137,40,"PDP"}; /* define valuable of a company record.There is a company record in memory unit
   
   main()
   {
       int i;
       dec.pm=38;
       dec.sr=dec.sr+70;
       i=0;
       dec.cp[i]='V';
       i++;
       dec.cp[i]='A';
       i++;
       dec.cp[i]='X';
       return 0;
   }
   ```

   ```assembly
   mov ax,seg
   mov ds,ax
   mov bx,60h		;record the beginning address to bx
   
   mov word ptr [bx].0ch,38
   
   add word ptr [bx].0eh,70
   
   mov si,0
   mov byte ptr [bx].10h[si],'V'
   inc si
   mov byte ptr [bx].10h[si],'A'
   inc si
   mov byte ptr [bx].10h[si],'X'
   ```

2. 

   ```assembly
   mov dx,1
   mov ax,86a1h
   mov bx,100
   div bx
   ```

   ```assembly
   assume ds:data,cs:code
   
   data segment
   	dd 100001
   	dw 100
   	db 9 dup (0)
   data ends
   
   code segment
   start:
       mov ax,data
       mov ds,ax
       mov ax,ds:[0]
       mov dx,ds:[2]
       div word ptr ds:[4]
       mov ds:[6],ax
       
       mov ax,4c00h
       int 21h
   code ends
   
   end start
   ```


### lab7

1. 

2. ```assembly
   assume cs:code 
   
   data segment
   	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'		;year
   	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
   	db '1993','1994','1995'
   	
   	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
   	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000 ;summ
   	
   	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
   	dw 11542,14430,15257,17800												;ne 
   	
   	dw 4 dup (0)  			 ;store the the entry of 3 kinds of data item and cx 
   data ends
   
   table segment
   	db 21 dup ('year summ ne aa ')
   table ends
   
   
   code segment
   start:
         
           mov ax,data
           mov ds,ax           ;init ds,making it point to the data
   		
           mov ax,table
           mov es,ax
   
           mov bx,0
   		mov cx,21
   		mov word ptr ds:[0d2h],0
   		mov word ptr ds:[0d4h],54h
   		mov word  ptr ds:[0d6h],0a8h	;store the the entry of 3 kinds of data item
   
   	 s0:
   		mov word ptr ds:[0d8h],cx   ;Temporarily store cx variables 
   	 	mov si,0
   	 	mov cx,4
   	 	
   	 s1:
   		mov bp,ds:[0d2h] ;get the address of year 
   	 	mov al,ds:[bp][si]	;convert year
   	 	mov es:[bx].0h[si],al
   	 	inc si
   	 	loop s1
   	 	
   	 	
   		mov bp,ds:[0d4h];Low 16 bits in a word cell are stored in ax
   	    mov ax,ds:[bp]
   		mov es:5[bx],ax
   		mov ax,ds:2[bp] ;high 16 bits in a word cell are stored in ax
   		mov es:7[bx],ax
       
   	
   	 	mov bp,ds:[0d6h];get the address of ne
   		mov ax,ds:[bp]
   		mov es:0ah[bx],ax
   		
   		
   		add bx,16
   		
   		mov ax,ds:[0d2h]
   		add ax,4
   		mov ds:[0d2h],ax
   		
   		mov ax,ds:[0d4h]
   		add ax,4
   		mov ds:[0d4h],ax
   		
   		mov ax,ds:[0d6h]
   		add ax,2
   		mov ds:[0d6h],ax
   		
   		mov cx,ds:[0d8h]
   		loop s0
   				
   		mov cx,21			;count the average income
   		mov bx,0
   	 s2:mov ax,es:5[bx]		;low-16 bits
   		mov dx,es:7[bx]		;high-16 bits
   		div word ptr es:0ah[bx]
   		mov es:0dh[bx],ax
   		
   		add bx,16
   		loop s2
   		
   	 	mov ax,4c00h
   		int 21h
   	
   code ends
   
   end start
   ```

   ![1537862723461](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537862723461.png)


## Chapter 9

#### offset

```assembly
;problem 9.1
assume cs:codesg 
codesg segment
	s:	mov ax,bx
		mov si,offset s
		mov di,offset s0
		mov ax,cs:[si]
		mov cs:[di],ax
		
	s0: nop		;the machine code of nop takes 1 B
		nop
codesg ends
end s
```

#### jmp

1. #### jmp short sign

2. #### jmp near ptr sign

   ```assembly
   assume cs:codesg
   
   codesg segment
   
   start:	
   	mov ax,0
   	jmp short s
   	add ax,1
     s:inc ax
     
    codesg ends		;ax=1(jmp)
    
    end start		
   ```



   ![1537865266604](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537865266604.png)

3. #### jmp far ptr sign(intersegment transfer or far transfer)

   ```assembly
   assume cs:codesg
   
   codesg segment
   	start:mov ax,0
   		  mov bx,0
   		  jmp far ptr s
   		  db  256 dup (0)
   		s:add ax,1
   		  inc ax
   		
   codesg ends
   
   end start
   ```

4. #### jmp word ptr the address of memory unit(intrasegment transfer)

   ```assembly
   mov ax,0123H
   mov ds:[0],ax
   jmp word ptr ds:[0]		;(ip)=0123h
   
   mov ax,0123h
   mov [bx],ax
   jmp word ptr [bx]		;(ip)=0123h
   
   
   ```

5. jmp dword ptr the address of memory unit(intersegment transfer)	

   high address locates the direct segment address  

   low address locates the direct offset address 

   (CS)=(the address of memory unit+2)

   (IP)=(the address of memory unit)

   ```assembly
   mov ax,0123h
   mov ds:[0],ax
   mov word ptr ds:[2],0		;(CS)=0	
   jmp dword ptr ds:[0]		;(IP)=0123h
   
   
   mov ax,0123h
   mov [bx],ax
   mov word ptr [bx+2],0		;(CS)=0
   jmp dword ptr [bx]			;(IP)=0123h
   ```

#####  Test 9.1

1. 

   ```assembly
   assume cs:codesg
   
   data segment
   	db 3 dup (0)	;just need word [1]=0
   data ends
   
   codesg segment
   
   start:
   	mov ax,data
   	mov ds,ax
   	mov bx,0
   	jmp word ptr [bx+1]
     
    codesg ends		
    
    end start	
   ```

   ```assembly
     assume cs:codesg
     
     data segment
     	dd 12345678h
     data ends
     
     codesg segment
     
     start:
     	mov ax,data
     	mov ds,ax
     	mov bx,0
     	mov word ptr [bx],0		;(ip)=0
     	mov [bx+2],cs			;(cs)=cs
     	
     	jmp dword ptr ds:[0]
       
      codesg ends		
      
      end start	 
   ```

​         ![1537869334027](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537869334027.png)

​     3.(CS)=0006H	(IP)=00BEH

##### test 9.2

1. 

2. ```assembly
   assume cs:code 
   code segment
   	start:	
   		mov ax,2000h
   		mov ds,ax
   		mov bx,0
   	  s:
   	  	mov cl,ds:[bx]
   	  	mov ch,0
   	  	jcxz ok
   	  	inc bx	  
   	    jmp short s
   	 ok:mov dx,bx
   	 
   	 	mov ax,4c00h
   	 	int 21h
   code ends 
   ```

   ![1537876506446](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537876506446.png)

##### test 9.3

1. 

2. ```assembly
   assume cs:code 
   code segment
   	start:	
   		mov ax,2000h
   		mov ds,ax
   		mov bx,0
   	  s:
   	  	mov cl,ds:[bx]
   	  	mov ch,0
   	  	inc cx		
   	  	inc bx	  
   	    loop s		;first (cx)=(cx)-1,that mean that stop circumstance when cx=1. 
   	    
   	 ok:
   	 	dec bx
   	 	mov dx,bx
   	 
   	 	mov ax,4c00h
   	 	int 21h
   code ends 
   end start
   ```

   ![1537877489183](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537877489183.png)

3. summary   

   jmp short sign

   jmp near ptr sign

   jcxz     sign

   loop    sign

   Facilitate the floating assembly of the program segment in memory.

### lab 8

- 

  ```assembly
  assume cs:codesg
  codesg segment
  	
  	mov ax,4c00h
  	int 21h
  start:
  		mov ax,0
  	s:	nop
  		nop
  		
  		mov di,offset s
  		mov si,offset s2
  		mov ax,cs:[si]
  		mov cs:[di],ax
  		
  	s0: jmp short s
  	
  	s1: mov ax,0		;F6
  		int 21h			;F9
  		mov ax,0		;FB
  		
  	s2: jmp short s1
  		nop
  		
  codesg ends
  end start
  ```

  the program can return properly.

  Attention,**There is a slight need to move forward or backward when calculating displacement.**

  ![1537881434456](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537881434456.png)

  Because All code in machine are machine code.when performing "mov cs:[di],ax",the sign s that is corresponding instruction turns to EBF6(the value is s2-s1that represents in complemental code,that's -(3+2+3+2)=-10),thus

  ![1537878963981](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537878963981.png)

### lab 9

1. 

   ```assembly
   assume cs:codesg
   
   
   
   codesg segment
   
   start:
   	mov ax,0b800h
   	mov ds,ax
   	mov bx,780h			;row
   						;write character;green
   	mov ds:40h[bx],0277h
   	mov ds:42h[bx],0265h
   	mov ds:44h[bx],026ch
   	mov ds:46h[bx],0263h
   	mov ds:48h[bx],026fh
   	mov ds:4ah[bx],026dh
   	mov ds:4ch[bx],0265h
   	mov ds:4eh[bx],0220h
   	mov ds:50h[bx],0274h
   	mov ds:52h[bx],026fh
       mov ds:54h[bx],0220h
   	mov ds:56h[bx],026dh
   	mov ds:58h[bx],0261h
   	mov ds:5ah[bx],0273h
   	mov ds:5ch[bx],026dh
       mov ds:5eh[bx],0221h
   	
   	
   	
   	
    codesg ends		
    
    end start	 
   ```

![1537949096444](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537949096444.png)

2.

```assembly
assume cs:codesg



codesg segment

start:
	mov ax,0b800h
	mov ds,ax
	mov bx,780h			;row
						;write character;The bottom of the green red
	mov ds:40h[bx],2477h
	mov ds:42h[bx],2465h
	mov ds:44h[bx],246ch
	mov ds:46h[bx],2463h
	mov ds:48h[bx],246fh
	mov ds:4ah[bx],246dh
	mov ds:4ch[bx],2465h
	mov ds:4eh[bx],2420h
	mov ds:50h[bx],2474h
	mov ds:52h[bx],246fh
    mov ds:54h[bx],2420h
	mov ds:56h[bx],246dh
	mov ds:58h[bx],2461h
	mov ds:5ah[bx],2473h
	mov ds:5ch[bx],246dh
    mov ds:5eh[bx],2421h
	
	
	
	
 codesg ends		
 
 end start	 
```

![1537949405786](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537949405786.png)

3.

```assembly
assume cs:codesg



codesg segment

start:
	mov ax,0b800h
	mov ds,ax
	mov bx,780h			;row
						;write character;Blue on white
	mov ds:40h[bx],7177h
	mov ds:42h[bx],7165h
	mov ds:44h[bx],716ch
	mov ds:46h[bx],7163h
	mov ds:48h[bx],716fh
	mov ds:4ah[bx],716dh
	mov ds:4ch[bx],7165h
	mov ds:4eh[bx],7120h
	mov ds:50h[bx],7174h
	mov ds:52h[bx],716fh
    mov ds:54h[bx],7120h
	mov ds:56h[bx],716dh
	mov ds:58h[bx],7161h
	mov ds:5ah[bx],7173h
	mov ds:5ch[bx],716dh
    mov ds:5eh[bx],7121h
	
	
	
	
 codesg ends		
 
 end start	 
```

![1537949631738](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537949631738.png)

```assembly
assume cs:codesg



codesg segment

start:
	mov ax,0b800h
	mov ds,ax
	mov bx,780h			;row
	
							;write character;The bottom of the green red
	mov ds:40h[bx],2477h
	mov ds:42h[bx],2465h
	mov ds:44h[bx],246ch
	mov ds:46h[bx],2463h
	mov ds:48h[bx],246fh
	mov ds:4ah[bx],246dh
	mov ds:4ch[bx],2465h
	mov ds:4eh[bx],2420h
	mov ds:50h[bx],2474h
	mov ds:52h[bx],246fh
    mov ds:54h[bx],2420h
	mov ds:56h[bx],246dh
	mov ds:58h[bx],2461h
	mov ds:5ah[bx],2473h
	mov ds:5ch[bx],246dh
    mov ds:5eh[bx],2421h
	
						;write character;green
	mov ds:20h[bx],0277h
	mov ds:22h[bx],0265h
	mov ds:24h[bx],026ch
	mov ds:26h[bx],0263h
	mov ds:28h[bx],026fh
	mov ds:2ah[bx],026dh
	mov ds:2ch[bx],0265h
	mov ds:2eh[bx],0220h
	mov ds:30h[bx],0274h
	mov ds:32h[bx],026fh
    mov ds:34h[bx],0220h
	mov ds:36h[bx],026dh
	mov ds:38h[bx],0261h
	mov ds:3ah[bx],0273h
	mov ds:3ch[bx],026dh
    mov ds:3eh[bx],0221h
	
							;write character;Blue on white
	mov ds:60h[bx],7177h
	mov ds:62h[bx],7165h
	mov ds:64h[bx],716ch
	mov ds:66h[bx],7163h
	mov ds:68h[bx],716fh
	mov ds:6ah[bx],716dh
	mov ds:6ch[bx],7165h
	mov ds:6eh[bx],7120h
	mov ds:70h[bx],7174h
	mov ds:72h[bx],716fh
    mov ds:74h[bx],7120h
	mov ds:76h[bx],716dh
	mov ds:78h[bx],7161h
	mov ds:7ah[bx],7173h
	mov ds:7ch[bx],716dh
    mov ds:7eh[bx],7121h
	
	
	
	
 codesg ends		
 
 end start	 
```

![1537950299047](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537950299047.png)



## Chapter 10

1. ret retf

   ret -  		pop IP

   1. (IP)=((ss)*16+(sp))
   2. (sp)=(sp)+2

   retf -              pop IP;pop CS

   1. (IP)=((ss)*16+(sp))
   2. (sp)=(sp)+2
   3. (CS)=((ss)*16+(sp))
   4. (sp)=(sp)+2

   test 10.1

   ```assembly
   assume cs:code 
   
   stack segment
   	db 16 dup (0)
   stack ends
   
   code segment
   start:	mov ax,stack
   		mov ss,ax
   		mov sp,16
   		mov ax,1000h
   		push ax
   		mov ax,0
   		push ax
   		retf
   code ends
   
   end start
   ```

   ![1537951735390](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537951735390.png)

2. call

   1. push the current IP or CS and IP

   2. convert

   3. can't accomplish short convert

3.   call sign       = push IP(the first Byte offset address after call instruction)  ; jmp near ptr sign

   1. (sp)=(sp)-2

      ((ss)*16+(sp))=(IP)

   2. (IP)=(IP)+16bit shift(the address of sign - the first Byte address after call instruction)

   test 10.2

> | memory address | machine code | assembly instruction |          perform           |
> | :------------: | :----------: | :------------------: | :------------------------: |
> |     1000:0     |   b8 00 00   |       mov ax,0       |            ax=0            |
> |     1000:3     |   e8 01 00   |        call s        | (stored)ip=6 (current)ip=7 |
> |     1000:6     |      40      |        inc ax        |                            |
> |     1000:7     |      58      |       s:pop ax       |          ax=0006H          |

![1537953460651](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537953460651.png)

4. call far ptr sign   = push CS ;push IP(the first Byte offset address after call instruction) ; jmp far ptr sign

   1. (sp)=(sp)-2

      ((ss)*16+(sp))=(CS)

      (sp)=(sp)-2

      ((ss)*16+(sp))=(IP)

   2. (CS)=the segmental address of sign

      (IP)=the offset address of sign


   test 10.3

   ```assembly
       mov ax,0
       call far ptr s		;ss:[0ch]=0008h,ss:[0eh]=1000h
       inc ax				
   s:	pop ax				;ax=0008h
   	add ax,ax			;ax=0010h
   	pop bx				;bx=1000h
   	add ax,bx			;ax=1010h
   ```

   ![1537954272710](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537954272710.png)

   ![1537954335708](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537954335708.png)

   5. call 16b reg		;push IP; jmp 16b reg

   test 10.4

   ```assembly
   mov ax,6
   call ax
   inc ax
   mov bp,sp
   add ax,[bp]		;ax=0006h+0005h=000bh
   ```

   ![1537955154256](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1537955154256.png)

test 10.5

```assembly
assume cs:code
stack segment
	dw 8 dup (0)
stack ends

code segment
	start: 	
		mov ax,stack
		mov ss,ax
		mov sp,16
		mov ds,ax
		mov ax,0
		call word ptr ds:[0eh]
		inc ax
		inc ax
		inc ax
		
		mov ax,4c00h
		int 21h
code ends
end start	
```

Push the 0011h into stack and IP=0 after performing "call ",cs:ip points to "mov ax,stack",push the 0011h in stack and IP=0011h when performing "call"again,cs:ip points to "inc ax" ...ax=3

(2)

```assembly
assume cs:code
data segment
	dw 8 dup (0)
data ends

code segment
	start:
		mov ax,data
		mov ss,ax
		mov sp,16
		mov word ptr ss:[0],offset s
		mov ss:[2],cs
		call dword ptr ss:[0]
		nop					;1B
	  s:
	  	mov ax,offset s
	  	sub ax,ss:[0ch]
	  	mov bx,cs
	  	sub bx,ss:[0eh]
	  	
	  	mov ax,4c00h
	  	int 21h
code ends
end start
```

(ax)=1,(bx)=0

10.10

sub-program

```assembly
assume cs:code
data segment
	dw 1,2,3,4,5,6,7,8
	dd 0,0,0,0,0,0,0,0
data ends

code segment

   start:mov ax,data
   	 	 mov ds,ax
   	 	 mov si,0		;ds:si points to the fist group word unit
   	 	 mov di,16		;ds:di points to the second group dword unit
   	 	 
   	 	 mov cx,8
   	   s:mov bx,[si]
   	     call cube
   	     mov [di],ax
   	     mov 2[di],dx	
   	     add si,2		;ds:si points to next word unit
   	     add di,4		;ds:di points to next dword unit
   	     loop s
   	     
   	     mov ax,4c00h
   	     int 21h
   	     
   	     ;illustration: Calculate the cubic of N
   	     ;parameter:    (bx)=N
   	     ;result:		(dx:ax)=N^3
   	 
    cube:mov ax,bx
    	 mul bx
    	 mul bx
    	 ret
    
code ends
end start
   	 	
```

```assembly
assume cs:code
data segment
	db 'conversation'
data ends

code segment
	start: mov ax,data
		   mov ds,ax
		   mov si,0			;begining address
		   mov cx,12		;length
		   call capital
		   
		   mov ax,4c00h
		   int 21h

         ;illustration: Capitalization
   	     ;parameter:    (cx)=l
   	     ;result:		(ds:si)=capitalization

  capital:  and byte ptr [si],11011111b	;transform the ds:si that points to unit to capitalization
            inc si						;ds:si point to next unit
            loop capital
            ret  4
code ends
end start
```

```assembly
assume cs:code
data segment
	db 'word',0
	db 'unix',0
	db 'wind',0
	db 'good',0
data ends

code segment

  start:
  		mov ax,data
  		mov ds,ax
  		mov bx,0
  		
  		mov cx,4
  	  s:mov si,bx
  	  	call capital
  	  	add bx,5
  	  	loop s
  	  	
  	  	mov ax,4c00h
  	  	int 21h
  	  	
  	  	;illustration: Capitalization 
   	     ;parameter:    (ds:si)=capitalization 
   	     ;result:		 non
  	  	
capital:mov cl,[si]
		mov ch,0
		jcxz ok
		and byte ptr [si],11011111b
		inc si
		jmp short capital
	 ok:ret
	 
code ends
end start



;improve
	capital:  push cx
			  push si
			  
	 change:  mov cl,[si]
              mov ch,0
              jcxz ok
              and byte ptr [si],11011111b
              inc si
              jmp short capital
           
         ok:  pop si
         	  pop cx
         	  ret
			
```

### lab 10

```assembly
;print char
assume cs:code
data segment
	db 'Welcome to masm!',0
data ends

stack segment 
	dw 8 dup (0)
stack ends

code segment
start:
		mov ax,stack
		mov ss,ax
		mov sp,16
		
		mov dh,10	
		mov dl,3		;8row,3list
		
		mov cl,2		;color
		mov ax,data
		mov ds,ax
		mov si,0		;ds:si beginning address of read content
		call show_str
		
		mov ax,4c00h
		int 21h
	
	show_str:
		push ax
		push cx
		push dx
		push ss
		push si		;Push into sub all registers the stack
		
		mov ax,0b800h
		mov es,ax	;es:si points to the begining address of display 
		
	 
		mov al,160
		mul dh
		mov bx,ax   ;(bx): locate the begining address in graph memory
		
		mov ah,0
		mov al,2
		dec dl
		mul dl
		add bx,ax   ;complete the relation of adress mapping
		
		
		mov di,0	;char offset
		mov si,0	;location offset
		
		mov al,cl	;store color
		
	s1:				;write character;green
		mov ch,0					
		mov cl,ds:[di]		;put the char into cl
		jcxz ok
		
		mov ch,al
		mov es:[si][bx],cx	;pour char and color into displace location 
		
		add si,2
		inc di
	
	    jmp short s1
	
	ok:
		pop si;
		pop ss;
		pop dx;
		pop cx;
		pop ax;
		ret 
		

 code ends		
 
 end start	
```

![1538047813494](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1538047813494.png)

10_2

关键：时刻注意dx ,ax分别代表什么

```assembly
;divdw
assume cs:code,ss:stack

stack segment 
	dw 8 dup (0)
stack ends

code segment
start:
		mov ax,stack
		mov ss,ax
		mov sp,16
		
		mov ax,4240h
		mov dx,000fh
		mov cx,0ah
		call divdw
		
		mov ax,4c00h
		int 21h
		
		;名称：divdw
		;功能:进行不会溢出的除法运算，被除数为dword型，除数为word型,结果为dword型
		;参数;(ax)=dword型数据的低16位
		;	  (dx)=dword型数据的高16位
		;	  (cx)=除数
		
		;返回:(dx)=结果的高16位
		;	  (ax)=结果的低16位
		;	  (cx)=余数
		
  divdw:
		;先计算高位，再计算低位
		push bx			;保存需要用到的寄存器
		push ax			;低位入栈

		
		mov ax,dx		;高位赋给ax
		mov dx,0		;高位置0
		
		div cx     		;结果是 ax:商   dx:余数(rem(H/N)
		mov bx,ax		;保存ax: int(H/N)

		pop ax			
		div cx			;dx:ax rem(H/N)*65536+L/N
		
		mov cx,dx		;余数赋给cx
		add dx,bx		;高位相加
		
		pop bx
		ret

code ends
end start	
```

![1538118481631](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1538118481631.png)

10_3

关键点：

1. 先考虑用什么存放什么。

   ​        首先需要数据段用来指示显卡读入的位置，而该位置上存放着我们所需要的ASCII码，其次，由于需要用到一些子程序，从而需要用栈来保存内容。

2. 考虑用什么程序以及需要调用什么。

   -  首先，需要循环计算余数并放入中转栈（stack2）通过jcxz来判断是否继续计算，注意判断语句需放在计算余数之后，因为即便商为0，余数不为0，需要计入。

   - 由于辗转相除的除法不属于div的使用范围，故调用divdw，只需将高位置0即可使用

3. 注意保护需要用到的寄存器值及相关内容。

   - 由于stack为dtoc和show_str共享，从而需要将sp入栈。

4. 由于辗转相除法得到的是与正常读入相反的顺序，通常情况下优先采用栈来读取，而栈本质上也等于内存中的内容，故未减少麻烦，另定义一个数据段取名为stack2，用来存放逆序的ASCII码。

```assembly
;数值显示
assume cs:code,ss:stack

data segment
	db 16 dup (0)
data ends

stack segment 		;存放寄存器等
	dw 8 dup (0)
stack ends

stack2 segment		;临时存放余数
	dw 8 dup(0)	
stack2 ends

code segment

	start:	
		mov ax,stack
		mov ss,ax
		mov sp,16	;栈初始化用来保存寄存器值
		
		mov ax,stack2
		mov es,ax	;临时存放余数
		
		mov ax,12666
		mov bx,data
		mov ds,bx
		mov si,0
		
		mov cx,0
		
		call dtoc
			
		mov di,0	;转换顺序
		mov cx,si
	s0:	mov al,es:[si-1]
		mov ds:[di],al
		dec si
		inc di
		loop s0

	
		mov dh,8
		mov dl,3
		mov ch,0
		mov cl,2
		
		call show_str
		
		mov ax,4c00h
		int 21h
		
	;名称：dtoc
	;功能：将word型数据转变为表示十进制数的字符串，字符串以0为结尾符
	;参数：(ax)=word型数据
	      ;ds:si指向字符串的首地址
	;返回：无
	;应用举例：编程，将数据12666以十进制的形式在屏幕的8行3列，用绿色显示。
		
	dtoc:   push sp		;供以后的子程序共用一个栈
			mov byte ptr es:[si],0				;0结尾符入栈
			inc si
		;无法使用div指令
		count:	
			mov dx,0	;高位置0 (dx)始终为0
			mov cx,10	;除数 
			call divdw	;调用可能溢出型除法  
			mov bx,cx   ;余数保存在bx中,由于余数为0~9，所以ch=0,从而bh=0		
			mov cx,ax	;商保存在cx中
			
			
			mov es:[si],bl
			add byte ptr es:[si],30H  ;转换为数字对应的ASCII码
			

			inc si		;存储在下一个字节
			
			jcxz o		;由于余数先执行，故判断放在执行程序之后
						;当商为0时结束循环
			
			jmp count   ;辗转相除，计算下一个字节
			
		 o:
		
			pop sp
			ret
			
		;名称：divdw
		;功能:进行不会溢出的除法运算，被除数为dword型，除数为word型,结果为dword型
		;参数;(ax)=dword型数据的低16位
		;	  (dx)=dword型数据的高16位
		;	  (cx)=除数
		
		;返回:(dx)=结果的高16位
		;	  (ax)=结果的低16位
			;	  (cx)=余数
		 divdw:
			;先计算高位，再计算低位
			push bx			;保存需要用到的寄存器
			push ax			;低位入栈

			
			mov ax,dx		;高位赋给ax
			mov dx,0		;高位置0
			
			div cx     		;结果是 ax:商   dx:余数(rem(H/N)
			mov bx,ax		;保存ax: int(H/N)

			pop ax			
			div cx			;dx:ax rem(H/N)*65536+L/N
			
			mov cx,dx		;余数赋给cx
			add dx,bx		;高位相加
			
			
			pop bx
			ret	
			
		
			
	;名称：show_str
	;功能：在指定的位置，用指定的颜色，显示一个用0结束的字符串
	;参数：(dh)=行号（取值范围0~24),(dl)=列号(取值范围0~79),
		  ;(cl)=颜色，ds:si指向字符串的首地址
	;返回：无	
	show_str:
		push ax
		push cx
		push dx
		push ss
		push si		;Push into sub all registers the stack
		
		mov ax,0b800h
		mov es,ax	;es:si points to the begining address of display 
		
	 
		mov al,160
		dec dh
		mul dh
		mov bx,ax   ;(bx): locate the begining address in graph memory
		
		mov ah,0
		mov al,2
		dec dl
		mul dl
		add bx,ax   ;complete the relation of adress mapping
		
		
		mov di,0	;char offset
		mov si,0	;location offset
		
		mov al,cl	;store color
		
	s1:				;write character;green
		mov ch,0					
		mov cl,ds:[di]		;put the char into cl
		jcxz ok
		
		mov ch,al
		mov es:[si][bx],cx	;pour char and color into displace location 
		
		add si,2
		inc di
	
		jmp short s1
	
	ok:
		pop si;
		pop ss;
		pop dx;
		pop cx;
		pop ax;
		ret 
			
		
code ends
end start
```

![1538133183020](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1538133183020.png)