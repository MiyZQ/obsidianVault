
KMP算法是查找算法，在p中查找配对t，返回匹配首位的索引值，否则为-1，复杂度O(length(t)+length(p))

## next算法
next数组为主串与模式串在某位不匹配时，模式串指针回退的位置，定义为\[0,j-1]子串前后缀最大匹配长度，初始next\[0] = -1
```c
int* getnext(const char *p,int n)  
{  
    int *next = (int*)malloc(n*sizeof(int));  
    next[0] = -1;  
    int i = 0, j = -1;  
    while (i < n-1) {  
        if (j == -1 || p[i] == p[j]) next[++i] = ++j;  
        else j = next[j];  
    }  
    return next;  
}
```
如果单独使用next数组，记得释放内存

## 主函数
```c
int kmp(const char *p,const char *t,int len1,int len2)  
{  
    int i = 0;  
    int j = 0;  
    int *next = getnext(p,len1);  
    while (i < len1 && j < len2)  
    {  
        if (j == -1 || p[i] == t[j])  
        {i++;j++;}  
        else j = next[j];  
    }  
    free(next);  
    if (j == len2)  
        return i - j;  
    else  
        return -1;  
}
```