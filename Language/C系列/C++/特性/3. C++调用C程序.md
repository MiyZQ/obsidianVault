
C++实现函数重载会将函数名按参数类型重新编码，若直接调用C函数按照C++搜索标准查找不到，需要使用extern "C"，反过来，用这种方法定义的函数也可以被C调用

- 单个函数：
```cpp
extern "C" void test();
```

- 多个函数：
```cpp
extern "C" {
void fun1();
void fun2();
}
```

例子：

- C头文件
```c
// cfun.h
#ifndef CFUN.H
#define CFUN.H
int add(int a,int b);
#endif
```
- C++文件
```cpp
// main.cpp
#include<iostream>
extern "C" {
	#include "cfun.h"
}
using std::cout;
using std::endl;
int main(){
	cout<<add(1,2)<<endl;
	return 0;
}
```