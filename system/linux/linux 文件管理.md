
> 以 Ubuntu 为例，系统无盘符的概念，只有一个根目录 / ，是一切文件概念的根节点

## 主要目录
#### /home 
与 windows 不同，linux 是多用户操作系统，而多个用户的隔离由家目录实现
家目录包含各用户名组成的文件夹，不同用户的各种文件在此处被隔离
> [!NOTE]
> 唯一的区别是，系统 administrator 的家目录是 /root
#### /bin 和 /usr/bin
可执行二进制文件的目录，存放**终端命令**如 ls、tar、mv、cat 等
#### /boot
包含 linux 系统**启动**使用的文件，如 linux 的内核文件/boot/vmlinuz，系统引导管理器/boot/grub 等
#### /dev
存放 linux 系统下的**设备**文件，*访问该目录下某文件相当于访问某设备*，常用的是挂载光驱
`mount /dev/cdrom /mnt`
#### /etc
系统*配置文件*存放的目录，重要的配置文件有：./inittab、./fstab、./init.d、./X11、./sysconfig、./xinetd.d
#### /lib、/usr/lib、/usr/local/lib
系统使用的*函数库*的目录，程序执行时需要调用额外参数时需要函数库协助
#### /lost+fount
系统异常产生错误时将一些遗失的片段放置于此目录下
#### /mnt:/media
光盘默认挂载点，通常光盘挂载于/mnt/cdrom 下
#### /opt
给主机额外安装软件所摆放的目录
#### /proc
此目录的数据都在内存中，如系统核心、外部设备、网路状态，比较重要的有：./cpuinfo、./interrupts、./dma、./ioports、./net/* 等
