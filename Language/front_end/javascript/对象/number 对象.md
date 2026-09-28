
## 精度

整数（不使用小数点或指数计数）最多精确到 15 位
```js
var x = 999999999999999;   // x 为 999999999999999
var y = 9999999999999999;  // y 为 10000000000000000
```

小数最大精确位数是 17 位
```js
var x = 0.2+0.1; // 输出结果为 0.30000000000000004
```

## 进制

默认情况下，JavaScript 数字为十进制显示，也可以使用 toString() 方法 输出 16 进制、8 进制、2 进制
```js
var myNumber=128;
myNumber.toString(16);   // 返回 80
myNumber.toString(8);    // 返回 200
myNumber.toString(2);    // 返回 10000000
```

## 数字对象

```js
var x = 123;
var y = new Number(123);
(x === y) // 为 false，因为 x 是一个数字，y 是一个对象
```

## Number 属性

| 属性                       | 描述                                  |
| ------------------------ | ----------------------------------- |
| Number.MAX_VALUE         | 最大值                                 |
| Number.MIN_VALUE         | 最小值                                 |
| Number.NaN               | 非数字                                 |
| Number.NEGATIVE_INFINITY | 负无穷，在溢出时返回                          |
| Number.POSITIVE_INFINITY | 正无穷，在溢出时返回                          |
| Number.EPSILON           | 表示 1 和比最接近 1 且大于 1 的最小 Number 之间的差别 |
| Number.MIN_SAFE_INTEGER  | 最小安全整数                              |
| Number.MAX_SAFE_INTEGER  | 最大安全整数                              |
## 数字方法

| 方法                     | 描述                                                                                       |
| ---------------------- | ---------------------------------------------------------------------------------------- |
| Number.parseFloat()    | 将字符串转换成浮点数，和全局方法 [parseFloat()](https://www.runoob.com/jsref/jsref-parsefloat.html) 作用一致 |
| Number.parseInt()      | 将字符串转换成整型数字，和全局方法 [parseInt()](https://www.runoob.com/jsref/jsref-parseint.html) 作用一致    |
| Number.isFinite()      | 判断传递的参数是否为有限数字                                                                           |
| Number.isInteger()     | 判断传递的参数是否为整数                                                                             |
| Number.isNaN()         | 判断传递的参数是否为 isNaN()                                                                       |
| Number.isSafeInteger() | 判断传递的参数是否为安全整数                                                                           |

## 数字类型原型上的一些方法

| 方法              | 描述                                                                                           |
| --------------- | -------------------------------------------------------------------------------------------- |
| toExponential() | 返回一个数字的指数形式的字符串，如：1.23e+2                                                                    |
| toFixed()       | 返回指定小数位数的表示形式<br>`var a=123;`<br>`b=a.toFixed(2); // b="123.00"`<br>                         |
| toPrecision()   | 返回一个指定精度的数字。如下例子中，a=123 中，3会由于精度限制消失:<br>`var a=123;`<br>`b=a.toPrecision(2); // b="1.2e+2"` |
|                 |                                                                                              |