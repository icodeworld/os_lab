# lab8

## 理论知识

### 文件系统自上而下控制流

> #### FS测试用例::usr/libs/files.c							通用文件系统访问接口
>
> ​		write::	usr/libs/file.c										文件系统相关用户库
>
> ​		sys_write::	usr/libs/syscall.c								用户态文件系统相关系统调用访问接口
>
> ​		syscall::	usr/libs/syscall.c									
>
> ​		sys_write::	/kern/syscall/syscall.c							内核态文件相关系统调用实现
>
> ​									
>
> ##### 												文件系统抽象层-VFS
>
> ​		sysfile_write::		/kern/fs/sysfile.c						file 接口		dir 接口
>
> ​		file_write::			/kern/fs/file.c						Inode 接口	fs接口
>
> ​		vop_write::			/kern/fs/vfs/inode.h						外设接口
>
> ​			
>
> ##### 												Simple FS文件系统实现
>
> ​								sfs的inode实现	sfs的fs实现
>
> ​								sfs的外设访问接口
>
>

