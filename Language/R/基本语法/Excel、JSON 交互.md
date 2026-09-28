
## Excel

R 读写 Excel 需要安装扩展
```R
install.packages("xlsx", 
	repos = "https://mirrors.ustc.edu.cn/CRAN/")
	
# 验证包是否安装
any(grepl("xlsx",installed.packages()))
# 载入包
library("xlsx")
```

读取：
```R
data <- read.xlsx('demo.xlsx', sheetIndex=1)
```

> 事实上，几乎所有的 Excel 软件与大多数表格软件一样支持 CSV 格式的数据，所以完全可以通过 CSV 与 R 交互，没必要再使用 Excel

## JSON

安装依赖包：
```R
install.packages("rjson", 
	repos = "https://mirrors.ustc.edu.cn/CRAN/")
```

使用：
```R
library("rjson")

# 获取 json 数据
result <- fromJSON(file = "sites.json")

# 转为数据框
json_data_frame <- as.data.frame(result)
```