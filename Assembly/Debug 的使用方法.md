# Debug 的使用方法

1. R命令查看、改变CPU 寄存器的内容；
2. D命令查看内存中的内容；
3. E命令改写内存中的内容；
4. U命令将内存中的机器指令翻译成汇编指令；🐷
5. T命令执行一条机器指令；

<img src=http://thyrsi.com/t6/377/1538223781x-1376440138.png />

![1538224979808](C:\Users\HuJie-pc\AppData\Roaming\Typora\typora-user-images\1538224979808.png)



Overflow of = OV NV [No Overflow]

Direction df = DN (decrement) UP (increment)

Interrupt if = EI (enabled) DI (disabled)

Sign sf = NG (negative) PL (positive)

Zero zf = ZR [zero] NZ [ Not zero]

Auxiliary Carry af = AC NA [ No AC ]

Parity pf = PE (even) PO (odd)

Carry cf = CY [Carry] NC [ No Carry]



The individual abbreviations appear to have these meanings:

OV = OVerflow, NV = No oVerflow. DN = DowN, UP (up).

EI = Enable Interupt, DI = Disable Interupt.

NG = NeGative, PL = PLus; a strange mixing of terms due to the

fact that 'Odd Parity' is represented by PO (rather than

POsitive), but they still could have used 'MI' for MInus.

ZR = ZeRo, NZ = Not Zero.

AC = Auxiliary Carry, NA = Not Auxiliary carry.

PE = Parity Even, PO = Parity Odd. CY = CarrY, NC = No Carry.

 

  

 调试[程序](http://www.xuebuyuan.com/)DEBUG如何表达标志状态？

 溢出OV（overflow，OF＝1）

 无溢出NV（no overflow，OF＝0）

 减量DN（direction down，DF＝1）

 增量UP（direction up，DF＝0）

 允许中断EI（enable interrupt，IF＝1）

 进制中断DI（disable interrupt，IF＝0）

 负NG（negative，SF＝1）

 正PL（plus，SF＝0）

 零ZR（zero，ZF＝1）

 非零NZ（no zero，ZF＝0）

 辅助进位AC（auxiliary carry，AF＝1）

 无辅助进位NA（no auxiliary carry，AF＝0）

 偶校验PE（even parity，PF＝1）

 奇校验PO（odd parity，PF＝0）

 进位CY（carry，CF＝1）

 无进位NC（no carry，CF＝0）

  

 

 AH&AL＝AX(accumulator)：累加寄存器
 BH&BL＝BX(base)：基址寄存器
 CH&CL＝CX(count)：计数寄存器
 DH&DL＝DX(data)：数据寄存器
 SP（Stack Pointer）：堆栈指针寄存器
 BP（Base Pointer）：基址指针寄存器
 SI（Source Index）：源变址寄存器
 DI（Destination Index）：目的变址寄存器
 IP（Instruction Pointer）：指令指针寄存器
 CS（Code Segment): 代码段寄存器
 DS（Data Segment）：数据段寄存器
 SS（Stack Segment）：堆栈段寄存器
 ES（Extra Segment）：附加段寄存器
 OF overflow flag 溢出标志 操作数超出机器能表示的范围表示溢出,溢出时为1. 
 SF sign Flag 符号标志 记录运算结果的符号,结果负时为1. 
 ZF zero flag 零标志 运算结果等于0时为1,否则为0. 
 CF carry flag 进位标志 最高有效位产生进位时为1,否则为0. 
 AF auxiliary carry flag 辅助进位标志 运算时,第3位向第4位产生进位时为1,否则为0. 
 PF parity flag 奇偶标志 运算结果操作数位为1的个数为偶数个时为1,否则为0. 
 DF direcion flag 方向标志 用于串处理.DF=1时,每次操作后使SI和DI减小.DF=0时则增大. 
 IF interrupt flag 中断标志 IF=1时,允许CPU响应可屏蔽中断,否则关闭中断. 
 TF trap flag 陷阱标志 用于调试单步操作

 设置 nv(清除) ov(溢出)

 　　方向 dn(减) up(增)

 　　中断 ei(启用) di(禁用)

 　　正负 ng(负) pl(正)

 　　零 zr(0) nz(非0)

 　　辅助进位 ac(进位) na(不进位)

 　　奇偶校验 pe(偶校验) po(奇校验)

 　　进位 cy(进位) nc(不进位)

 　　如：

 　　OV DN EI NG ZR AC PE CY依次表示OF DF IF SF ZF AF PF CF都为1;

 　　NV UP DI PL NZ NA PO NC依次表示OF DF IF SF ZF AF PF CF都为0.

