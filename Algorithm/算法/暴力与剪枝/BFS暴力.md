
LeetCode P.3942：
1. 使用 tuple 代替 str 作为 key 能优化速度
```python
from collections import deque
class Solution:
    def minOperations(self, nums: List[int]) -> int:
        nums = deque(nums)
        if nums:
            q = deque([nums])
            depth = 0
            key = tuple(nums)
            visited = set()
            visited.add(key)

            while q:
                for _ in range(len(q)):
                    cur = q.popleft()
                    if all(cur[i]<=cur[i+1]for i in range(len(cur)-1)):
                        return depth

                    left = deque(reversed(cur))
                    left_key = tuple(left)
                    if left_key not in visited:
                        visited.add(left_key)
                        q.append(left)
                    tmp = cur.popleft()
                    cur.append(tmp)
                    right_key = tuple(cur)
                    if right_key not in visited:
                        visited.add(right_key)
                        q.append(cur)

                depth += 1

            return -1
        return 0
```