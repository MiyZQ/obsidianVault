
### 获取长度

使用 length 属性来获取其长度：
```js
var n = str.length
```

### 查找子串

通过 indexOf() 方法来定位字符串中某指定字符串首次出现的位置：
```js
var n = str.indexOf("hello")
```
如果没找到返回 -1

> [!NOTE]
> lastIndexOf() 方法在字符串末尾开始查找字符串出现位置

### 内容匹配和替换

match() 方法查找字符串特定串，找到返回这个串，否则为 null
```js
var txt = str.match("hello")
```

replace() 方法在字符串中特定串替换成其他串并返回（原串不改变）
```js
var txt = str.replace("hello","js")
```

### 大小写转换

使用方法 toUpperCase()、toLowerCase()
```js
var txt1 = str.toUpperCase()
var txt2 = str.toLowerCase()
```

### 字符串转数组

通过 split() 方法转为数组
```js
var txt = "a,b,c"
var list = txt.split(",") // txt使用逗号分隔
```

