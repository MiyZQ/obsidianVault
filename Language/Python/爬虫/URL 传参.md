
在网页搜索框输入字符串作为 URL 提交时，会自动进行 URL 编码处理，如搜索"何意味"：
```txt
https://cn.bing.com/search?q=%E4%BD%95%E6%84%8F%E5%91%B3
```
搜索词为明文，`q` 参数 `%E4%BD%95%E6%84%8F%E5%91%B3` 为密文，这其中有加密过程

使用 Python 进行明密文处理的方式：
```python
from urllib.parse import quote, unquote

print(quote('何意味'))
print(unquote('%E4%BD%95%E6%84%8F%E5%91%B3'))
```


通过后端传递 URL 参数时，通常会通过 params 携带参数字典，再与 URL 进行结合，如：
```python
params = {
    'q': '何意味'
}
url = 'https://cn.bing.com/search?'
response = requests.get(url, headers=headers, params=params)
```
