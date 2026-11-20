
## session

requests 中的 Session 类能自动处理发送请求获取响应过程中产生的 cookie，进而达到状态保持的目的
- HTTP 持久连接
- Cookie 持久化
- 请求头统一管理
- 上下文隔离

> Session 会自动处理 cookie，即下一次请求会带上前一次 cookie，使用前需要实例化 Session 对象

```python
s1 = requests.Session()
s1.headers # 全局请求头
s1.cookies # 会话CookieJar对象
s1.adapters # 连接池适配器，管理TCP连接

s1.post("https://api.bilibili.com/login",
    data={"username":"xxx",
        "password":"xxx"})
s1.headers.update({
    'User-Agent': '...',
    'Referer': 'https://www.bilibili.com/video/BVxxx'
})
video_resp = s1.get('视频baseUrl')
```

## cookie 池

cookie 池中每个 cookie 就代表一个账号

**与 session 区别：**
1. cookie 池中的 cookie 有有效期，session 不需考虑有效期问题
2. cookie 池数据放在用户浏览器上，session 数据放在服务器上
3. cookie 池不如 session 安全，因为可以分析存放在本地的 cooker 并进行 cookie 欺骗
4. session 会在一定时间内保存在服务器上，如果考虑减轻服务器性能应使用 cookie

> [!NOTE]
> 将登录信息等重要信息存放在 session 中，其他信息如要保留放在 cookie 中