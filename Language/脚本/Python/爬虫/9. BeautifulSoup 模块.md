
此模块用于从网页提取数据，适用于解析 HTML 和 XML 文件

安装依赖：
```bash
pip install beautifulsoup4
pip install lxml
```
若不使用 lxml 也可使用 Python 内置的 html.parser 作为解析器，相比内置解析器，lxml 速度更快

---

## 使用

### 基本用法

```python
from bs4 import BeautifulSoup

soup = BeautifulSoup(res.text,'lxml') 
# 或 'html.parser'

# 查找<title>标签
title_tag = soup.find('title')
if title_tag:
	print(title_tag.get_text())
else:
	print('cant find <title> tag')
```

查找标签有 find() 方法、find_all() 方法，前者返回第一个匹配的标签，后者返回所有匹配的标签
```python
link_1 = soup.find('a')
url_1 = link_1.get('href')
print(url_1)
```

> [!INFO]
> get（） 方法获取标签的属性，get_text() 方法获取标签的文本内容

### 查找子标签、父标签

使用 parent、children 属性：
```python
parent_tag = link.parent
children_tag = link.children
```

### 查找具有特定属性的标签

用法如：
```python
divs_with_class = soup.find_all('div',class_='demo')
unique_para = soup.find('p',id='unique_id')
```

### CSS 选择器查找

select() 方法允许使用类似 jQuery 的选择器语法来查找标签
```python
# 查找所有class为demo的div标签
divs = soup.select('div.demo')
# 查找所有a标签中的href属性
links = soup.select('a[href]')
```

### 嵌套标签处理

可以通过递归查找子标签的方式处理深度嵌套的 HTML 结构
```python
divs = soup.find_all('div',class_='nested')
for div in divs:
	print(div.get_text())
```

### 修改网页内容

```python
修改第一个a标签的href属性
link_1['href'] = 'http://demo.com'

# 修改第一个p标签文本内容
first_para = soup.find('p')
first_para.string = 'New content'

# 删除标签
first_para.decompose()
```

### 转换字符串

将解析的 BeautifulSoup 对象转换为 HTML 字符串
```python
html_str = str(soup)
```


---

## 属性与方法

### 常用属性方法
| 方法/属性                      | 描述                                       | 示例                                               |
| -------------------------- | ---------------------------------------- | ------------------------------------------------ |
| `BeautifulSoup()`          | 用于解析 HTML 或 XML 文档并返回一个 BeautifulSoup 对象 | `soup = BeautifulSoup(html_doc, 'html.parser')`  |
| `.prettify()`              | 格式化并美化文档内容，生成结构化的字符串                     | `print(soup.prettify())`                         |
| `.find()`                  | 查找第一个匹配的标签                               | `tag = soup.find('a')`                           |
| `.find_all()`              | 查找所有匹配的标签，返回一个列表                         | `tags = soup.find_all('a')`                      |
| `.find_all_next()`         | 查找当前标签后所有符合条件的标签                         | `tags = soup.find('div').find_all_next('p')`     |
| `.find_all_previous()`     | 查找当前标签前所有符合条件的标签                         | `tags = soup.find('div').find_all_previous('p')` |
| `.find_parent()`           | 返回当前标签的父标签                               | `parent = tag.find_parent()`                     |
| `.find_all_parents()`      | 查找当前标签的所有父标签                             | `parents = tag.find_all_parents()`               |
| `.find_next_sibling()`     | 查找当前标签的下一个兄弟标签                           | `next_sibling = tag.find_next_sibling()`         |
| `.find_previous_sibling()` | 查找当前标签的前一个兄弟标签                           | `prev_sibling = tag.find_previous_sibling()`     |
| `.parent`                  | 获取当前标签的父标签                               | `parent = tag.parent`                            |
| `.next_sibling`            | 获取当前标签的下一个兄弟标签                           | `next_sibling = tag.next_sibling`                |
| `.previous_sibling`        | 获取当前标签的前一个兄弟标签                           | `prev_sibling = tag.previous_sibling`            |
| `.get_text()`              | 提取标签内的文本内容，忽略所有HTML标签                    | `text = tag.get_text()`                          |
| `.attrs`                   | 返回标签的所有属性，以字典形式表示                        | `href = tag.attrs['href']`                       |
| `.string`                  | 获取标签内的字符串内容                              | `string_content = tag.string`                    |
| `.name`                    | 返回标签的名称                                  | `tag_name = tag.name`                            |
| `.contents`                | 返回标签的所有子元素，以列表形式返回                       | `children = tag.contents`                        |
| `.descendants`             | 返回标签的所有后代元素，生成器形式                        | `for child in tag.descendants: print(child)`     |
| `.parent`                  | 获取当前标签的父标签                               | `parent = tag.parent`                            |
| `.previous_element`        | 获取当前标签的前一个元素（不包括文本）                      | `prev_elem = tag.previous_element`               |
| `.next_element`            | 获取当前标签的下一个元素（不包括文本）                      | `next_elem = tag.next_element`                   |
| `.decompose()`             | 从树中删除当前标签及其内容                            | `tag.decompose()`                                |
| `.unwrap()`                | 移除标签本身，只保留其子内容                           | `tag.unwrap()`                                   |
| `.insert()`                | 向标签内插入新标签或文本                             | `tag.insert(0, new_tag)`                         |
| `.insert_before()`         | 在当前标签前插入新标签                              | `tag.insert_before(new_tag)`                     |
| `.insert_after()`          | 在当前标签后插入新标签                              | `tag.insert_after(new_tag)`                      |
| `.extract()`               | 删除标签并返回该标签                               | `extracted_tag = tag.extract()`                  |
| `.replace_with()`          | 替换当前标签及其内容                               | `tag.replace_with(new_tag)`                      |
| `.has_attr()`              | 检查标签是否有指定的属性                             | `if tag.has_attr('href'):`                       |
| `.get()`                   | 获取指定属性的值                                 | `href = tag.get('href')`                         |
| `.clear()`                 | 清空标签的所有内容                                | `tag.clear()`                                    |
| `.encode()`                | 编码标签内容为字节流                               | `encoded = tag.encode()`                         |
| `.is_empty_element`        | 检查标签是否是空元素（例如 `<br>`、`<img>` 等）          | `if tag.is_empty_element:`                       |
| `.is_ancestor_of()`        | 检查当前标签是否是指定标签的祖先元素                       | `if tag.is_ancestor_of(another_tag):`            |
| `.is_descendant_of()`      | 检查当前标签是否是指定标签的后代元素                       | `if tag.is_descendant_of(another_tag):`          |

### 其他属性

| 方法/属性     | 描述                  | 示例                          |
| --------- | ------------------- | --------------------------- |
| `.style`  | 获取标签的内联样式           | `style = tag['style']`      |
| `.id`     | 获取标签的 `id` 属性       | `id = tag['id']`            |
| `.class_` | 获取标签的 `class` 属性    | `class_name = tag['class']` |
| `.string` | 获取标签内部的字符串内容，忽略其他标签 | `content = tag.string`      |
| `.parent` | 获取标签的父元素            | `parent = tag.parent`       |

### 其他

| 方法/属性              | 描述            | 示例                                                          |
| ------------------ | ------------- | ----------------------------------------------------------- |
| `find_all(string)` | 使用字符串查找匹配的标签  | `tag = soup.find_all('div', class_='container')`            |
| `find_all(id)`     | 查找指定 `id` 的标签 | `tag = soup.find_all(id='main')`                            |
| `find_all(attrs)`  | 查找具有指定属性的标签   | `tag = soup.find_all(attrs={"href": "http://example.com"})` |
