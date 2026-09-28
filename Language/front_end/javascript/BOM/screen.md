
### screen 对象

screen 对象包含有关用户屏幕的信息，包含一些属性：
- screen.availWidth：可用的屏幕宽度
- screen.availHeight：可用的屏幕高度

### 可用宽度

screen.availWidth 属性返回访问者屏幕的宽度，以像素计，减去界面特性，比如窗口任务栏
```js
console.log("可用宽度："+screen.availWidth)
```

### 可用高度

screen.availHeight 属性返回访问者屏幕的高度，以像素计，减去界面特性，比如窗口任务栏
```js
console.log("可用高度: " + screen.availHeight);
```