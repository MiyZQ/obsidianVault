
高精度加法通过转为字符串提高数字位数，如下代码：
```c
char* plus(const char* a, const char* b) {  
    int lena = (int)strlen(a), lenb = (int)strlen(b);  
    char* max = (lena > lenb) ? a : b;  
    char* min = (lena <= lenb) ? a : b;  
    int len1 = (int)strlen(max), len2 = (int)strlen(min);  
    char* p = calloc(len1 + 2, sizeof(char));  
    if (p == NULL) exit(0);  
    int i = len1 - 1;  
    int flag = 0;  
    for (int j = len2 - 1; j >= 0; i--, j--) {  
        int sum = (max[i] - '0') + (min[j] - '0') + flag;  
        flag = sum / 10;  
        p[i + 1] = '0' + (sum % 10);  
    }  
    for (; i >= 0; i--) {  
        int sum = (max[i] - '0') + flag;  
        flag = sum / 10;  
        p[i + 1] = '0' + (sum % 10);  
    }  
    if (flag) {  
        p[0] = '1';  
        return p;  
    } else {  
        memmove(p, p + 1, len1);  
        p[len1] = '\0';  
        return realloc(p, len1 + 1);  
    }  
}
```
由于该代码中使用了内存分配，用后需要记得==释放内存==

> [!NOTE]
> 高精度加、乘可以用多项式的角度来理解
