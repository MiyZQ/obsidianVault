
在大部分compiler中，`printf`、`scanf`等函数的可选参数实际上是从右向左求值的，比如：

函数作用：
`printf("%c%c%c%c%c\n",getchar(),getchar(),getchar(),getchar(),getchar());`

abcde -> edcba

