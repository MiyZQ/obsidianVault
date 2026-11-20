
java.util.Scanner 类可以获取用户的输入，创建对象的基本语法：
```java
Scanner s = new Scanner(System.in);
```

使用示例：
```java
Scanner scan = new Scanner(System.in);
if (scan.hasNext()) {
	String str = scan.next();
	System.out.println("the input is:" + str);
}
scan.close();
```

> 使用 next 可以读取下一个 token，使用 nextLine 读取回车之前所有字符（可以为空）
> 使用前应用 hasNext 或 hasNextLine 来判断是否还有输入

若输入 int、float 之类的数据，可以使用 hasNextXxx 方法验证，再用 nextXxx 读取：
```java
Scanner scan = new Scanner(System.in);
if (scan.hasNextInt()) {
	int i = scan.nextInt();
	System.out.println("the input is:" + i);
}
else {
	System.out.println("not Integer");
}
scan.close();
```

此外，还有各种方法可使用，如分隔符控制：
	`useDelimiter` 设置分隔符模式、`delimiter` 返回当前分隔符模式

其他方法：
	`skip` 跳过指定匹配模式的输入、`findInLine` 当前行查找指定模式/字符串、`reset` 重置扫描器、`locale` 返回扫描器当前使用的区域设置、`useLocale` 设置扫描器的区域设置