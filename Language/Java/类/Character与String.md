
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