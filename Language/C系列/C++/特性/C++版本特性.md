
# C++11
## auto声明

使用auto类型声明变量时必须带有==初始值==，此时变量的数据类型自动成为初始值的类型，如`auto p=v.begin()`中p自动变为`vector<int>::iterator`类型
auto不能用来定义数组等类型

> [!NOTE]
> 如果auto接收带const或引用之类类型的变量时会自动丢弃这些属性，因为auto默认按值接收

auto也可用于函数返回值后置，语法为
```cpp
auto fun(args) -> type {}
```
其中的type一般多用`decltype`，见[decltype用法](../符号与关键字/decltype用法.md)

> **C++20** 起可以用 auto 作为函数参数的类型，本质上成为模板函数写法的语法糖


## 基于范围的for循环

- *传值*：`for(int i:arr)`，此时i为每一个arr元素的值，不能修改元素数值
- *传址*：`for(int& i:arr)`，此时i为每一个arr元素的引用，可以修改元素数值
- *容器*：`for(auto i:v)`，v可以是所有的容器，除了stack、queue等没有提供iterator的容器适配器

## inline namespace

可见[namespace与inline](../符号与关键字/namespace与inline.md)

## 自定义字面量

可见[自定义字面量](../符号与关键字/自定义字面量.md)

## C++参数包

可见[符号”...“](../符号与关键字/符号”...“.md)