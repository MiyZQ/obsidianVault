
C# 中 const 与 readonly 均可限制字段修改，但初始化与作用范围不同

|对比项|const|readonly|
|---|---|---|
|初始化时间|编译时|运行时也可以初始化|
|是否必须在声明时赋值|是|否，也可以在构造函数中赋值|
|是否可以修改|不能重新赋值|初始化后不能在普通代码中重新赋值|
|支持的类型|仅支持符合常量声明规则的类型|支持更多数据类型|
|是否属于静态成员|类中的 const 成员隐式为静态|可以是实例字段，也可以声明为 static readonly|
|典型用途|固定数学常量、状态标识等|运行时初始化后不再重新赋值的字段|

使用如：
```cs
class A
{
    const double PI = 3.14;
    readonly DateTime createdAt;

    public A()
    {
        createdAt = new DateTime();
    }

    static void Main()
    {
        A obj = new A();
        Console.WriteLine(PI);
        Console.WriteLine(obj.createdAt.ToString("yyyy-MM-dd"));
    }
}
```