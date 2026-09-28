
在多数元素的问题上，最优算法是摩尔投票法，一般时间复杂度O(n)，空间复杂度O(1)

==思想：==

如果一个元素出现的次数超过总数的一半，那么即使把所有其他元素都用来抵消它，它还是会剩余最少一个

算法实现一般分为：找候选元素、验证候选元素两个步骤

## 找出出现频率$>\dfrac{1}{2}$的元素：
```c
int majority( int* nums, int n, int* x){
	int candidate = -1, count = 0;  //先找候选元素
	for (int i=0; i<n; i++){
		if (count == 0){
			candidate = nums[i];
			count = 1;
		} else if (nums[i] == candidate) count++;
		else count--;
	}
	int cnt = 0;  //验证候选元素
	for (int i=0; i<n; i++)
		if (nums[i] == candidate) cnt++;
	if (cnt > n/2){
		*x = candidate;
		return cnt; 
	} else return -1;
}
```

如果是找出现频率$>\dfrac{1}{k}$的元素，则需要k-1个候选元素，用python代码如下：
```python
def majority(self, nums: list[int], k: int) -> list[int]:
    candidates = {}
    for num in nums:
        if num in candidates:
            candidates[num] += 1
        elif len(candidates) < k-1:
            candidates[num] = 1
        else:
            to_del = []
            for c in candidates:
                candidates[c] -= 1
                if candidates[c] == 0:
                    to_del.append(c)
            for c in to_del:
                del candidates[c]
    result = []
    part = len(nums)//k
    from collections import defaultdict
    actual_counts = defaultdict(int)
    for num in nums:
        if num in candidates:
            actual_counts[num] += 1
    for num, count in actual_counts.items():
        if count > part:
            result.append(num)
    return result
```
时间O(n)，空间O(k)，如有需要还可返回每个候选者的票数

> [!NOTE]
> 该思想可用于：
> 
> 1）从数据流中实时找出频繁元素
> 
> 2）从分布在多个机器上的数据中找全局多数元素
> 	每台机器本地进行摩尔投票，在全局再运行一次摩尔投票，最后验证
> 
> 3）特别注意可以检测来自少数IP的DDoS攻击、实时检测文本处理中的高频词