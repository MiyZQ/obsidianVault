
APP 通常通过 Socket 向网络发出请求或应答网路请求，使主机间或一台计算机上的进程间可以通讯

创建 Socket：
`socket.socket(family,type,proto)`
- **family**: Socket 家族可以是 `AF_UNIX` 或者 `AF_INET`
- **type**: Socket 类型可以根据是面向连接的还是非连接分为 `SOCK_STREAM` 或 `SOCK_DGRAM`
- **proto**: 一般不填默认为 0

### Socket 对象方法

| 函数                                   | 描述                                                                                                                   |
| ------------------------------------ | -------------------------------------------------------------------------------------------------------------------- |
| **服务器端 Socket**                      |                                                                                                                      |
| s.bind()                             | 绑定地址（host,port）到套接字， 在AF_INET下,以元组*（host,port）*的形式表示地址                                                               |
| s.listen()                           | 开始 TCP 监听。backlog 指定在拒绝连接之前，操作系统可以挂起的最大连接数量。该值至少为1，大部分应用程序设为 5 就可以了                                                  |
| s.accept()                           | 被动接受TCP客户端连接,(阻塞式)等待连接的到来                                                                                            |
| **客户端 Socket**                       |                                                                                                                      |
| s.connect()                          | 主动初始化 TCP 服务器连接，一般 address 的格式为元组（hostname,port），如果连接出错，返回 socket.error错误                                            |
| s.connect_ex()                       | connect()函数的扩展版本,出错时返回出错码,而不是抛出异常                                                                                    |
| **公共用途的 Socket 函数**                  |                                                                                                                      |
| s.recv()                             | 接收TCP数据，数据以字符串形式返回，bufsize 指定要接收的最大数据量。flag 提供有关消息的其他信息，通常可以忽略                                                       |
| s.send()                             | 发送TCP数据，将 string 中的数据发送到连接的套接字。返回值是要发送的字节数量，该数量可能小于 string 的字节大小                                                     |
| s.sendall()                          | 完整发送TCP数据。将string中的数据发送到连接的套接字，但在返回之前会尝试发送所有数据。成功返回None，失败则抛出异常                                                      |
| s.recvfrom()                         | 接收UDP数据，与recv()类似，但返回值是（data,address）。其中data是包含接收数据的字符串，address是发送数据的套接字地址                                           |
| s.sendto()                           | 发送UDP数据，将数据发送到套接字，address是形式为（ipaddr，port）的元组，指定远程地址。返回值是发送的字节数                                                      |
| s.close()                            | 关闭套接字                                                                                                                |
| s.getpeername()                      | 返回连接套接字的远程地址。返回值通常是元组（ipaddr,port）                                                                                   |
| s.getsockname()                      | 返回套接字自己的地址。通常是一个元组(ipaddr,port)                                                                                      |
| s.setsockopt(level,optname,value)    | 设置给定套接字选项的值                                                                                                          |
| s.getsockopt(level,optname[.buflen]) | 返回套接字选项的值                                                                                                            |
| s.settimeout(timeout)                | 设置套接字操作的超时期，timeout是一个浮点数，单位是秒。值为None表示没有超时期。一般，超时期应该在刚创建套接字时设置，因为它们可能用于连接的操作（如connect()）                            |
| s.gettimeout()                       | 返回当前超时期的值，单位是秒，如果没有设置超时期，则返回None                                                                                     |
| s.fileno()                           | 返回套接字的文件描述符                                                                                                          |
| s.setblocking(flag)                  | 如果 flag 为 False，则将套接字设为非阻塞模式，否则将套接字设为阻塞模式（默认值）。非阻塞模式下，如果调用 recv() 没有发现任何数据，或 send() 调用无法立即发送数据，那么将引起 socket.error 异常 |
| s.makefile()                         | 创建一个与该套接字相关连的文件                                                                                                      |

### 实例

#### 服务端
使用 Socket() 函数创建 Socket 对象，调用 bind() 函数指定服务端口，再调用 accept（） 方法等待客户端连接、返回 connection 对象，表示已连接到客户端
```python
import socket

serverSocket = socket.socket(
    socket.AF_INET,socket.SOCK_STREAM
)

host = socket.gethostname()
port = 9999

serverSocket.bind((host,port))
serverSocket.listen(5)

while True:
    clientSocket,addr = serverSocket.accept()
    print(f'连接地址为：{addr}')
    msg = '欢迎' + '\r\n'
    clientSocket.send(msg.encode('utf-8'))
    clientSocket.close()
```

#### 客户端
使用 socket.connect() 方法打开一个 TCP 连接到主机，调用 recv() 方法接收小于 1024 字节的数据，操作完成后关闭连接
```python
import socket

clientSocket = socket.socket(
    socket.AF_INET,socket.SOCK_STREAM
)

host = socket.gethostname()
port = 9999

clientSocket.connect((host,port))
msg = clientSocket.recv(1024)
clientSocket.close()
print(msg.decode('utf-8'))
```

#### 操作
打开两个终端，第一个执行服务端文件
`python3 server.py`
第二个执行客户端文件
`python3 client.py`

### Internet 模块

以下列出了 Python 网络编程的一些重要模块：

|协议|功能用处|端口号|Python 模块|
|---|---|---|---|
|HTTP|网页访问|80|httplib, urllib, xmlrpclib|
|NNTP|阅读和张贴新闻文章，俗称为"帖子"|119|nntplib|
|FTP|文件传输|20|ftplib, urllib|
|SMTP|发送邮件|25|smtplib|
|POP3|接收邮件|110|poplib|
|IMAP4|获取邮件|143|imaplib|
|Telnet|命令行|23|telnetlib|
|Gopher|信息查找|70|gopherlib, urllib|