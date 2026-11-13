
> cookie 用于存储 web 页面的用户信息，当浏览器从服务器上请求 web 页面时， 属于该页面的 cookie 会被添加到该请求中

### cookie 对象

1. 在 document.cookie 中写入完整字符串后，重新读取时 cookie 将以名/值对的形式展示
2. 设置新的 cookie 不会覆盖旧 cookie，将返回如下类型：cookie1=value; cookie2=value;
3. 如果要查找一个指定 cookie 值，必须创建一个 JS 函数在 cookie 字符串中查找 cookie 值

### 创建 cookie

可以通过 document.cookie 属性来创建、读取、删除 cookie，如：
```js
document.cookie="username=miy";
```

> [!NOTE]
> 默认情况下，cookie 在浏览器关闭时删除

还可以添加过期时间、cookie 的路径等：
```js
document.cookie="username=miy; expires=Tue, 25 Oug 2026 12:00:00 GMT; path=/";
```

> document.cookie 将以字符串的方式返回所有的 cookie，类型格式： cookie1=value; cookie2=value; cookie3=value;

### 删除 cookie

删除 cookie 只需设置 expires 参数为以前的时间即可

### 设置 cookie 值的函数

```js
function setCookie(cname,cvalue,exdays) {
  var d = new Date();
  d.setTime(d.getTime()+(exdays*86400000));
  var expires = "expires="+d.toGMTString();
  document.cookie = cname + "=" + cvalue + "; " + expires;
}
```

### 获取 cookie 值的函数

```js
function getCookie(cname) {
  var name = cname + "=";
  var ca = document.cookie.split(';');
  for(var i=0; i<ca.length; i++) {
    var c = ca[i].trim();
    if (c.indexOf(name)==0) 
    	return c.substring(name.length,c.length);
  }
  return "";
}
```

> [!NOTE]
> trim() 方法可以去除字符串前后的空格

### 检测 cookie 值的函数

下例逻辑为：
	如果设置了 cookie，将显示一个问候信息
	如果没有设置 cookie，将会显示一个弹窗用于询问访问者的名字，并调用 setCookie 函数将访问者的名字存储 365 天

```js
function checkCookie()
{
  var username=getCookie("username");
  if (username!="")
  {
    alert("Welcome again " + username);
  }
  else 
  {
    username = prompt("Please enter your name:","");
    if (username!="" && username!=null)
    {
      setCookie("username",username,365);
    }
  }
}
```