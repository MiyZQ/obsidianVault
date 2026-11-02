
命名空间的嵌套语法：
```cpp
namespace version{
	inline namespace v1{
		void fun(){;}
	}
	namespace v2{
		void fun(){;}
	}
}
```
调用时可以用`version::v2::fun();`

*inline关键字（C++11）* 
可以使得此命名空间为上一层空间内的默认空间，如`version::fun();`，也可以使用`version::v1::fun();`

> [!NOTE]
> 命名空间不能写在函数作用域中

而在==函数==中，`inline`是一种请求，建议编译器把函数展开成代码片段，而不采用函数调用的形式，适用函数短且频繁调用的场景（该请求可以被编译器拒绝，不允许代码过长、有循环）：
```cpp
inline add(auto a,auto b){
	return a+b;
}
```
当调用`int x=add(1,2);`时，inline内联后实际上为`int x=1+2`

对于==类==：类内函数定义（不是声明）自动inline，而在类外定义不会自动inline

> [!NOTE]
> 如矩阵库：
> - 推荐`inline`的函数：`operator()`、`rows()`、`cols()`、`operator+=`、`operator*=`、...
> - 不推荐的：`operator+()`、`operator*()`、...（但hpp模板外定义必须加inline，否则多重定义会报错）

类中还可以使用`inline`来声明一个==静态成员==，见[类成员](../类/类成员.md)

对于==变量==（C++17），形如`inline int x=0;`允许在头文件定义全局、静态变量，在多个.cpp文件包含时不会报错重复定义

C++中`inline`主要防止重复定义（[头文件定义函数](../杂语法/头文件定义函数.md)），因为请求优化功能编译器已足够智能去自己实现



