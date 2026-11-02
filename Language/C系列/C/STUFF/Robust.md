## 1）清除输入缓冲区

一般用
```
while ((c = getchar()) != '\n' && c != EOF);
```

## 2）保护头文件

```
#ifndef NAME
#define NAME
{body}
#endif
```

## 3）手动报错

```
#include <assert.h>
assert(expression);
```
当expression为真无效果，为假会报错
此代码只在debug阶段运行，因此不会影响release版本的运行效率

```
#include <stdlib.h>
exit(num);
```
运行到此退出，代码为num

## 4）防止数值溢出

求平均数用mid=(a+b)/2可能因为a+b导致溢出，最好使用
==a+(b-a)/2==来计算mid

## 5）求上取整除法

一般在C程序中
$$a/b = \left\lfloor  \frac{a}{b}  \right\rfloor$$
求上取整的下面算法只对正整数有效
$$(a-1)/b + 1 = \left\lceil  \frac{a}{b}  \right\rceil$$
另一种算法适用于a>=0&&b>0,但要注意数值溢出
$$(a+b-1)/b = \left\lceil  \frac{a}{b}  \right\rceil$$

## 6）手动设置缓冲区

使用模板：
```
char buf[n];
setvbuf(stream,buf,x,n);
```
将文件缓冲区设为buf,最多容纳n个字符
x的取值：
	`_IONBF`：不使用缓冲区，即0缓冲相应
	`_IOFBF`：只有缓冲区填满才更新文件
	`_IOLBF`：遇到换行符或缓冲区填满就会更新文件