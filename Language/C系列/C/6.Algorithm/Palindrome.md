
以下为跟回文有关的代码

## 判断回文串
```c
_Bool palindrome(const char *str,int len)  
{  
    int left = 0,right = len-1;  
    _Bool flag = 1;  
    while (left < right)  
    {if (str[left] != str[right])  
        {flag=0;break;}  
        left++;  
        right--;  
    }  
    return flag;  
}
```

## 判断数字回文
```c
int palindrome_num(int num)  
{  
    if (num == 0) return 1;  
    else if (num < 0) num = -num;  
    int original = num, reversed = 0;  
    while (num > 0)  
    {  
        reversed = reversed * 10 + num % 10;  
        num /= 10;  
    }  
    return original == reversed;  
}
```

更多数学算法见Math[4.1 Fibonachi](../4.Math/4.1%20Fibonachi.md)
特殊的回文特性可见[Character for IO](../STUFF/Character%20for%20IO.md)