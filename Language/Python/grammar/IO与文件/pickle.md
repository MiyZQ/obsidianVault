
python 的 pickle 模块实现了基本的数据序列和反序列化
- 通过 pickle 模块的序列化操作我们能够将程序中运行的对象信息保存到文件中去，永久存储
- 通过 pickle 模块的反序列化操作，我们能够从文件中创建上一次程序保存的对象

基本接口：
```python
pickle.dump(obj, file, protocol) # protocol默认0
```

有了 pickle 对象就可对 file 以读取的形式打开：
```python
x = pickle.load(file)
```

#### 实例

```python
#!/usr/bin/python3
import pickle

# 使用pickle模块将数据对象保存到文件
data1 = {'a': [1, 2.0, 3, 4+6j],
         'b': ('string', u'Unicode string'),
         'c': None}

selfref_list = [1, 2, 3]
selfref_list.append(selfref_list)

output = open('data.pkl', 'wb')

# Pickle dictionary using protocol 0.
pickle.dump(data1, output)

# Pickle the list using the highest protocol available.
pickle.dump(selfref_list, output, -1)

output.close()
```

```python
#!/usr/bin/python3
import pprint, pickle

#使用pickle模块从文件中重构python对象
pkl_file = open('data.pkl', 'rb')

data1 = pickle.load(pkl_file)
pprint.pprint(data1)

data2 = pickle.load(pkl_file)
pprint.pprint(data2)

pkl_file.close()
```