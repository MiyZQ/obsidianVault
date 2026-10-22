
> JSON 常用于与服务端交换数据，可以使用此方法将**JS 对象转换为字符串**

## 语法

```js
JSON.stringify(value,replacere,space)
```
- value：要转换的 JS 值，通常为对象或数组
- replacer：可选参数，用于转换结果的函数或数组
	**为函数**： JSON.stringify 将调用该函数，并传入每个成员的键和值。使用返回值而不是原始值。如果此函数返回 undefined，则排除成员。根对象的键是一个空字符串：""
	**为数组**：仅转换该数组中具有键值的成员。成员的转换顺序与键在数组中的顺序一样。当 value 参数也为数组时，将忽略 replacer 数组
- space：可选参数，文本添加缩进、空格和换行符
	如果 space 是一个数字，则返回值文本在每个级别缩进指定数目的空格，如果 space 大于 10，则文本缩进 10 个空格
	space 也可以使用非数字，如：`\t`


## 对象转换实例

将对象发送到服务端：
```js
var obj = { "name":"google", "alexa":10000, "site":"www.google.com"};
var myJSON = JSON.stringify(obj);
document.getElementById("demo").innerHTML = myJSON;
```

> [!NOTE]
> 当转换中有 Date 对象时，JSON.stringify()会将所有日期转换为字符串


## 处理函数

JSON.stringify()会删除 JS 对象的函数，包括键和值，在执行前可以将函数转换为字符串来避免：
```js
var obj = { "name":"google", "alexa":function () {return 10000;}, "site":"www.google.com"};
obj.alexa = obj.alexa.toString();
var myJSON = JSON.stringify(obj);
 
document.getElementById("demo").innerHTML = myJSON;
```