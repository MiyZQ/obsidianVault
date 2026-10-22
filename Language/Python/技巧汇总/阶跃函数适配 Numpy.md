
普通实现：
```python
def func(x):
	return 1 if x > 0 else 0
```

支持 Numpy 数组的实现：
```python
def func(x):
    if isinstance(x,np.ndarray):
        return (x>0).astype(np.int16)
    return 1 if x > 0 else 0
```