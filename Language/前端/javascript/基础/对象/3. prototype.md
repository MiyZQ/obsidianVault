
原型（prototype）为对象提供了继承和共享属性的机制：
	每个 JavaScript 对象都有一个与之关联的原型对象，通过原型对象，可以实现属性和方法的共享，从而减少内存占用

所有的 JavaScript 对象都会从一个 prototype（原型对象）中继承属性和方法
- **原型**是一个对象，它是其他对象的模板或蓝图
- 当一个对象试图访问一个属性或方法时，如果在该对象自身没有找到，JavaScript 会沿着原型链向上查找，直到找到对应的属性或方法，或者达到原型链的顶端 `null` 为止

## 对象的 \_\_proto\_\_ 属性

每个 JavaScript 对象（除了 null）都自动拥有一个隐藏的属性 `__proto__`，它指向该对象的原型对象；`__proto__` 是实现继承的关键：
```js
let obj = {};
console.log(obj.__proto__); 
// 输出: [object Object], 即 obj 的原型是 Object.prototype
```

## 构造函数和原型

当使用构造函数创建一个对象时，构造函数的 prototype 属性会成为所有该构造函数创建的实例对象的原型
```js
function Person(name) {
    this.name = name;
}

Person.prototype.sayHello = function() {
    console.log("Hello, my name is " + this.name);
};

let alice = new Person("Alice");
alice.sayHello(); // 输出: Hello, my name is Alice
```

> Person.prototype 是 alice 对象的原型，因此 alice 可以访问 sayHello 方法

## 原型链

对象通过原型链（prototype chain）来实现继承，当一个对象尝试访问一个属性或方法时，JavaScript 会首先检查该对象自身是否有这个属性或方法，如果没有，它会沿着原型链向上查找
```js
let obj = {};
console.log(obj.toString()); 
// 输出: [object Object]
// 这个 `toString` 方法实际上是从 `Object.prototype` 继承过来的
```

## 修改原型

可以动态地修改对象的原型，这样可以影响到所有基于该原型创建的对象：
```js
function Person(name) {
    this.name = name;
}

Person.prototype.sayHello = function() {
    console.log("Hello, my name is " + this.name);
};

let bob = new Person("Bob");
bob.sayHello(); 
// 输出: Hello, my name is Bob

// 修改原型
Person.prototype.sayGoodbye = function() {
    console.log("Goodbye from " + this.name);
};

bob.sayGoodbye(); // 输出: Goodbye from Bob
```
此例中，在 Person.prototype 上添加了一个新的方法 sayGoodbye，bob 对象立即就可以访问到这个新方法

## Object.create() 方法

Object.create() 方法允许创建一个新对象，并将其原型设置为指定的对象：
```js
let personPrototype = {
    sayHello: function() {
        console.log("Hello, my name is " + this.name);
    }
};

let alice = Object.create(personPrototype);
alice.name = "Alice";
alice.sayHello(); // 输出: Hello, my name is Alice
```
此例中，alice 的原型是 personPrototype，因此 alice 对象可以访问 sayHello 方法

## prototype 继承

所有的 JavaScript 对象都会从一个 prototype（原型对象）中继承属性和方法：
- `Date` 对象从 `Date.prototype` 继承
- `Array` 对象从 `Array.prototype` 继承
- `Person` 对象从 `Person.prototype` 继承

> 所有 JavaScript 中的对象都是位于原型链顶端的 Object 的实例
	当试图访问一个对象的属性时，它不仅仅在该对象上搜寻，还会搜寻该对象的原型，以及该对象的原型的原型，依次层层向上搜索，直到找到一个名字匹配的属性或到达原型链的末尾

使用 prototype 属性可以给对象的构造函数添加新的属性和方法：
```js
function Person(first, last, age, eyecolor) {
  this.firstName = first;
  this.lastName = last;
  this.age = age;
  this.eyeColor = eyecolor;
}
 
Person.prototype.nationality = "English";
Person.prototype.name = function() { return this.firstName + " " + this.lastName; };
```