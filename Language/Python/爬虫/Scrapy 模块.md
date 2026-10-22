
与简单的爬虫库 requests、BeautifulSoup 不同，Scrapy 是一个全功能的爬虫框架，具有高度的可扩展性和灵活性，适用于复杂和大规模的网页抓取任务

架构图
![](assets/Scrapy%20模块/file-20260910145048486.png)

包含以下核心组件：
- **Spider**：爬虫类，用于定义如何从网页中提取数据以及如何跟踪网页的链接
- **Item**：用来定义和存储抓取的数据。相当于数据模型
- **Pipeline**：用于处理抓取到的数据，常用于清洗、存储数据等操作
- **Middleware**：用来处理请求和响应，可以用于设置代理、处理 cookies、用户代理等
- **Settings**：用来配置 Scrapy 项目的各项设置，如请求延迟、并发请求数等

## 项目结构

Scrapy 通过命令行创建和管理爬虫项目，使用如下：
```bash
scrapy startproject myProject
```
创建目录如下
```
myProject/
    scrapy.cfg            # 项目的配置文件
    myProject/            # 项目源代码文件夹
        __init__.py
        items.py          # 定义抓取的数据结构
        middlewares.py    # 定义中间件
        pipelines.py      # 定义数据处理管道
        settings.py       # 项目的设置文件
        spiders/           # 存放爬虫代码的文件夹
            __init__.py
            myspider.py   # 自定义的爬虫代码
```

## 基本使用

建立自己的爬虫文件后需要注意：
- 豆瓣等网站可能会检测爬虫行为，建议设置 USER_AGENT 和 DOWNLOAD_DELAY 来模拟正常用户行为
- 在爬取数据时，请遵守目标网站的 robots.txt 文件规定，避免对服务器造成过大压力
- 如果频繁爬取，可能会触发 IP 封禁

#### 修改 settings.py 配置
在 settings.py 中添加以下配置，以模拟浏览器请求并绕过反爬虫机制：
```python
# 设置 User-Agent
USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'

# 不遵守 robots.txt 规则
ROBOTSTXT_OBEY = False

# 设置下载延迟，避免过快请求
DOWNLOAD_DELAY = 2

# 启用自动限速扩展
AUTOTHROTTLE_ENABLED = True
AUTOTHROTTLE_START_DELAY = 2
AUTOTHROTTLE_MAX_DELAY = 5
```

打开爬虫文件，修改如下：
```python
import scrapy

class DoubanSpider(scrapy.Spider):
    name = "douban_spider"
    start_urls = [
        'https://movie.douban.com/top250',
    ]

    def start_requests(self):
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            'Referer': 'https://movie.douban.com/',
        }
        for url in self.start_urls:
            yield scrapy.Request(url, headers=headers, callback=self.parse)

    def parse(self, response):
        for movie in response.css('div.item'):
            yield {
                'title': movie.css('span.title::text').get(),
                'rating': movie.css('span.rating_num::text').get(),
                'quote': movie.css('span.inq::text').get(),
            }

        # 处理分页
        next_page = response.css('span.next a::attr(href)').get()
        if next_page is not None:
            yield response.follow(next_page, callback=self.parse)
```

命令行中运行下面命令启动爬虫：
```bash
scrapy crawl douban -o douban_movies.csv
```

## 常用方法

### 1. start_requests()

`start_requests()` 方法是 Scrapy 爬虫的入口点，用于生成初始请求。通常在这个方法中定义爬虫的起始 URL
```python
import scrapy  
  
class MySpider(scrapy.Spider):  
    name = 'myspider'  
     
    def start_requests(self):  
        urls = [  
            'http://example.com/page1',  
            'http://example.com/page2',  
        ]  
        for url in urls:  
            yield scrapy.Request(url=url, callback=self.parse)  
```

### 2. parse()

`parse()` 方法是默认的响应处理方法，用于解析响应并提取数据或生成新的请求
```python
def parse(self, response):  
    # 提取页面标题  
    title = response.css('title::text').get()  
    yield {  
        'title': title  
    }  
```

### 3. parse_item()

`parse_item()` 方法用于解析单个项目（Item）的响应，通常用于提取结构化数据
```python
def parse_item(self, response):  
    item = {}  
    item['name'] = response.css('div.name::text').get()  
    item['price'] = response.css('div.price::text').get()  
    yield item  
```

### 4. follow()

`follow()` 方法用于生成新的请求并自动处理响应，通常用于跟踪链接
```python
def parse(self, response):  
    for link in response.css('a::attr(href)'):  
        yield response.follow(link, self.parse_item)  
```

### 5. yield

`yield` 关键字用于生成请求或项目（Item），并将其传递给 Scrapy 引擎进行处理
```python
def parse(self, response):  
    yield {  
        'title': response.css('title::text').get()  
    }  
```

### 6. Item

`Item` 类用于定义数据结构，通常用于存储从网页中提取的数据
```python
import scrapy  
  
class MyItem(scrapy.Item):  
    name = scrapy.Field()  
    price = scrapy.Field()  
```

### 7. ItemLoader

`ItemLoader` 类用于加载和填充 Item 对象，简化数据提取和处理的流程
```python
from scrapy.loader import ItemLoader  
from myproject.items import MyItem  
  
def parse(self, response):  
    loader = ItemLoader(item=MyItem(), response=response)  
    loader.add_css('name', 'div.name::text')  
    loader.add_css('price', 'div.price::text')  
    yield loader.load_item()  
```

### 8. Request

`Request` 类用于生成 HTTP 请求对象，通常用于定义请求的 URL、回调方法等
```python
import scrapy  
  
def parse(self, response):  
    yield scrapy.Request(url='http://example.com/page3', callback=self.parse_item)  
```

### 9. Response

`Response` 类表示 HTTP 响应对象，包含从服务器返回的 HTML 内容、状态码等信息
```python
def parse(self, response):  
    print(response.status)  # 打印响应状态码  
    print(response.body)    # 打印响应内容  
```

### 10. Selector

`Selector` 类用于从 HTML 或 XML 文档中提取数据，支持 XPath 和 CSS 选择器
```python
def parse(self, response):  
    title = response.xpath('//title/text()').get()  
    yield {  
        'title': title  
    }  
```

### 11. CrawlSpider

`CrawlSpider` 是一种特殊的 Spider 类，用于处理复杂的爬取规则和链接跟踪
```python
from scrapy.spiders import CrawlSpider, Rule  
from scrapy.linkextractors import LinkExtractor  
  
class MyCrawlSpider(CrawlSpider):  
    name = 'mycrawlspider'  
    allowed_domains = ['example.com']  
    start_urls = ['http://example.com']  
  
    rules = (  
        Rule(LinkExtractor(allow=('page/\d+',)), 
        callback='parse_item'),  
    )  
  
    def parse_item(self, response):  
        yield {  
            'title': response.css('title::text').get() 
        }  
```

### 12. LinkExtractor

`LinkExtractor` 类用于从响应中提取链接，通常用于自动跟踪页面中的链接
```python
from scrapy.linkextractors import LinkExtractor  
  
def parse(self, response):  
    extractor = LinkExtractor(allow=('page/\d+',))  
    links = extractor.extract_links(response)  
    for link in links:  
        yield scrapy.Request(link.url, callback=self.parse_item)  
```

### 13. Pipeline

`Pipeline` 类用于处理爬取到的数据，通常用于数据清洗、存储等操作
```python
class MyPipeline:  
    def process_item(self, item, spider):  
        # 处理 item 数据  
        return item  
```

### 14. Middleware

`Middleware` 类用于处理请求和响应的中间件，通常用于修改请求头、处理异常等操作
```python
class MyMiddleware:  
    def process_request(self, request, spider):  
        # 修改请求头  
        request.headers['User-Agent'] = 'MyCustomUserAgent'  
        return None
```