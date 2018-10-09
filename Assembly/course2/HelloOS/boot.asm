org	7c00h;告诉编译器程序加载到了7c00处
	
		mov ax,cs
		mov ds,ax
		mov es,ax
		
		call DispStr	;调用显示字符串例程
		jmp $			;无限循环
		
DispStr:
		mov ax,BootMessage
		mov bp,ax		;es:bp=串地址
		mov cx,16		;cx=串长度
		mov ax,1301h	;ah=13,al=01
		mov bx,000ch		;页号为0,黑底红字高亮
		mov dl,0
		int 10h			;10号中断
		ret
		
BootMessage:	db "Hello,OS world!"
		times 510-($ - $$) db 0;填充剩下的空间,使生成的二进制代码恰好为512字节,times 123 db 0 ; 这个表示填充123个字节的0,所以，times 510-($-$$) db 0 表示填充 510-($-$$) 这么多个字节的0,这里面的$表示当前指令的地址，$$表示程序的起始地址(也就是最开始的7c00)，所以$-$$就等于本条指令之前的所有字节数。510-($-$$)的效果就是，填充了这些0之后，从程序开始到最后一个0，一共是510个字节。再加上最后的dw两个字节(0xaa55是结束标志)，整段程序的大小就是512个字节，刚好占满一个扇区
		dw	0xaa55		;结束标志