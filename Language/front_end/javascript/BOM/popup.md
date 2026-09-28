
> 可以在 JS 中创建三种信息框：警告框、确认框、提示框

### 警告框

用于确保用户可以得到某些信息，出现后用户需要点击确定才能继续操作
```js
alert("context")
```

### 确认框

通常用于验证是否接受用户操作，弹出时用户点击确认或取消来确定用户操作（返回布尔值）
```js
var r=confirm("按下按钮");
if (r==true) {
    x="按下了\"确定\"按钮";
}
else {
    x="按下了\"取消\"按钮";
}
```

### 提示框

用于提示用户在进入页面前输入某个值，会返回输入的值或 null
语法：
```js
window.prompt("sometext","defaultvalue");
```

```js
var person=prompt("please enter your name","miy");
if (person!=null && person!="")
{
    x="hello " + person;
    document.getElementById("demo").innerHTML=x;
}
```