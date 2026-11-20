
安装依赖：
```R
install.packages("RMySQL", 
	repos = "https://mirrors.ustc.edu.cn/CRAN/")
```

使用：
```R
library(RMySQL)

# dbname 为数据库名
mysqlconnection = dbConnect(MySQL(), user = 'root', password = '', dbname = 'test',host = 'localhost')

# 查看数据
dbListTables(mysqlconnection)

# 查询 sites 表，增删改查操作可以通过第二个参数的 SQL 语句来实现  
result = dbSendQuery(mysqlconnection, "select * from sites")  
  
# 获取前面两行数据  
df = fetch(result, n = 2)
```