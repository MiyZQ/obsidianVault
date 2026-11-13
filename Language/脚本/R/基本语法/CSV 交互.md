
#### 读取
```R
data <- read.csv("demo.csv", encoding='utf-8')
```
返回类型是数据框，可以如下使用函数
```R
print(is.data.frame(data))  # 查看是否是数据框  
print(ncol(data))  # 列数  
print(nrow(data))  # 行数
```

#### 查找
类似 SQL 中的 where 语句查询数据，使用 subset() 来匹配数据查找
```R
retval <- subset(data, id==1 & name=='a')
```

#### 保存
```R
write.csv(retval, 'out.csv')
```

