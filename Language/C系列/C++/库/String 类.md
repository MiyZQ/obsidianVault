
1. string容器在`std`中，头文件`<string>`，C++11已将其归入`<iostream>`中

2. 两个string类数据可以相加，`s1+s2` 作用是*首尾相接*，还可以 `s1+=s2`

3. `getline(cin,s)`将*读取一行*输入存入s中（包括`'\n'`等）

4. `s.length()`值为s的长度，一般还是用`s.size()`

> [!NOTE]
> 如果要读取字符串的容量，用`s.capacity();`，也可使用`s.resize(n);`更改容量，也能指定填充字符`s.resize(n,'1');`

5. `s.substr(n,m)`表示从*索引n开始长度为m*的子串，若参数为`substr(n)`表示*索引n开始的剩余子串*

6.  可以将一个string对象拷贝给另一个string对象：`s1 = s2;`

7.  `to_string(m)`将m转为string类型，m为整型、浮点型、字符

8.  使用c风格输出string类型时，用如`printf("%s",s.c_str());` ，其中`s.c_str()`为`char*`类型

9. `s.find(ch)` 查找第一个 ch 的索引，没有返回 string::npos

10. `s.erase(it)` 删除 it 指向的字符，返回此字符后一个位置的迭代器

11. `s.reserve(n)` 预先申请 n 个内存，目的是解决每次扩容的效率降低问题，申请的内存并没有像 resize 加入 s 中，即访问是非法的，必须要去添加


---

## 初始化方法

#### 拷贝构造

使用`string s("iloveyou");`，移动构造还可以`string s2(std::move(s));`

#### 基于范围的构造

范围区间为 $[a,b)$
```cpp
char str[20] = "i love you";
string s(str,str+10); 
```

#### 填充构造

1. 将指定n个字节填充为指定字符`string s(10,'1');`

2. 指定填充字符串的前n个字节`string s("i love you",10);`

## 成员函数

容器很多成员函数是公用的，可见[STL库](STL库.md)，以下仅作补充

#### append追加
```cpp
// char*接收str
s.append(str); // 追加str到s后
s.append(str,n); // 指定追加n个字节
s.append(n,c); // 追加n个字符c
s.append(iter first,iter last); // 以相同顺序追加s中[first,last)字符

// string&接收s2
s.append(s2); //直接追加s2
s.append(s2,a,l); // 从s2索引a开始的l长度
```