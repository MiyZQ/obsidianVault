
> with 是 Python 中的一个关键字，用于上下文管理协议
> 它简化了资源管理代码，特别是那些需要明确释放或清理的资源（如文件、网络连接、数据库连接等）

`with` 语句通过上下文管理协议解决了这些问题：
1. **自动资源释放**：确保资源在使用后被正确关闭
2. **代码简洁**：减少样板代码
3. **异常安全**：即使在代码块中发生异常，资源也会被正确释放
4. **可读性强**：明确标识资源的作用域

### 原理

`with` 语句背后是 Python 的上下文管理协议，该协议要求对象实现两个方法：
1. `__enter__()`：进入上下文时调用，返回值赋给 `as` 后的变量
2. `__exit__()`：退出上下文时调用，处理清理工作

> `__exit__()` 方法接收三个参数：
> - `exc_type`：异常类型
> - `exc_val`：异常值
> - `exc_tb`：异常追踪信息
> 
> 如果 `__exit__()` 返回 `True`，则表示异常已被处理，不会继续传播；返回 `False` 或 `None`，异常会继续向外传播

### 语法
```python
with expression as variable:
	do
```
- `expression` 返回一个支持上下文管理协议的对象
- `as variable` 是可选的，用于将表达式结果赋值给变量
- 代码块执行完毕后，自动调用清理方法

### 样例

#### 文件操作（最常用）
```python
# 同时打开多个文件
with open('input.txt', 'r') as infile, open('output.txt', 'w') as outfile:
    content = infile.read()
    outfile.write(content.upper())
```

#### 数据库连接
```python
import sqlite3

with sqlite3.connect('database.db') as conn:
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM users')
    results = cursor.fetchall()
# 连接自动关闭
```

#### 线程锁
```python
import threading

lock = threading.Lock()

with lock:
    # 临界区代码
    print("这段代码是线程安全的")
```

### 自定义上下文管理器

#### 类实现
```python
class Timer:
    def __enter__(self):
        import time
        self.start = time.time()
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        import time
        self.end = time.time()
        print(f"耗时: {self.end - self.start:.2f}秒")
        return False

# 使用示例
with Timer() as t:
    # 执行一些耗时操作
    sum(range(1000000))
```

#### contextlib 模块实现
```python
from contextlib import contextmanager

@contextmanager
def tag(name):
    print(f"<{name}>")
    yield
    print(f"</{name}>")

# 使用示例
with tag("h1"):
    print("这是一个标题")
```
输出：
```
<h1>                                                 
这是一个标题                       
</h1>
```