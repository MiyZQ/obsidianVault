
判断对象是否为 None 不应用 `x == None`，`==` 会调用对象的 `__eq__` 方法从而导致难以预料的 bug

判断对象统一用：
```python
x is None
x is not None
```