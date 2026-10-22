
代理 ip 指的是一个代理服务器，用于向目标服务器转发请求
1. **正向代理：** 给客户端做代理，服务器不知道客户端真实地址；可保护自己 ip 地址不被封禁（而是代理 ip）
2. **反向代理：** 给服务器做代理，让客户端不知道服务器真实地址

> 正向代理保护客户端，反向代理保护服务器

## PROXIES 代理参数

如：
```python
proxies = {
    "http": "http://xxx.xxx.x.x:7897",
    "https": "http://xxx.xxx.x.x:7897"
}

res = requests.get(url,headers=headers, proxies=proxies)
```

> 如果代理 ip 无效，会自动使用本机真实 ip