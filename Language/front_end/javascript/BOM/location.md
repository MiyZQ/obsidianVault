
### location 对象

location 对象用于获得当前页面地址 URL，并把浏览器重定向到新页面，实例如：
- location.hostname 返回 web 主机的域名
- location.pathname 返回当前页面的路径和文件名
- location.port 返回 web 主机的端口 （80 或 443）
- location.protocol 返回所使用的 web 协议（http: 或 https:）

### location 属性、方法

#### 返回当前页面 URL
```js
console.log(location.href);
// https://www.miy.com/js/js.html
```

#### 返回 URL 路径名
```js
console.log(location.pathname);
// /js/js.html
```

#### 加载新的文档
```js
location.assign("https://www.google.com");
```

> [!NOTE]
> 1. window.location.assign(url) ： 加载 URL 指定的新的 HTML 文档。 就相当于一个链接，跳转到指定的 url，当前页面会转为新页面内容，可以点击后退返回上一个页面
> 
> 2. window.location.replace(url) ： 通过加载 URL 指定的文档来替换当前文档 ，这个方法是替换当前窗口页面，前后两个页面共用一个窗口，所以是没有后退返回上一页的