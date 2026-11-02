
## 表单验证

用于确保用户输入数据符合预期格式规则，通常要验证以下信息：
- 数据是否为空
- 输入是否是正确邮箱地址
- 输入是否是正确日期格式
- 输入内容是否为数字

#### HTML5 自动验证
HTML5 有内置的表单验证功能，包括 required、pattern、min、max 等属性
```html
<form>
  <label for="email">Email:</label>
  <input type="email" id="email" name="email" required>
  <input type="submit" value="Submit">
</form>
```

> `required` 属性确保用户必须输入电子邮件地址，而 `type="email"` 会自动验证输入是否为有效的电子邮件格式

**约束验证 HTML 输入属性：**

| 属性       | 描述           |
| -------- | ------------ |
| disabled | 规定输入的元素不可用   |
| max      | 规定输入元素的最大值   |
| min      | 规定输入元素的最小值   |
| pattern  | 规定输入元素值的模式   |
| required | 规定输入元素字段是必需的 |
| type     | 规定输入元素的类型    |

**约束验证 CSS 伪类选择器：**

| 选择器       | 描述                            |
| --------- | ----------------------------- |
| :disabled | 选取属性为 "disabled" 属性的 input 元素 |
| :invalid  | 选取无效的 input 元素                |
| :optional | 选择没有"optional"属性的 input 元素    |
| :required | 选择有"required"属性的 input 元素     |
| :valid    | 选取有效值的 input 元素               |
#### JS 自定义验证
以下函数用来检查用户是否已填写表单中的必填项目，假如为空会弹出警告框并返回 false
```js
function validateForm() {
  var x=document.forms["myForm"]["fname"].value;
  if (x==null || x=="") {
    alert("姓必须填写");
    return false;
  }
}
```

```html
<form name="myForm" action="demo-form.php" onsubmit="return validateForm()" method="post">
姓: <input type="text" name="fname">
<input type="submit" value="提交">
</form>
```

下面是邮箱格式验证的 JS 函数：
```js
function validateEmail(email) {
  var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
}
```