
> Browser Object Model 使 JS 与浏览器具有交互的能力

### window 对象

window 对象表示浏览器窗口，所有 JS 全局对象、函数、变量均自动成为 window 对象的成员：
	全局变量是 window 对象的属性，全局函数是 window 对象的方法

> HTML DOM 的 document 也是 window 对象的属性之一

### Window 尺寸

有三种方法确定浏览器窗口的尺寸：
	对于 Internet Explorer、Chrome、Firefox、Opera 以及 Safari：
	- window.innerHeight - 浏览器窗口的内部高度(包括滚动条)
	- window.innerWidth - 浏览器窗口的内部宽度(包括滚动条)
	对于 Internet Explorer 8、7、6、5：
	- document.documentElement.clientHeight
	- document.documentElement.clientWidth
	或者：
	- document.body.clientHeight
	- document.body.clientWidth

实用的 JS 方案：
```js
var w=window.innerWidth
|| document.documentElement.clientWidth
|| document.body.clientWidth;
 
var h=window.innerHeight
|| document.documentElement.clientHeight
|| document.body.clientHeight;
```

### 其他 Window 方法

一些其他方法：
- window.open() - 打开新窗口
- window.close() - 关闭当前窗口
- window.moveTo() - 移动当前窗口
- window.resizeTo() - 调整当前窗口的尺寸

> [!NOTE]
> 1、全局变量不能通过 delete 操作符删除；而 window 属性上定义的变量可以通过 delete 删除
> 	全局变量不能通过 delete 删除，因为通过 var 定义全局变量会有一个名为 `[Configurable]` 的属性，默认值为 false，所以这样定义的属性不可以通过 delete 操作符删除
> ```js
> var num=123;
> window.str="string";
> delete num;
> delete str;
> console.log(num); //123
> console.log(str); //str is not defined
> ```
> 
> 2、访问未声明的变量会抛出错误，但是通过查询 window 对象，可以知道某个可能未声明的变量是否存在
> ```js
> var newValue=oldValue; // 报错：oldValue is not defined
> var newValue=window.oldValue; // 不会报错
> console.log(newValue); // undefined
> ```
> 
> 3、有些自执行函数里面的变量，想要外部也访问到的话，在 window 对象上直接定义属性
