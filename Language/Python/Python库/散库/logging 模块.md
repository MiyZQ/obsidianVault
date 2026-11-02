
> 导入模块：`logging`

## 日志级别

| 类型       | 数值  | 信息             |
| -------- | --- | -------------- |
| DEBUG    | 10  | 详细的调试信息，用于开发阶段 |
| INFO     | 20  | 程序正常运行的信息      |
| WARNING  | 30  | 潜在问题，但程序能正常运行  |
| ERROR    | 40  | 程序错误，某些功能不能工作  |
| CRITICAL | 50  | 严重错误，可能导致程序崩溃  |

设置日志级别如：`logging.basicConfig(level=logging.DEBUG)`
默认是 WARNING
## 日志记录

使用如：
```python
logging.debug("这是一条调试信息")
logging.info("这是一条普通信息")
logging.warning("这是一条警告信息")
logging.error("这是一条错误信息")
logging.critical("这是一条严重错误信息")
```

## 日志输出

通过 basicConfig 方法自定义输出格式
```python
logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S"
)
```

默认情况下日志会输出到 console，如下配置可以输出到文件：
```python
logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    filename="app.log"
)
```
还可加入参数 `filemode` 表示打开模式，默认是 `'a'`

## 高级用法

#### 多个日志记录器
项目大时，需要为不同模块或组件创建独立日志记录器
```python
logger = logging.getLogger("my_logger")
logger.setLevel(logging.DEBUG)

# 创建文件处理器
file_handler = logging.FileHandler("my_logger.log")
file_handler.setLevel(logging.DEBUG)

# 创建控制台处理器
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)

# 设置日志格式
formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
file_handler.setFormatter(formatter)
console_handler.setFormatter(formatter)

# 将处理器添加到日志记录器
logger.addHandler(file_handler)
logger.addHandler(console_handler)

# 记录日志
logger.debug("这是一条调试信息")
logger.info("这是一条普通信息")
```

#### 日志过滤器
通过过滤器控制哪些日志需要被记录
```python
class MyFilter(logging.Filter):
    def filter(self, record):
        return record.levelno == logging.ERROR

logger.addFilter(MyFilter())
```

#### 日志轮转
日志文件过大时，可用 RotatingFileHandler 或 TimedRotatingFilehandler 实现轮转
```python
from logging.handlers import RotatingFileHandler

handler = RotatingFileHandler("app.log", maxBytes=1024, backupCount=3) # 每个文件1kb，3个保留备份
logger.addHandler(handler)
```

## 常用属性、方法汇总

### 核心类

|类|说明|示例|
|---|---|---|
|** `logging.Logger` **|记录器，用于发出日志消息（通过 `logging.getLogger(name)` 获取）| `logger = logging.getLogger("my_logger")` |
|** `logging.Handler` **|处理器，决定日志输出位置（如文件、控制台等）| `handler = logging.FileHandler("app.log")` |
|** `logging.Formatter` **|格式化器，控制日志输出的格式| `formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')` |
|** `logging.Filter` **|过滤器，用于更精细地控制日志记录| `filter = logging.Filter("module.name")` |

### Logger 对象常用方法

|方法|说明|示例|
|---|---|---|
|** `logger.setLevel(level)` **|设置日志级别（如 `logging.DEBUG`、`logging.INFO`）| `logger.setLevel(logging.DEBUG)` |
|** `logger.debug(msg)` **|记录 DEBUG 级别日志| `logger.debug("调试信息")` |
|** `logger.info(msg)` **|记录 INFO 级别日志| `logger.info("程序启动")` |
|** `logger.warning(msg)` **|记录 WARNING 级别日志| `logger.warning("磁盘空间不足")` |
|** `logger.error(msg)` **|记录 ERROR 级别日志| `logger.error("操作失败")` |
|** `logger.critical(msg)` **|记录 CRITICAL 级别日志| `logger.critical("系统崩溃")` |
|** `logger.addHandler(handler)` **|添加处理器| `logger.addHandler(handler)` |
|** `logger.addFilter(filter)` **|添加过滤器| `logger.addFilter(filter)` |

### Handler 常用类型

|Handler 类型|说明|示例|
|---|---|---|
|** `StreamHandler` **|输出到流（如控制台）| `handler = logging.StreamHandler()` |
|** `FileHandler` **|输出到文件| `handler = logging.FileHandler("app.log")` |
|** `RotatingFileHandler` **|按文件大小分割日志| `handler = logging.RotatingFileHandler("app.log", maxBytes=1e6, backupCount=3)` |
|** `TimedRotatingFileHandler` **|按时间分割日志| `handler = logging.TimedRotatingFileHandler("app.log", when="midnight")` |
|** `SMTPHandler` **|通过邮件发送日志| `handler = logging.SMTPHandler("mail.example.com", "from@example.com", "to@example.com", "Error Log")` |


### Formatter 常用格式字段

|字段|说明|示例输出|
|---|---|---|
| `%(asctime)s` |日志创建时间| `2023-01-01 12:00:00,123` |
| `%(levelname)s` |日志级别名称| `INFO` |
| `%(message)s` |日志消息内容| `程序启动成功` |
| `%(name)s` |记录器名称| `my_logger` |
| `%(filename)s` |生成日志的文件名| `app.py` |
| `%(lineno)d` |生成日志的行号| `42` |
| `%(funcName)s` |生成日志的函数名| `main` |

### 快速配置方法

|方法|说明|示例|
|---|---|---|
|** `logging.basicConfig()` **|一键配置日志级别、处理器和格式（通常在程序入口调用）| `logging.basicConfig(level=logging.INFO, format='%(levelname)s - %(message)s')` |

**常用参数**：
- `level`：设置根记录器级别
- `filename`：输出到文件
- `filemode`：文件模式（如 `'w'` 覆盖）
- `format`：格式字符串
- `datefmt`：日期格式（如 `"%Y-%m-%d %H:%M:%S"`）