
语法：
```js
var obj = new Person()
```
1. 创建一个全新的空普通对象`{}`
2. 把新对象的隐式原型 `__proto__` 指向构造函数的 `prototype`
3. 把构造函数的 `this` 绑定为这个新对象；执行构造函数代码
4. 返回对象

> [!NOTE]
> 如果构造函数没有手动 return，则返回步骤 4 所说的新建对象；
> 如果手动 return 了一个对象，则返回此对象（坑）

## 使用例

```js
function Person(name) {
	this.name = name;
}

const a = new Person("1");
console.log(a.name); 
// 正确

const b = Person("2");
console.log(b.name); 
// this指向window，给全局变量加name
```

```js
function Person(name) {
	this.name = name;
	return {b:99};
}

var a = new Person("1");
console.log(a.name);
// 输出undefined，因为返回的a是{b:99}这个对象
```