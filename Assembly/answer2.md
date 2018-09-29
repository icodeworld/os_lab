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
