
> JSON 常用于与服务端交换数据，可以使用此方法将 **JSON 数据转换为 JS 对象，解析 JSON 数据**

## 语法

```js
JSON.parse(text,reviver)
```
- text：有效的 JSON 字符串
- reviver：可选参数，一个转换结果的函数，将为对象的每个成员调用此函数

## JSON 解析实例

从服务端接收以下数据
`{ "name":"google", "alexa":10000, "site":"www.google.com" }`
转换为 JS 对象：
```html
<p id="demo"></p>
 
<script>
var obj = JSON.parse('{ "name":"google", "alexa":10000, "site":"www.google.com" }');
document.getElementById("demo").innerHTML = obj.name + "：" + obj.site;
</script>
```

## 从服务端接收 JSON 数据

使用 AJAX 从服务端请求 JSON 数据，并解析为 JS 对象：
```js
var xmlhttp = new XMLHttpRequest();
xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        myObj = JSON.parse(this.responseText);
        document.getElementById("demo").innerHTML = myObj.name;
    }
};
xmlhttp.open("GET", "/try/ajax/json_demo.txt", true);
xmlhttp.send();
```

## 从服务端接收数组 JSON 数据

如果是数组 JSON 数据，JSON.parse()会将其转换为 JS 数组：
```js
var xmlhttp = new XMLHttpRequest();
xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        myArr = JSON.parse(this.responseText);
        document.getElementById("demo").innerHTML = myArr[1];
    }
};
xmlhttp.open("GET", "/try/ajax/json_demo_array.txt", true);
xmlhttp.send();
```

## 数据解析实例

JSON 不能存储 Date 对象，因此可以将其转换为字符串，之后再转换为 Date 对象：
```js
var text = '{ "name":"google", "initDate":"1145-01-4", "site":"www.google.com"}';
var obj = JSON.parse(text);
obj.initDate = new Date(obj.initDate);
 
document.getElementById("demo").innerHTML = obj.name + "创建日期: " + obj.initDate;
```

也可选择使用 reviver：
```json
var text = '{ "name":"google", "initDate":"1145-01-14", "site":"www.google.com"}';
var obj = JSON.parse(text, function (key, value) {
    if (key == "initDate") {
        return new Date(value);
    } else {
        return value;
}});
 
document.getElementById("demo").innerHTML = obj.name + "创建日期：" + obj.initDate;
```

## 函数解析实例

JSON 虽然不能包含函数，但可以将函数处理成字符串，之后再转换：
```js
var text = '{ "name":"google", "alexa":"function () {return 10000;}", "site":"www.google.com"}';
var obj = JSON.parse(text);
obj.alexa = eval("(" + obj.alexa + ")");
 
document.getElementById("demo").innerHTML = obj.name + " Alexa 排名：" + obj.alexa();
```