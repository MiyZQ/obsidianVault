
头文件`<algorithm>`

---

## 排序类

#### sort快速排序
```cpp
sort(v.begin(),v.end()); // 默认升序
sort(v.begin(),v.end(),greater<int>()); // 降序，含<functional>
```

#### stable_sort稳定排序
```cpp
// 与sort语法相同，相等元素相对位置不变
stable_sort(v.begin(),v.end());
```

#### partial_sort局部排序
```cpp
// 选出最小/最大的k个元素排序放在前面，剩下的保持原位置放后面
partial_sort(v.begin(),v.begin()+k,v.end());
```

> [!NOTE]
> 不需要全部排序时，用局部排序可以节约性能

## 查找类

#### find线性查找
```cpp
// 找到返回迭代器，否则返回end()
auto iter = find(v.begin(),v.end(),520);
if(iter!=v.end())
	cout<<*iter<<endl;
```

#### binary_search二分查找
```cpp
// 前提是有序
if(binary_search(v.begin(),v.end(),520))
	cout<<"find it"<<endl;

// 如果从大到小加上greater
binary_search(v.begin(),v.end(),520,greater<int>());
```

#### lower_bound / upper_bound
```cpp
// 有序区间内返回第一个大于(等于)参数值val的位置
auto l = lower_bound(v.begin(),v.end(),520); // >= 520
auto r = upper_bound(v.begin(),v.end(),520); // > 520

// 从大到小同上，不赘述
```
常用于有序容器插入、去重、区间统计，`[l,r)` 为值都为 `val` 的区间，计算索引时记得减去头迭代器 `v.begin()`

> [!ATTENTION]
> map 不要使用全局 lower_bound，因为 map 是双向迭代器不能随机访问，时间复杂度会退化到 O(n)，应该用：
> ```cpp
> auto it = mp.lower_bound(520);
> ```

#### equal_range 
同时拿 lower_bound 和 upper_bound，使用如：
```cpp
auto p = mp.equal_range(520);
p.first // == mp.lower_bound(520);
p.second // == mp.upper_bound(520);
```

#### count / count_if
```cpp
// count:统计等于val的元素个数
int cnt = count(v.begin(),v.end(),1);
// count_if:给条件/谓词统计满足条件的元素个数
int cnt = count_if(v.begin(),v.end(),[](int x){ return x>2; });
```

## 操作类

#### inserter / back_inserter

 *插入迭代器* 是适配器，需要头文件`<iterator>`，可以自动新增元素、扩容容器，不用提前开空间

##### back_inserter
在尾部不断`push_back`追加元素
```cpp
auto iter = back_inserter(v);
// 重载的运算 = 表示插入
iter = 520;
iter = 1314; 
// v = { 1314,520 }
```

> [!NOTE]
> 有些函数给空容器赋值时使用`v.begin()`会非法访问，因此多用`back_inserter(v)`

还有`front_inserter`适用于有`push_back`往前插的容器，如`list、deque、forward_list`，不能是`vector`
##### inserter
可以*在指定迭代器位置前面插入元素*
```cpp
vector<int> v{1,2,3};
auto iter = inserter(v,v.begin());
iter = 1314;
iter = 520;
// v = { 1314,520,1,2,3 }
```

#### unique相邻去重
```cpp
// 将相邻重复元素全放到容器后面，返回去重后最后一个有效元素的下
// 一个迭代器，即第一个无效元素
auto last = unique(v.begin(),v.end());
v.erase(last,v.end());
```

#### reverse反转
```cpp
reverse(v.begin(),v.end());
```

#### shuffle随机打乱
```cpp
// 加上<random>头文件
// 随机种子
// 梅森旋转算法
random_device rd; 
mt19937 rng(rd()); 
shuffle(v.begin(),v.end(),rng);
```

#### fill填充
```cpp
fill(v.begin(),v.end(),0);
```

#### replace替换
```cpp
replace(v.begin(),v.end(),520,1314) // 所有520 -> 1314
```

#### remove删除
```cpp
// 只是将元素放在容器后面，真删要配合erase
auto last = remove(v.begin(),v.end(),1);
v.erase(last,v.end());
```

## 最值

#### max_element / min_element
```cpp
// 返回最大/小值的迭代器
auto pmaxv = max_element(v.begin(),v.end());
int maxv = *pmaxv;
```

#### max / min
```cpp
int res = max(520,1314);
```

## 遍历&变换

#### for_each遍历
```cpp
for_each(v.begin(),v.end(),[](int x){ cout<<x<<" "; });
```

由于`for_each`会返回传入的可调用对象，因此还可结合*仿函数* 使用，如：
```cpp
struct stat {
	int sum = 0;
	int maxv = 0;
	void operator()(int x) {
		sum +=x;
		if(x>maxv) maxv = x;
	}
};
stat res = for_each(v.begin(),v.end(),stat());
// 保留了状态
cout<<res.sum<<endl;
cout<<res.maxv<<endl;
```

#### transform元素变换
```cpp
// 将a容器映射到b容器，类似py中的map

// 单元 a -> b
transform(a.begin(),a.end(),back_inserter(b),
	[](int x){ return x*2; });

// 双元 a,b -> c
transform(a.begin(),a.end(),b.begin(),b.end(),back_inserter(c),
	[](int x,int y){ return x+y; });
```

## 集合操作

要求两个容器都有序：
- `set_union`             并集
- `set_intersection` 交集
- `set_difference`     差集

```cpp
// a,b -> c
set_union(a.begin(),a.end(),b.begin(),b.end(),
	back_inserter(c));
```

## 条件判断

- `all_of`   均满足
- `any_of`   至少一个满足
- `none_of`  全不满足

```cpp
if(all_of(v.begin(),v.end(),[](int x){ return x>0; }));
	cout<<"positive"<<endl;
```