
`<functional>`为通用可调用对象包装器，作用：
- 统一封装
- 实现回调

---


## function

`std::function`是统一容器，可以把普通函数、函数指针、仿函数、lambda、类成员函数全部包装成一个类型

C++函数引用的写法：
```cpp
// 返回值(参数列表类型)
using funType = void(int);
funType func;
```

`function`写法：
```cpp
// std::function<返回值(参数列表类型)> 函数对象;
function<void(int)> func;                            
```

> [!NOTE]
> 由于`function`为空时调用会抛异常，所以需要判空操作：
> ```cpp
> function<void()> f;
> if(f) f();
> ```

**回调**用法：
```cpp
void test(function<void()> f) { f(); }

string msg = "5201314";
test([msg](){ cout<<"i want u2 know "<<msg<<endl; });
```

> [!NOTE]
> 有*捕获*的lambda不能转普通函数指针，只能用`function`接住做回调，如果用上面函数引用的写法会报错

## bind

`std::bind`给函数打包固定参数、重排参数顺序、适配成员函数、适配回调接口

语法：
```cpp
// bind(可调用对象，参数列表)
void print(int a,int b) {
	cout<<a<<" "<<b<<endl;
}
function<void(int)> f = bind(print,520,placeholders::_1);
f(1314); // 520 1314
```
其中的参数列表包括普通常量和*占位符* `std::placeholders::_1、_2、...`，占位符表示将来调用时再传递的参数

**重排**用法：
```cpp
function<void(int,int)> f = bind(print,placeholders::_2,placeholders::_1);
f(1314,520) // 520 1314
```

**适配类成员函数**：成员函数自带隐藏第一个参数`this`，原生不能直接回调
```cpp
class A {
public:
	void fun(int x) { cout<<x<<endl; }
};
A obj;
function<void(int)> f = bind(&A::fun,&obj,placeholders::_1);
f(1);
```

> [!NOTE]
> 还有函数`bind1st、bind2nd`分别把参数绑定为二元函数对象的第一/二个参数，已被C++11废弃

## mem_fn

`mem_fn`把类成员函数、成员变量包装成一个通用可调用对象（仿函数），比bind更适合成员回调

语法：
```cpp
// 调用：fn(类对象,参数)
function<void(A&,int)> fn = mem_fn(&A::fun);
A obj;
fn(obj,520);
```

> [!NOTE]
> 事实上`mem_fn`都兼容对象、指针、引用这三种传法

**包装成员变量**：
```cpp
class B {public:int x=1;};
auto get_x = mem_fn(&B::x);
B obj;
cout<<get_x(&obj)<<endl;
get_x(&obj) = 2; // 左值
cout<<get_x(&obj)<<endl;
```

## invoke

***C++17*** 引入`std::invoke`作为万能统一调用器，以同一套语法，调用普通函数、lambda、仿函数、成员函数、成员变量

语法：
```cpp
auto lam = [](int x){ cout<<x<<endl; }
invoke(lam,1);

// 调用类成员函数、变量时特殊些，第二个参数必须为对象、对象指针、智能指针
A obj;
invoke(&A::fun,&obj,1);
```

## ref、cref

`std::ref`为引用包装器，把变量包装成*可拷贝的引用对象*
由于`std::bind`、`std::thread`等传参默认为值拷贝，这些场景需要用引用时就需要引用包装

#### 返回类型

- `std::ref`：普通左值引用包装`reference_wrapper<T>`
- `std::cref`：const引用包装`reference_wrapper<const T>`

例子：
```cpp
void add(int &x) { ++x; }
int n = 520;
auto f = bind(add,ref(n));
f();
cout<<n<<endl; // 521
```

> [!NOTE]
> `ref`不要绑临时变量，如果使用`ref(1)`会变成野引用，悬空

## less、greater

本质为包装好的仿函数，底层为
```cpp
template<class T>
struct less {
	bool operator()(const T &a,const T &b) const {
		return a<b;
	}
};

template<class T>
struct greater {
	bool operator()(const T &a,const T &b) const {
		return a>b;
	}
};
```

常用于排序中，不用自己手动写lambda
```cpp
vector<int> v{1,3,1,4};
// greater 从大到小
// less    从小到大
sort(v.begin(),v.end(),greater<int>()); // 4,3,1,1
```

类似的还有`less_equal、greater_equal、equal_to、not_equal_to`

> [!NOTE]
> ***C++17*** 引入取反器`not_fn`表示生成一个新函数对象，其返回结果取原函数返回值逻辑反`!`，各种函数对象都适用，如`not_fn(less)`