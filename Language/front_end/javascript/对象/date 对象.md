
## 日期初始化

通过 new 关键字定义 Date 对象，有四种方式：
```js
new Date()
new Date(value)
new Date(dateString)
new Date(year, monthIndex, day=0, hours=0, minutes=0, seconds=0, milliseconds=0)
// 示例
var today = new Date()
var d1 = new Date("October 13, 1975 11:13:00")
var d2 = new Date(79,5,24)
var d3 = new Date(79,5,24,11,33,0)
```

> [!ATTENTION]
> `new Date("2026-08-25")` 和 `new Date(2026,7,25)` 返回对象不同，前者为 UTC 时间，后者为本地时间，不要混用

## 设置日期

setFullYear（year, month, day） 方法中 month 取值为 0-11，表示 1-12 月：
```js
var myDate = new Date()
myDate.setFullYear(2026, 7, 25)
```

setDate() 方法接收 Date 对象的 getDate()方法返回的值，下例中设置为 5 天后的日期：
```js
var myDate = new Date()
myDate.setDate(myDate.getDate() + 5)
```

## 日期比较

日期之间可根据时间先后进行比较，如下：
```js
var x = new Date()
x.setFullYear(2026, 7, 25)
var today = new Date()

if (x < today) {
	const diff = (x.getTime() - today.getTime()) / 86400000
	alert("今日距此日${diff}天")
}
```

> [!NOTE]
> 上例为计算真实流逝时长，如果计算日历相隔天数，需要给两个对象**清除时分秒**到零点，再 getTime()
> ```js
> d1.setHours(0,0,0,0)
> d2.setHours(0,0,0,0)
> const diff = (d2.getTime() - d1.getTime()) / 86400000
> ```

## 网页上设置钟表

```js
function startTime(){
	var today=new Date();
	var h=today.getHours();
	var m=today.getMinutes();
	var s=today.getSeconds();
	// 在小于10的数字前加一个‘0’
	m=checkTime(m);
	s=checkTime(s);
	document.getElementById('txt').innerHTML=h+":"+m+":"+s;
	t=setTimeout(function(){startTime()},500);
}
function checkTime(i){
	if (i<10){
		i="0" + i;
	}
	return i;
}
```