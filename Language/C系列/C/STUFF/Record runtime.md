
## 1）秒级精度

```c
#include <time.h>
time_t start,end;
start = time(0);
{body}
end = time(0);
double duration = difftime(end,start);
```

## 2）毫秒级精度（测量CPU）

```c
#include <time.h>
clock_t start,end;
start = clock();
{body}
end = clock();
double duration = (double) (end - start) / CLOCKS_PER_SEC;
```

以上测量只包含程序实际运行的时间，并不包括sleep在内的等待时间，下面算法则包含在内

## 3）微秒级精度

```c
#include <sys/time.h>
struct timeval,start,end;
long seconds,microseconds;
double duration;
gettimeofday(&start,NULL);
{body}
gettimeofday(&end,NULL);
seconds = end.tv_sec - start.tv_sec;
microseconds = end.tv_usec - start.tv_usec;
duration = seconds + microseconds * 1e-6;
```
