# 简易的操作系统~^Bochs,虚拟软盘与Bootloader^~



1. 开发环境和工具

   1. 必须安装Bochs-2.3,nasm,UltraEdit.
   2. 下载nasm后,添加nasm所在目录到到path目录,建议直接将nasm放到windows或system32目录,方便从命令行调用.
   3. 下载地址：<http://sourceforge.net/projects/nasm>

2. 准备

   - 运行bximage.exe,创建1.44M的软盘,名为boot.img

   <img src=http://thyrsi.com/t6/383/1538988031x-1404755462.png />

3. 创建引导程序boot.asm

   ```assembly
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
   		
   BootMessage:	db "Hello,OS hujie!"
   		times 510-($ - $$) db 0;填充剩下的空间,使生成的二进制代码恰好为512字节,times 123 db 0 ; 这个表示填充123个字节的0,所以，times 510-($-$$) db 0 表示填充 510-($-$$) 这么多个字节的0,这里面的$表示当前指令的地址，$$表示程序的起始地址(也就是最开始的7c00)，所以$-$$就等于本条指令之前的所有字节数。510-($-$$)的效果就是，填充了这些0之后，从程序开始到最后一个0，一共是510个字节。再加上最后的dw两个字节(0xaa55是结束标志)，整段程序的大小就是512个字节，刚好占满一个扇区
   		dw	0xaa55		;结束标志
   ```

4. 编译源文件并复制到软盘镜像文件中

   1. 我的Bochs安装在“D:/SoftTools/Bochs-2.3” ，在该目录下创建一个HelloOS的目录, 以便为后的工作做好准备。将boot.asm保存在“D:/SoftTools/Bochs-2.3/HelloOS” , 同时将上面创建的“boot.img”也保存到“HelloOS”下。下面我们利用上面提到的汇编编译器nasm将上面的汇编程序编译下：

   2.  C:/Documents and Settings/apple>d: 

      D:/>cd D:/SoftTools/Bochs-2.3/HelloOS 

      D:/SoftTools/Bochs-2.3/HelloOS>nasm boot.asm -o boot.bin 

      D:/SoftTools/Bochs-2.3/HelloOS> 

   3. 这之后，你将得到一个名为boot.bin的纯二进制文件，大小正好为512字节。用UltraEdit编辑器打开这个文件，你可以看到这个文件中有一半以上的字节为0，最后两个字节为55和aa。 然后，用你的编辑器打开boot.img，把boot.bin中的内容全部复制到其中.值得注意的是，你应该把内容复制到boot.img的开始处，也就是说，复制后的内容占用了boot.img的0x000到0x1ff字节。值得一提的是，如果复制数据不一样，请确保选择：UltraEdit编辑器 -〉编辑-〉剪贴板-〉用户剪贴板1，

5. 写配置文件

   为了配置的简单起见，将“D:/SoftTools/Bochs-2.3/dlxlinux”目录下的“bochsrc.bxrc”和“run.bat”两个文件复制到“HelloOS”下。我们只要稍微的修改下“bochsrc.bxrc”和“run.bat” 这两个文件就好了。

   1. "bochsrc.bxrc"修改后

      ```yml
      ###############################################################
      # bochsrc.txt file for DLX Linux disk image.
      ###############################################################
      
      # how much memory the emulated machine will have
      megs: 32
      
      # filename of ROM images
      romimage: file= . . / BIOS-bochs-latest
      vgaromimage: file=../VGABIOS-lgpl-latest
      
      # what disk images will be used 
      floppya: 1_44= boot.img, status= inserted
      # floppyb: 1_44=floppyb.img, status=inserted
      
      # hard disk
      ata0: enabled=1, ioaddr1=0x1f0, ioaddr2=0x3f0, irq=14
      # ata0-master: type=disk, path="hd10meg.img", cylinders=306, heads=4, spt=17
      
      # choose the boot disk.
      boot: floppy
      
      # default config interface is textconfig.
      #config_interface: textconfig
      #config_interface: wx
      
      #display_library: x
      # other choices: win32 sdl wx carbon amigaos beos macintosh nogui rfb term svga
      
      # where do we send log messages?
      log: bochsout.txt
      
      # disable the mouse, since DLX is text only
      mouse: enabled=0
      
      # set up IPS value and clock sync
      # cpu: ips=15000000
      # clock: sync=both
      
      # enable key mapping, using US layout as default.
      #
      # NOTE: In Bochs 1.4, keyboard mapping is only 100% implemented on X windows.
      # However, the key mapping tables are used in the paste function, so 
      # in the DLX Linux example I'm enabling keyboard_mapping so that paste 
      # will work.  Cut&Paste is currently implemented on win32 and X windows only.
      
      #keyboard: keymap=../keymaps/x11-pc-us.map
      #keyboard: keymap=../keymaps/x11-pc-fr.map
      #keyboard: keymap=../keymaps/x11-pc-de.map
      #keyboard: keymap=../keymaps/x11-pc-es.map
      ```

6. 运行操作系统

   1. 双击“bochsrc.bxrc”或者“run.bat”
   2. 结果如下图<img src=http://thyrsi.com/t6/383/1538988770x-1404755516.png />

7. BOCHS配置文件

   > 1. 实际上配置BOCHS是很简单的，为什么很多人不会配置呢？我觉的就是因为他使用和配置方式和普通程序不一样——配置文件。实际上配置文件是和ini文件、bat文件类似的。bochs没有给我们提供图形界面的配置工具。这就需要我们自己来修改配置文件。简单的配置就可以让你的操作系统在BOCHS里面跑起来。用BOCHS跑完整的linux和windows是不现实的。实在是太慢了。一般我们也只能把他当成调试器来使用。现在，我们先看一下如何让dos在他里面跑起来。如果你细心的话你会发现在BOCHS文件夹里面有一个bochsrc-sample.txt的文本文件。里面包含了所有了BOCHS参数的信息。这个是官方的教程。可惜是英文的，而且我也没有找到有中文的教程（不然也没有我这篇文章）。在这里我们仅仅介绍最简单的配置选项。好了，废话就不多说了。我们现在就开始。以一个例子来说明，这个例子是我用来跑dos以及我自己的小操作系统的。下面就是我们要用到的最基本的选项：
   >
   > 2. 文件
   >
   >    ```yml
   >    # 在一行的最前面加上“#”表示这一行是注释行。
   >                # 内存，以MB为单位，对于dos来说最大可以访问16MB
   >                # 的内存，我给了他32MB，你可以根据自己的机器来调
   >                # 整
   >                megs: 16
   >                # 下面两句一般是不可以改的，至于干什么用的就不用我说
   >                # 了。从他们的文件名就可以看出来。
   >                romimage: file=../BIOS-bochs-latest, address=0xf0000
   >                vgaromimage: file=../VGABIOS-lgpl-latest
   >                # 这个还用说吗？当然是软驱了，我想我们写操作系统肯定是先
   >                # 把操作系统放在软盘（或映像）里面吧？在BOCHS里面是可
   >                # 以使用任意大小的软驱映像的。可以是1.44或2.88，我一般使
   >                # 用2.88。还有就是BOCHS里面可以使用两个软驱。不过好像
   >                # 我们并不经常这样做。
   >                floppya: 2_88=test.img, status=inserted
   >                #floppyb: 1_44=floppyb.img, status=inserted
   >                # 下面是硬盘，很简单，还有就是BOCHS也是可以支持多个硬
   >                # 盘的。那么，硬盘文件是怎么生成的呢？我们可以发现硬盘是
   >                # img格式的。你注意没有在BOCHS文件夹里有一个工具叫
   >                # bximage.exe，我想你应该猜出来了。他就是用来生成这个硬盘
   >                # 文件的工具。我在这儿还想说的是硬盘分三种格式的，最好选
   >                #用growing类型。这种有一个好处就是节省硬盘空间，不过使用
   >                #这种类型的硬盘还需要在下面加上mode =growing这个选项。
   >                ata0: enabled=1, ioaddr1=0x1f0, ioaddr2=0x3f0, irq=14
   >                ata0-master: type=disk, path="dos.img",cylinders=306, heads=4, spt=17
   >                # 下面这个就是光驱，没什么好说的。如果你想使用物理光驱，
   >                # 只要让path=E:（我们假设E盘是光驱）
   >                ata0-slave: type=cdrom, path="dos.iso",status=inserted
   >                # 这个是启动设备，可以使用cdrom（光驱）、c（硬盘）或floppy（软
   >                # 驱）。
   >                #boot: cdrom
   >                boot: c
   >                #boot: floppy
   >                # 这一句可以不要，他只是指定用来保存日志的文件。如果不指定的
   >                # 话他就会输出到命令控制台上。
   >                log: bochsout.txt
   >                # 这一句是设置在开机时是否激活鼠标，BOCHS对于鼠标的控制不是
   >                # 很好。建议如果不是特别需要的话不要激活他。在运行期间也可以点窗口右上角的鼠标图标来激活他。
   >                mouse: enabled=0
   >    ```



