
**核心规律**：可以把非const当成const用，不可以把const当成非const用

## 函数参数情景

#### 形参const T&传入普通非const变量 合法
```cpp
void func(const int&x);
int a = 520;
func(a);
```

#### 形参T&传入const常量 非法
```cpp
void func(int&x);
const int a = 1;
func(a);
```

指针同上

## 函数返回值/调用情景

#### 非const变量返回const引用 合法
```cpp
int x = 520;
const int get() { return x; }
```

#### const成员函数返回非const成员引用 非法
```cpp
struct A {
	int x;
	int& get() const { return x; }
};
```

#### const对象只能调用const成员函数
```cpp
struct A {
	void f(){}
	void g()const{}
};
const A a;
a.f(); // 合法
a.g(); // 非法
```

## 变量赋值/引用绑定场景

#### 普通变量绑定const引用 合法
```cpp
int a = 520;
const int& lovea = a;
```

#### const变量绑定普通引用 非法
```cpp
const int a =520;
int& a2 = a;
```
