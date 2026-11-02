
相比 get，post 请求更安全，适用于登录注册、传输大文本内容
- get 先向服务器发送请求，获取响应内容，携带参数 params
- post 先给服务器一些数据，然后获取响应，携带参数 json

得到 post 请求的数据包后，通常需要引入 json 库将字符串转为 json 对象，应如：
```python
import json
data = json.loads(res.text)
```

```python
class Trans:
    def __init__(self):
        self.url = 'https://dictionary.iciba.com/dictionary/fy/batch?client=6&key=1000006&timestamp=1787896364110&signature=6cbea7f24f83b8b860bf1c267ed124e4'
        self.headers = {
            'User-Agent': random.choice(ua_pool)
        }
    def send(self, data):
        res = requests.post(self.url, headers=self.headers, json=data)
        return res.content.decode()
    def run(self):
        word = input('please enter the word:')
        post_data = {
            'from': "auto",
            'textList': [word],
            'to': "auto"
        }
        data = json.loads(self.send(post_data))
        print(data['data'][0]['out'])
trans = Trans()
trans.run()
```

想要获取服务器返回的 json 中某个数据，通常先去打印或调试查看服务器返回的 json 整体信息，确认该数据通过 json 调用的索引，并且很可能具有时效性

> [!NOTE]
> 上面 URL 参数中 signature 即签名是动态生成的，根据时间戳 timestamp、请求体文本、密钥进行 MD5 运算得出，有到期时间，破解签名加密需要逆向