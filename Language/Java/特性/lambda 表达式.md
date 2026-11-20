
Java 8 推出的 lambda 表达式（也可叫闭包）在形式上与 JS 的箭头函数很像，语法为
```java
(parameters) -> expression
(parameters) -> { statements; }
```

其支持变量捕获特性，同时能隐式捕获 final 或事实上为 final 的变量
```java
int x = 1;
Runnable z = y->x+y;
```