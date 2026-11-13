
### history 对象

history 对象包含浏览器历史，为保护隐私，对 JS 访问对象的方法做出限制，一些方法:
- history.back()：与浏览器点击后退按钮相同
- history.forward()：与浏览器点击向前按钮相同

### history.go() 方法

除此之外，可以使用 `history.go()` 来实现向前、后退甚至刷新的功能：
```js
history.go(3) // 表示前进3个页面
history.go(-3) // 表示后退3个页面

history.go(0);  // 参数为0,表示刷新页面
```