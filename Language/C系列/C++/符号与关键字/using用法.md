
## 引入命名空间

整个空间：
```cpp
uisng namespace std;
```

单独某个标识符：
```cpp
using std::cout;
```
## 类型别名，替代typedef

```cpp
using ll = long long;
using pll = pair<int,int>;
```

支持模板别名：
```cpp
template<typename T>
using Vec = vector<T>;

Vec<int> a; // 等价于vector<int> a;
```

## 继承中引入父类成员

子类复用父类成员，隐藏后重新可见，*可解决子类同名函数隐藏父类重载问题*
```cpp
class A {public:void fun(int);};
class B:public A {
	using A::fun;
	void fun();
};
```

## 导出类成员到外部作用域

就是把类成员拿到外面用
```cpp
class A {public:int x;};
using A::x;
```

> [!NOTE]
> 此时依然收到权限访问控制符控制，只能拿public的成员