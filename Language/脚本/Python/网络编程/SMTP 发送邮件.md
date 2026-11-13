
创建 SMTP 对象：
```python
import smtplib
smtpObj = smtplib.SMTP(host,port,local_hostname)
```
- **host**: SMTP 服务器主机。 你可以指定主机的 ip 地址或者域名如:google.com，这个是可选参数
- **port**: 如果你提供了 host 参数, 你需要指定 SMTP 服务使用的端口号，一般情况下 SMTP 端口号为 25
- **local_hostname**: 如果 SMTP 在你的本机上，你只需要指定服务器地址为 localhost 即可

SMTP 对象使用 sendmail() 方法发送邮件：
```python
SMTP.sendmail(from_addr,to_addr,msg,mail_options,rcpt_options)
```
- **from_addr**: 邮件发送者地址。
- **to_addrs**: 字符串列表，邮件发送地址。
- **msg**: 发送消息

> [!ATTENTION]
> 这其中需要注意 msg 的邮件格式，标准邮件需要三个头部信息：From、To、Subject

### 实例

```python
import smtplib
from email.mime.text import MIMEText
from email.header import Header

sender = 'from@miy.com'
receivers = ['demo@test.com']

msg = MIMEText('Test','plain','utf-8')
msg['From'] = Header('miy','utf-8')
msg['To'] = Header('test','utf-8')
subject = 'this is a test'
msg['Subject'] = Header(subject,'utf-8')

try:
    smtpObj = smtplib.SMTP('localhost')
    smtpObj.sendmail(sender,receivers,msg.as_string())
    print('finished')
except smtplib.SMTPException:
    print('error:cant send email')
```
如果没有 sendmail 安装，可以使用其他服务商的 SMTP 访问，添加下面代码：
```python
mail_host = 'smtp.XXX.com'
mail_user = 'XXX'
mail_pass = 'XXXXXX'
```
并将原代码中 try 部分修改为：
```python
try:
    smtpObj = smtplib.SMTP()
    smtpObj.connect(mail_host,25)
    smtpObj.login(mail_user,mail_pass)
    smtpObj.sendmail(sender,receivers,msg.as_string())
    print('finished')
except smtplib.SMTPException:
    print('error:cant send email')
```

### 发送 HTML 格式的邮件

只需将 MIMEText 中 `_subtype` 设置为 html 即可：
```python
mail_msg = """
<p>Python email sending test...</p>
<p><a href="http://www.google.com">Google</a></p>
"""

msg = MIMEText(mail_msg, 'html', 'utf-8')
msg['From'] = Header("miy", 'utf-8')
msg['To'] =  Header("test", 'utf-8')
subject = 'Python SMTP email test'
msg['Subject'] = Header(subject, 'utf-8')
```

### 发送带附件的邮件

首先需创建 MIMEMultipart() 实例，然后构建附件（多个附件可依次构建），最后利用 smtplib.smtp 发送
```python
from email.mime.multipart import MIMEMultipart

msg = MIMEMultipart()
msg['From'] = Header("Test", 'utf-8')
msg['To'] =  Header("test", 'utf-8')
subject = 'Python SMTP test'
msg['Subject'] = Header(subject, 'utf-8')

msg.attach(MIMEText('this is a test', 'plain', 'utf-8'))

att1 = MIMEText(open('test.txt', 'rb').read(), 'base64', 'utf-8')
att1["Content-Type"] = 'application/octet-stream'
# filename写什么，邮件中显示什么
att1["Content-Disposition"] = 'attachment; filename="test.txt"'
msg.attach(att1)

att2 = MIMEText(open('demo.txt', 'rb').read(), 'base64', 'utf-8')
att2["Content-Type"] = 'application/octet-stream'
att2["Content-Disposition"] = 'attachment; filename="demo.txt"'
msg.attach(att2)
```

### 在 HTML 文本中添加图片

邮件的 HTML 文本中一般邮件服务商添加外链是无效的，应该如下：
```python
msgRoot = MIMEMultipart('related')
msgRoot['From'] = Header("Test", 'utf-8')
msgRoot['To'] =  Header("test", 'utf-8')
subject = 'Python SMTP test'
msgRoot['Subject'] = Header(subject, 'utf-8')

msgAlternative = MIMEMultipart('alternative')
msgRoot.attach(msgAlternative)

mail_msg = """
<p>Python email test...</p>
<p><a href="http://www.google.com">Google</a></p>
<p>picture：</p>
<p><img src="cid:image1"></p>
"""

msgAlternative.attach(MIMEText(mail_msg, 'html', 'utf-8'))

# 指定图片为当前目录
fp = open('test.png', 'rb')
msgImage = MIMEImage(fp.read())
fp.close()

# 定义图片 ID，在 HTML 文本中引用
msgImage.add_header('Content-ID', '<image1>')
msgRoot.attach(msgImage)
```

### 第三方 SMTP 使用模板

```python
import smtplib
from email.mime.text import MIMEText
from email.utils import formataddr

my_sender = 'xx@x.com'  
my_pass = 'xxx'          
receiver = 'xx@x.com'    

def mail(content):
    ret=True
    try:
        msg=MIMEText(content,'plain','utf-8')
        msg['From']=formataddr(["Frommiy",my_sender])
        msg['To']=formataddr(["FK",receiver])          
        msg['Subject']="this is a test"   
                   
        server=smtplib.SMTP_SSL("smtp.163.com", 465)
        server.login(my_sender, my_pass)
        server.sendmail(my_sender,receiver,msg.as_string())
        server.quit()
        
    except Exception:
        ret=False
    return ret

ret=mail('Test')

if ret:
    print("finished")
else:
    print("error")
```

效果：
![](assets/SMTP%20发送邮件/file-20260909183415929.png)