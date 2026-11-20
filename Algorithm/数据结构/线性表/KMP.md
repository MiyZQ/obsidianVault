
在主串 s 中找到模式串 t 的过程为*模式匹配*，KMP算法聚焦于优化暴力BF算法的回溯，通过研究模式 t 的内在性质，使得模式匹配中失配时提高下一次的匹配效率

如果 s 的两个子串满足$$s[0,...,m-1]=s[n-m,...,n-1]$$
则称这两个子串为 s 的长度为 m 的公共前缀和后缀，如果 m 是最大的，就称为 s 的最长公共前缀和后缀

当 $s[i]$ 与 $t[j]$ 失配时，j 的下一个匹配节点定义为*失配特征函数* $next[j]$ ，取值为

$$next[j] =
\begin{cases}
-1, & j=0;\\[4pt]
\max\,\bigl\{ k \,\big|\, 0\le k<j,\; t[0,...,k-1] = t[j-k,...,j-1] \bigr\},
& j\ge 1 \text{ 且有公共前后缀};\\[4pt]
0, & j\ge 1 \text{ 无公共前后缀}.
\end{cases}
$$

## 基础算法实现

#### KMP主算法
```cpp
// 返回首次模式匹配成功的索引，失败返回-1
int kmp(const string s, const string t) {
	int i{0},j{0},n{static_cast<int>(s.size())},m{static_cast<int>(t.size())};
	const vector<int> next = getNext(t);
	while(i<n&&j<m) {
		if(j==-1||s[i]==t[j]) {
			++i,++j;
		}
		else j = next[j];
	}
	return j==m?i-m:-1;
}
```

#### next数组实现
```cpp
vector<int> getNext(const string& t) {
	int m{static_cast<int>(t.size())},j{0},k{-1};
	vector<int> next(m);
	next[0] = -1;
	while(j<m-1) {
		if(k==-1||t[j]==t[k]) {
			next[++j] = ++k;
		}
		else k = next[k];
	}
	return next;
}
```

## 优化实现

当 $t[j]$ 与 $s[i]$ 不匹配时，原始KMP会跳转到 $j=next[j]$ ，但如果 $t[j]=t[next[j]]$ ，那么跳转后也不会匹配，造成*重复跳转*

优化1：
```cpp
vector<int> getNext(const string& t) {
	int m{static_cast<int>(t.size())},j{0},k{-1};
	vector<int> next(m);
	next[0] = -1;
	while(j<m-1) {
		if(k==-1||t[j]==t[k]) {
			++j,++k;
			next[j] = t[j]==t[k]?next[k]:k; // 直接取next[k]的值
		}
		else k = next[k];
	}
	return next;
}
```

> [!NOTE]
> 只需要判断有无匹配/找第一个匹配时就可以用优化1，此时next中*保存的部分值不真*

由于 $next[j]$ 的计算是递归的，为避免重复计算，还可以使用*仿函数*存储状态进一步优化

优化2：
```cpp
struct Kmp {
	vector<int> next;
	const vector<int>& operator()(const string& t) {
		int m{static_cast<int>(t.size())};
		next.assign(m,0);
		if(m==0) return next;
		next[0] = -1;
		int j{0},k{-1};
		while(j<m-1) {
			if(k==-1||t[j]==t[k]) {
				++j,++k;
				next[j] = t[j]==t[k]?next[k]:k;
			}
			else k = next[k];
		}
		return next;
	}
	const vector<int>& getNext() const {
		return next;
	}
	void clear() {
		next.clear();
	}
};
Kmp getNext;
```

## 查找所有位置

需注意，上面的优化1只适合*单模式串精准匹配*，实质上将中间可匹配的前缀位置直接跳过了，如果要找所有位置就不应用优化1

另外，next数组还需要再加入一项 $next[m]$ 表示整个 t 串的最大公共前缀和后缀长，以便跳转下一个匹配

```cpp
vector<int> kmp_all(const string& s,const string& t) {
	vector<int> res;
	int n = s.size(),m = t.size();
	if(m==0||n<m) return res;
	vector<int> next = getNext(t);
	int i{0},j{0};
	while(i<n) {
		if(j==-1||s[i]==t[j]) {
			++i,++j;
		}
		else {
			j = next[j];
		}
	}
	if(j==m) {
		res.push_back(i-j);
		j = next[j];
	}
	return res;
}
```