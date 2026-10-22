
## Collection 对象

前文所说 getElementByTagName() 方法返回的动态类数组实际就是 Collection 对象，==可以通过索引的方式访问其中的元素，也具备 length 属性==

> HTMLCollection 无法使用数组的方法： valueOf(), pop(), push(), 或 join()

## Nodelist 对象

Nodelist 对象是一个从文档中获取的节点列表，类似 Collection 对象，==可以通过索引的方式访问其中的元素，也具备 length 属性==

- 前文所说的 getElementByClassName 返回的就是 Nodelist 对象而不是 Collection 对象
- childNodes 属性返回的是 Nodelist 对象
- 大部分浏览器的 querySelectorAll() 返回 Nodelist 对象

## 两者区别

1. Collection 对象是动态的实时视图，Nodelist 对象是静态快照，后续 DOM 变化不会更新
2. Collection 对象是 HTML 元素的集合，Nodelist 对象是文档节点的集合
3. 只有 Nodelist 对象有包含属性节点和文本节点