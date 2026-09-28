
printf、scanf函数等用到了可变参数，如[1.1 FILE function](../1.Function/1.1%20FILE%20function.md)

使用可变参数要用到库：==`<stdarg.h>`==，函数声明如：
```
int fun(int n,...);
```
其中的n表示传递的可变参数总数，该变量前可以添加其他的参数，但可变参数总数n一定在...前

实现：

1）在函数体中创建一个va_list类型变量

2）使用int参数和va_start()宏来初始化va_list变量为一个参数列表

3）使用va_arg()宏和va_list变量访问参数列表的每一项

4）使用宏va_end()来清理va_list变量的内存

## 常用宏

- `va_start( ap, last_arg)`
	初始化可变参数列表，ap为va_list类型变量，last_arg为最后一个固定参数的名称，即可变参数列表之前的int参数n，此宏将ap指向可变列表中的第一个参数

- `va_arg( ap, type)`
	获取可变参数列表中的下一个参数，type为下一个参数的类型，此宏返回类型为type的值，并将ap指向下一个参数

- `va_end(ap)`
	结束可变参数列表访问，此宏将ap置为NULL

例子：

## 计算平均数
```c
#include <stdarg.h>
double ave(int n,...){
	va_list valist;
	double sum = 0.0;
	int i;
	va_start(valist,n);
	for(i=0;i<n;i++) sum += va_arg(valist,int);
	va_end(valist);
	return sum/n;
}
```
此时ave(4,2,3,4,5)便会返回3.5