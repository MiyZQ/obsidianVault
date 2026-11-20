
### Character

Character 类是 char 的包装类，方法有：
`isLetter`、`isDigit`、`isWhitespace`、`isUpperCase`、`isLowerCase`、`toUpperCase`、`toString`

### String

访问长度
```java
str.length();
```

连接字符串
```java
String str3 = str1.concat(str2);
str3 += str1 + str2;
```

通过 printf 格式化输出和 format 得到格式化字符串
```java
System.out.printf("%d",num);
String fs = String.format("%d",num);
```

此外还有方法：
	`compareTo` 与另一个对象比较，或按字典序比较两串、`compareToIgnoreCase` 忽略大小写版本、`equals` 与另一对象判断相等 、` contentEquals ` 与 StringBuffer 对象判断相等、`matches` 是否匹配模式、`split` 按模式匹配拆分串、`isEmpty` 是否为空

### StringBuilder

与 String 不同，StringBuilder 类的对象可以==被多次修改==且不产生新的未使用对象

> StringBuffer 类相比具有线程安全特性，可以同步访问，但速度会稍低。一般情况建议用 StringBuilder 类

```java
StringBuilder sb = new StringBuilder(10);
sb.append("hello"); // hello
sb.append("World"); // helloWorld
sb.insert(5,"Java"); // helloJavaWorld
sb.delete(9,14); // helloJava
```

方法有：
	`append` 追加、`reverse` 反转、`delete` 移除、`insert` 插入、`capacity` 容量、`charAt` 指定索引的 char 值、`ensureCapacity` 确保容量大于等于参数、`indexOf` 第一次出现子序列索引、`lastIndexOf` 最后出现的索引、`length` 长度、`subSequence` 返回新的子序列、`substring` 返回新的子串、`toString` 返回字符串形式

> [!NOTE]
> 有些方法与 String 是互通的