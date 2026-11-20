
## 约束验证 DOM 方法

| Property            | Description                                                                                                                                                                                                                                                                                                                       |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| checkValidity()     | 如果 input 元素中的数据是合法的返回 true，否则返回 false                                                                                                                                                                                                                                                                          |
| setCustomValidity() | 设置 input 元素的 validationMessage 属性，用于自定义错误提示信息的方法<br>使用 setCustomValidity 设置了自定义提示后，validity.customError 就会变成 true，checkValidity 总是会返回 false。如果要重新判断需要取消自定义提示，方式如下：<br>```setCustomValidity('') <br>setCustomValidity(null) <br>setCustomValidity(undefined)``` |

> [!NOTE]
> **HTMLSelectElement.checkValidity()** 会检查元素是否有任何输入约束条件，并且检查值是否符合约束条件。 如果值是不符合约束条件的，浏览器就会在该元素上触发一个可以撤销的 invalid 事件
> 
> 初步理解为，该函数里面有两个值，默认判断值为 ture，可以修改为 false
> ```js
> function myFunction() {
>   var x = document.getElementById("nu");
>   x.setCustomValidity("");
>   //使用前先取消自定义，否则下次点击checkValidity总返false
>   if (x.checkValidity() == false) {
>     x.setCustomValidity("错误");
>     document.getElementById("demo").innerHTML = x.validationMessage;
>   }
>   else {
>     x.setCustomValidity("正确");
>     document.getElementById("demo").innerHTML = x.validationMessage;
>   }
> }
> ```


## 约束验证 DOM 属性

|属性|描述|
|---|---|
|validity|布尔属性值，返回 input 输入值是否合法|
|validationMessage|浏览器错误提示信息|
|willValidate|指定 input 是否需要验证|

## Validity 属性

input 元素的 validity 属性包含一系列关于 validity 数据属性：

| 属性              | 描述                                    |
| --------------- | ------------------------------------- |
| customError     | 设置为 true, 如果设置了自定义的 validity 信息       |
| patternMismatch | 设置为 true, 如果元素的值不匹配它的模式属性             |
| rangeOverflow   | 设置为 true, 如果元素的值大于设置的最大值              |
| rangeUnderflow  | 设置为 true, 如果元素的值小于它的最小值               |
| stepMismatch    | 设置为 true, 如果元素的值不是按照规定的 step 属性设置     |
| tooLong         | 设置为 true, 如果元素的值超过了 maxLength 属性设置的长度 |
| typeMismatch    | 设置为 true, 如果元素的值不是预期相匹配的类型            |
| valueMissing    | 设置为 true，如果元素 (required 属性) 没有值       |
| valid           | 设置为 true，如果元素的值是合法的                   |


## 用例

```html
<input id="id1" type="number" min="100" required>
<button onclick="myFunction()">OK</button>
 
<p id="demo"></p>
 
<script>function myFunction() {
    var txt = "";
    var inpObj = document.getElementById("id1");
    if(!isNumeric(inpObj.value)) {
        txt = "你输入的不是数字";
    } else if (inpObj.validity.rangeUnderflow) {
        txt = "输入的值太小了";
    } else {
        txt = "输入正确";
    }
    document.getElementById("demo").innerHTML = txt;
}
 
// 判断输入是否为数字
function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
}</script>
```