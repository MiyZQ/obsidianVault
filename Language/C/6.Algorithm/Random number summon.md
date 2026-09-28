
线性同余生成器算法（LCG）：

```c
static unsigned long int next = 1;
unsigned int rand(){
next = next * 1103515245 + 12345;
return (unsigned int) (next / 65536) % 32768;
}
```

为改变伪随机数，需要重置种子函数，一般采用time()来改变初始next值，从而得到随机数生成的一种算法：

```c
#include <stdlib.h>
#include <time.h>
srand(time(0));
int a = rand();
```

对随机数取模就可以限制在一定的范围中

更好的算法是Mersenne Twister算法，利用了梅森素数$2^{19937}-1$