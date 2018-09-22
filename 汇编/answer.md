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

#### lab1

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

#### lab2

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

#### lab3

1. #### ; t1.asm 

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

#### lab4

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

   ```scss
   assume cs:code
   code segment
   
   	mov ax,cs
   	mov ds,ax
   
    	mov ax,0020h
   	mov es,ax
   
   	mov bx,0
   	mov cx,001ch
     
     s:mov al,[bx]
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

```assembly
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


