
此文整理各种组合数的算法

## 组合数$\dbinom{n}{k}$

内存效率高，适用于单次计算或k值较小的情况：
```c
long long combination(int n, int k) {  
    if (k < 0 || k > n) return 0;  
    if (k == 0 || k == n) return 1;  
    if (k > n - k) k = n - k;  
    long long result = 1;  
    for (int i = 1; i <= k; i++) result = result * (n - k + i) / i;  
    return result;  
}
```

//时间效率高，适合需要多次查询不同组合数的情况：
```c
long long combination_dp(int n, int k) {  
    if (k < 0 || k > n) return 0;  
    // 创建DP表  
    long long **dp = (long long**)malloc((n+1) * sizeof(long long*));  
    for (int i = 0; i <= n; i++) {  
        dp[i] = (long long*)malloc((i+1) * sizeof(long long));  
        dp[i][0] = dp[i][i] = 1;  
        for (int j = 1; j < i; j++) dp[i][j] = dp[i-1][j-1] + dp[i-1][j];  
    }  
    long long result = dp[n][k];  
    for (int i = 0; i <= n; i++) free(dp[i]);  
    free(dp);  
    return result;  
}
```