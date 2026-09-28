
*standard template library*即泛型库包含六大件：
`容器container、算法algorithm、迭代器iter、仿函数function object、适配器adaptor、空间配置器allocator`
C++标准中被组织为13个头文件：
`<algorithm>、<deque>、<functional>、<iter>、<vector>、<list>、<map>、<memory>、<numeric>、<queue>、<set>、<stack>、<utility>`


---

## 实现容器的注意点

自己的类想要存放在容器里面，需要支持以下几点：
1. 要有**默认构造函数**
2. 如果类包含指针、深拷贝、浅拷贝，必须**重载赋值运算符、拷贝构造**



以下容器中`< >`尖括号中类型只是示例，也可为其他类型，声明有初始化还可不用写尖括号

## 表格速览

|        | vector | deque | list | set | multiset | map        | multimap   |
| ------ | ------ | ----- | ---- | --- | -------- | ---------- | ---------- |
| 内存结构   | 单端数组   | 双端数组  | 双向链表 | 二叉树 | 二叉树      | 二叉树        | 二叉树        |
| 可随机存取  | 是      | 是     | 否    | 否   | 否        | 对 key 而言：是 | 否          |
| 元素查找速度 | 慢      | 慢     | 非常慢  | 快   | 快        | 对 key 而言：快 | 对 key 而言：快 |
| 元素添加移除 | 尾端     | 头尾两端  | 任何位置 | -   | -        | -          | -          |
## 使用场景

1. *vector*：需要高效的随机存取，不在乎插入、删除的效率
2. *list*：需要大量插入和删除元素，不关心随机存取效率
3. *deque*：需要随机存取，且关心两端数据的插入、删除效率
4. *map/multimap*：需要存储数据字典，如统计各数据出现次数
5. *set/multiset*：需要可以查找元素是否存在于某集合中
6. *unordered_map/unordered_set*：需要快速查找

---

## initializer_list

需要头文件`<initializer_list>`，是标准库轻量模板类，专门用来接收**花括号初始化列表`{...}`**，实现统一的列表初始化语法

作用：
1. 让构造函数支持花括号批量初始化
2. 替代重载一堆多参构造，一个构造搞定任意个数参数
3. 实现容器如`vector<int> v{1,3,1,4}`写法

> [!NOTE]
> `{1,3,1,4}`这种花括号列表，本质会被编译器隐式转为`initializer_list`

如：
```cpp
class Arr {
private:
	int data[520];
	int size = 0;
public:
	Arr(initializer_list<int> lst) {
		for(auto val:lst)
			data[size++] = val;
	}
};
Arr a{1,3,1,4};
```

> [!NOTE]
> `initializer_list`内元素只读，本质为**const对象**，不能修改，也当然不能用`auto&`，即使用`const auto&`也不会变快，因为本身就是拷贝小基本类型，放入寄存器会更快

## Vector

需要头文件`<vector>`

- ==声明如==：
	`vector <int> v;`声明空向量
	
	`v.resize(n);`重新分配大小，n表示长度，新数据都为0
	`v.reserve(n);` 预先申请 n 个内存，扩大容量
	
	`v.empty()`判断v是否为空
	
	`vector <int> v(n,m);`声明长n，数据均为m的向量
	`vector <int> v(n);`实际等价上面`m=0`

- ==赋值==：
	`v.assign({1,2,3});` 在定义中赋值，类似声明中的花
	括号初始化

- ==迭代器==：(C++11标准)
	`for(auto p=v.begin();p!=v.end();p++)`，其中p为迭
	代器，使用vector数值时用`*p`，注意`v.end()`指向尾元
	素的后一个位置，若对其解引用是UB未定义行为

- ==遍历==：
	除了迭代器，更常用 `for(T x : v)`

- ==序操作==：
	不稳定快速排序：`sort(v.begin(),v.end());`，
	稳定归并排序：`stable_sort(v.begin(),v.end());`
	反转：`reverse(v.begin(),v.end());`
	
	sort在头文件 `<algorithm>` 中，可以自定义cmp函数：返
	回值为**bool**类型，`cmp(x,y)` 返回真则x排在y左边，注意
	cmp不能`return x>=y` 之类，只能**严格不等防止段错误**

- ==添加==：
	尾部添加： `v.push_back(data);`，
	插入：`v.insert(p,data);`，
	
	p为迭代器，一般为 `v.begin()+m` 形式

- ==删除==：
	尾部删除 `v.pop_back();`，
	指定删除 `v.erase(p);`，
	清空 `v.clear();`

> [!NOTE]
> 如果在循环中使用添加/删除，一定要重新返回有效的迭代器
> ```cpp
> for(auto it=v.begin();it!=v.end();it++) {
> 	it = v.erase(it);
> 	cout<<*it<<endl;
> }
> ```
> 

- ==访问==：
	**抛异常**的 `v.at(pos)` 形式同 `v[pos]`，
	首元素 `v.front()`，
	尾元素 `v.back()`，
	首地址 `v.data()` 或 `v`

- ==二重数组==：
	可以如下声明 `vector<vector<int>>mat;`，
	行数为 `row=mat.size();`，
	列数为 `col=mat[0].size();`
## Set

需要头文件`<set>`，默认升序、自动排序去重

- ==声明==：
	`set <int> s;` 默认空集，可以赋值 `s = {...};`

- ==插入==：
	`s.insert(data);`

- ==查询==：
	`s.find(data);`，返回迭代器 `iterator`，若找不到会
	返回 `s.end()`
	
	`s.lower_bound(data);`，用于有序区间，返回第一个不
	小于 data 的迭代器，否则返回 end
	
	`s.upper_bound(data);`，用于有序区间，返回第一个大
	于 data 的迭代器，与 lower 相比不会与 data 相等

> [!NOTE]
> Set 的迭代器是双向迭代器而非随机迭代器，只能 ++it、--it，如果要连续跳跃可以用 `advance(it,k)` 将 it 移动为 it+k

- ==删除==：
	`s.erase(data);`

> [!NOTE]
> multiset 保留自动排序，允许元素重复，且是稳定的

## Map

即字典，头文件`<map>`，排序同set，按照key键排

- ==声明==：
	`map <string,int> m;`

- ==添加==：
	`m[key]=value;`

- ==查询==：
	`m[key]` 没有则返回0 并新建键值（不建议）；
	`m.count(key)` 返回 0 或 1
	
	`m.find(key)` 没有不会新建键值

- ==迭代器属性==：
	`auto p=m.begin();` 
	此时 `p->first` 为key，`p->second` 为value

> [!NOTE]
> 以上set、map单个操作复杂度为O(logn)，若操作n次复杂度O(nlogn)，实现原理是红黑树

## Stack

头文件`<stack>`

- ==声明==：
	`stack <int> s;`

- ==压栈==：
	`s.push(data);`

- ==弹栈==：
	`s.pop();`

- ==访问栈顶==：
	`s.top();`，空栈调用top是UB


## Queue

头文件`<queue>`

- ==声明==：
	`queue <int> s;`

- ==入队==：
	`s.push(data);`

- ==出队==：
	`s.pop();`

- ==访问==：
	队首 `s.front();`，队尾 `s.back();`

以上stack、queue操作复杂度为O(1)

## Unordered_map/set

头文件分别为`<unordered_map>`、`<unordered_set>`，实现原理是hash表，不会自动排序，可以减少运行时，使用同map、set