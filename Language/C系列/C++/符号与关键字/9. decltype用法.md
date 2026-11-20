
和`auto`类似推导类型，只不过`decltype`是推导出表达式的类型，不执行表达式，只*编译期*拿类型

语法：
```cpp
decltype(ep)
```

| ep种类              | 推导类型    |
| ----------------- | ------- |
| 不被( )包围的表达式       | 类型一致    |
| 函数调用              | 返回值类型   |
| 左值（裸变量名除外）或被( )包围 | ep类型的引用 |
> [!NOTE]
> 如果用双重括号，编译器会看成左值表达式，从而解释为引用：
> ```cpp
> int x = 520;
> decltype(x) a = x; // int
> decltype((x)) b = x; // int&
> ```
## 拿变量/表达式的类型

```cpp
int a = 520;
decltype(a) x = 1314;
```

## 配合auto做函数返回值

```cpp
template<typename T,typename U>
auto add(T a,U b) -> decltype(a+b) { return a+b; }
```

## C++14简化用法decltype(auto)

自动推导类型又保留引用属性
```cpp
int a = 520;
decltype(auto) b = (int&)a;
```

> [!NOTE]
> *decltype(auto)与auto区别*：
> - auto：会==退化==，丢掉引用，丢掉const，默认当值推导
> - decltype(auto)：==保留==所有