# C++ 多线程笔记

> 整理 C++ 多线程核心知识，聚焦 C++11 及以上标准

---

## 1. 基础概念

### 1.1 进程 vs 线程

在理解多线程之前，先要搞清楚两个基本单位：**进程（Process）** 和 **线程（Thread）**。

#### 什么是进程？

**进程是程序的一次执行实例**。当你双击打开一个应用程序时，操作系统会为它创建一个独立的进程。每个进程都有自己独立的内存空间（比如代码区、数据区、堆区、栈区），进程之间相互隔离，一个进程崩溃不会直接影响另一个进程。

#### 什么是线程？

**线程是进程内的执行单元**，一个进程可以包含多个线程，这些线程共享进程的内存空间（包括堆、全局变量等），但每个线程有自己的栈和寄存器。

#### 为什么线程更轻量？

| 对比维度 | 进程 | 线程 |
|---------|------|------|
| **资源分配** | 需要独立分配地址空间 | 共享进程资源，无需额外分配 |
| **创建/销毁开销** | 大（需要分配内存、建立PCB等） | 小（只需分配栈和寄存器） |
| **切换开销** | 大（需要切换页表、刷新TLB等） | 小（只需切换寄存器和栈） |
| **通信方式** | 复杂（需要IPC管道、消息队列、共享内存等） | 简单（直接读写共享内存） |
| **独立性** | 高，一个崩溃不影响另一个 | 低，一个崩溃可能导致整个进程崩溃 |

#### 代码层面的理解

```cpp
// 单线程程序：只有一个"员工"在干活
int main() {
    do_task();  // 主线程执行
    return 0;
}

// 多线程程序：多个"员工"同时干活
int main() {
    std::thread t1(do_task);  // 员工1
    std::thread t2(do_task);  // 员工2
    t1.join();
    t2.join();
    return 0;
}
```

### 1.2 并发 vs 并行

#### 并发 (Concurrency)

**定义**：多个任务交替执行，在宏观上看起来像是"同时"进行，但在微观上（任意时刻）只有一个任务在执行。

**场景**：适合单核 CPU，或者任务是 I/O 密集型（需要等待网络、磁盘等）的情况。

```
时间轴:  |---任务A---|---任务B---|---任务A---|---任务B---|

单核CPU的并发：CPU在任务A和B之间快速切换，看起来像同时进行
```

**生活类比**：你一边写文档，一边等下载。CPU 在你打字时和下载等待时切换，让你感觉是"同时"进行。

#### 并行 (Parallelism)

**定义**：多个任务真正同时执行，必须在多核 CPU 上才能实现。

**场景**：适合 CPU 密集型任务（大量计算）。

```
时间轴:  |---任务A---|  同时  |---任务B---|
        核心1处理A              核心2处理B
```

**生活类比**：你有两个厨房帮手，一个人炒菜、一个人煮饭，可以真正同时进行。

#### 两者的关系

```
并发 + 并行 = 最高效的多线程
    ↓
多个核心（实现并行）+ 任务交替执行（实现并发）
```

#### C++ 中的体现

```cpp
// std::thread::hardware_concurrency() 返回CPU核心数
std::cout << "我的电脑有 "
          << std::thread::hardware_concurrency()
          << " 个CPU核心" << std::endl;

// 根据核心数决定线程数
int num_threads = std::thread::hardware_concurrency();
```

### 1.3 线程安全问题

多线程的强大在于"同时执行"，但这带来一个核心问题：**共享资源的安全访问**。

#### 数据竞争 (Data Race)

**什么是数据竞争？** 当两个或多个线程同时访问同一个内存位置，且至少有一个访问是"写操作"时，就会发生数据竞争。结果是不可预测的，取决于哪个线程先完成。

**举例说明**：
```cpp
int counter = 0;  // 共享变量

// 线程A执行: counter = counter + 1
// 线程B执行: counter = counter + 1
// 期望结果：counter = 2
// 实际可能：counter = 1（因为操作不是原子的）
```

**为什么会这样？** `counter = counter + 1` 在 CPU 层面分成三步：
1. 从内存读取 counter 到寄存器
2. 在寄存器中加 1
3. 把结果写回内存

两个线程可能同时读完旧值，都加了1，都写回去，结果只加了一次！

#### 竞态条件 (Race Condition)

**什么是竞态条件？** 程序结果依赖于线程执行的精确时序，同样的代码多次运行可能得到不同结果。

**数据竞争是竞态条件的一种**，但竞态条件的范围更广。比如：
- 线程A检查某个条件，线程B根据这个条件做决定
- 如果A还没检查完B就开始行动，就会出问题

**举例**：
```cpp
// 竞态条件例子：检查-然后-行动
if (queue.is_empty()) {      // 检查
    queue.add(item);          // 行动
}
// 两个线程都可能发现队列空，都往里添加数据
```

#### 死锁 (Deadlock)

**什么是死锁？** 两个或多个线程互相等待对方持有的锁，导致所有线程都无法继续执行。

**比喻**：两个人面对面过独木桥，甲需要礼让乙，乙需要礼让甲，结果两人都等着对方让路，谁也过不去。

**ABBA 死锁示例**：
```cpp
std::mutex mtx1, mtx2;

// 线程A的策略：先锁1，再锁2
void task_A() {
    std::lock_guard<std::mutex> lock1(mtx1);
    std::lock_guard<std::mutex> lock2(mtx2);  // 等待mtx2
    // work
}

// 线程B的策略：先锁2，再锁1
void task_B() {
    std::lock_guard<std::mutex> lock2(mtx2);
    std::lock_guard<std::mutex> lock1(mtx1);  // 等待mtx1
    // work
}

// 可能发生：
// T1时刻：A锁住了mtx1，B锁住了mtx2
// T2时刻：A想锁mtx2（被B持有，等待），B想锁mtx1（被A持有，等待）
// 两个线程都在等待对方释放锁 -> 死锁！
```

**四个必要条件（产生死锁必须同时满足）**：
1. **互斥**：资源每次只能被一个线程持有
2. **持有并等待**：线程持有资源的同时还在等待其他资源
3. **不可抢占**：资源不能被强制从持有线程手中夺走
4. **循环等待**：存在一个线程环形链，每个线程都在等待下一个线程持有的资源

只要破坏其中任何一个条件，就可以避免死锁。

#### 活锁 (Livelock)

**什么是活锁？** 线程没有阻塞，看起来在运行，但实际无法取得进展。线程不断重复同样的操作（通常是检测冲突后回退）。

**比喻**：两个人在走廊相遇，甲往左让，乙也往左让；甲往右让，乙也往右让……两人永远相遇，永远礼让，永远过不去。

**举例**：
```cpp
// 活锁示例：两个线程不断重试
while (true) {
    if (try_lock(resource)) {
        use_resource();
        unlock(resource);
        break;
    } else {
        // 获取锁失败，但不做任何等待，而是立即重试
        // 如果另一个线程也在做同样的事，就会一直"抢"但谁也抢不到
    }
}
```

**活锁 vs 死锁**：
- 死锁：线程被阻塞，什么都不做
- 活锁：线程在做无用功，消耗CPU但没有进展

---

## 2. 线程管理 (std::thread)

### 2.1 什么是 std::thread？

`std::thread` 是 C++11 引入的线程管理类，它代表一个执行线程。你可以把线程想象成一个"任务执行者"，一旦创建，它就会开始执行你指定的函数。

**基本概念**：
- 创建 `std::thread` 对象时，线程立即开始执行
- 你需要决定：是否等待它完成（`join`）或让它独立运行（`detach`）
- 每个线程都有一个唯一的 ID，可以用来标识和区分线程

### 2.2 创建线程

```cpp
#include <thread>
#include <iostream>

void hello() {
    std::cout << "Hello from thread!\n";
}

int main() {
    std::thread t(hello);  // ①创建线程，立即开始执行 hello 函数
    t.join();              // ②主线程等待 t 执行完毕
    return 0;
}
```

**执行流程**：
1. `std::thread t(hello)` 创建线程，线程开始执行 `hello()`
2. `t.join()` 让主线程（运行 `main()` 的线程）等待 `t` 完成
3. 主线程等待期间被阻塞，直到 `t` 执行完 `hello()` 才继续

**如果省略 `join()` 呢？**
- 如果 `t` 还在执行时 `t` 对象被销毁，程序会终止（`std::terminate` 被调用）
- 这是一个容易犯的错误！

### 2.3 带参数创建线程

```cpp
void print_sum(int a, int b) {
    std::cout << a + b << "\n";
}

int main() {
    std::thread t(print_sum, 3, 5);  // 传递参数给线程函数
    t.join();
}
```

参数会按值传递给线程函数。如果你想传递引用，需要用 `std::ref()` 包装：
```cpp
void increment(int& counter) {
    counter++;
}

int main() {
    int counter = 0;
    std::thread t(increment, std::ref(counter));  // 传递引用
    t.join();
    std::cout << counter << "\n";  // 输出 1
}
```

### 2.4 线程 ID

**线程 ID** 是标识线程的唯一编号。有什么用？
- 调试时区分不同线程
- 记录日志时标记是哪个线程在运行
- 检查当前是否在特定线程中运行

```cpp
std::thread::id main_id = std::this_thread::get_id();  // 获取当前线程ID

void worker() {
    std::cout << "Worker ID: " << std::this_thread::get_id() << "\n";
}

int main() {
    std::thread t(worker);
    std::cout << "Main ID: " << main_id << "\n";
    t.join();
}
```

**输出类似**：
```
Main ID: 12384
Worker ID: 12385
```
（ID 号是系统分配的，每次运行可能不同）

### 2.5 detach 与 join：两种线程结束方式

这是两个必须掌握的概念，决定了线程的生命周期管理。

#### join（连接）：主线程等待子线程

```cpp
std::thread t([](){ /* work */ });
t.join();  // 主线程在此处阻塞，等待 t 完成
// 继续执行...
```

**特点**：
- `join()` 会阻塞调用它的线程（这里是主线程）
- 阻塞一直持续到被等待的线程执行完毕
- `join()` 返回后，线程安全结束，资源被回收

**使用场景**：
- 你需要确保线程完成后再继续（比如计算结果需要用于后续步骤）
- 你需要处理线程可能抛出的异常

#### detach（分离）：子线程独立运行

```cpp
std::thread t([](){ /* work */ });
t.detach();  // t 在后台独立运行
// 主线程继续执行...
```

**特点**：
- `detach()` 不会阻塞
- 子线程在后台独立运行，直到它自己结束
- `detach()` 后，线程对象的 `std::thread` 就不再代表任何线程
- 你不能再对这个 `std::thread` 对象调用 `join()` 或 `detach()`

**使用场景**：
- 任务不需要结果，主线程不关心它何时完成
- 比如日志记录、后台监控等
- 适用于"发了就不管"的场景

#### ⚠️ 重要规则

**线程对象销毁前必须调用 `join()` 或 `detach()`！**

```cpp
// ❌ 危险：线程还在运行，对象就被销毁了
void bad_function() {
    std::thread t([](){ std::this_thread::sleep_for(std::chrono::seconds(10)); });
    // t 被销毁但没有 join 或 detach！
    // 程序会终止！
}

// ✅ 正确做法1：使用 join 等待完成
void good_function1() {
    std::thread t([](){ /* work */ });
    t.join();  // 等待完成
}

// ✅ 正确做法2：使用 detach 让它独立运行
void good_function2() {
    std::thread t([](){ /* work */ });
    t.detach();  // 分离
}

// ✅ 正确做法3：RAII 手法，确保一定会 join
class Joiner {
    std::thread& t;
public:
    Joiner(std::thread& t_) : t(t_) {}
    ~Joiner() {
        if (t.joinable()) t.join();
    }
};
```

### 2.6 线程属性

```cpp
#include <thread>

void worker() { /* ... */ }

int main() {
    // 获取硬件支持的核心数（建议的线程数）
    std::cout << "Hardware cores: " << std::thread::hardware_concurrency() << "\n";
    // 这个函数返回一个建议值：创建多少线程能最好利用CPU

    std::thread t(worker);
    t.join();
}
```

**`hardware_concurrency()`** 返回系统支持的硬件线程数。通常：
- 对 CPU 密集型任务：线程数 = 核心数
- 对 I/O 密集型任务：线程数 > 核心数（因为线程在等待时可以切换）

---

## 3. 互斥锁 (Mutex)

### 3.1 什么是互斥锁？为什么要用它？

**互斥锁（Mutual Exclusion）** 是线程同步的核心工具。它的作用是：保证同一时刻只有一个线程能访问某个共享资源。

**为什么需要它？**
考虑这个场景：
```cpp
int counter = 0;  // 共享变量

void increment() {
    counter++;  // 看起来只是一行代码
}
```

两个线程同时调用 `increment()`，`counter++` 的实际执行可能是：
```
线程A：读取counter(0) → 加1 → 写回(1)
线程B：读取counter(0) → 加1 → 写回(1)   // 读取的是A还没写回的值
结果：counter = 1，而不是预期的 2
```

**互斥锁就是解决这个问题的**：它确保对 `counter` 的访问是"原子"的——一次只有一个线程能进去。

### 3.2 std::mutex：最基础的互斥锁

```cpp
#include <mutex>
#include <thread>
#include <iostream>

int counter = 0;
std::mutex mtx;  // 创建一个互斥锁

void increment() {
    for (int i = 0; i < 100000; ++i) {
        mtx.lock();     // ①获取锁，如果已被其他线程持有，则阻塞等待
        ++counter;      // ②安全地访问共享资源
        mtx.unlock();    // ③释放锁，让其他线程可以获取
    }
}

int main() {
    std::thread t1(increment);
    std::thread t2(increment);
    t1.join();
    t2.join();
    std::cout << counter << "\n";  // 输出 200000（正确结果）
}
```

**`lock()` 和 `unlock()` 的工作原理**：
- `lock()`：尝试获取锁。如果锁空闲，获得锁，函数返回；如果锁被占用，阻塞等待
- `unlock()`：释放锁，唤醒等待该锁的线程

**手动管理的风险**：如果你忘记调用 `unlock()`，其他线程会永远等待（死锁）。如果抛异常前没解锁，也会死锁。这就是为什么有 RAII 的锁包装器。

### 3.3 std::lock_guard：自动释放锁（RAII手法）

**什么是 RAII？** "Resource Acquisition Is Initialization"——资源获取即初始化。在 C++ 中，这通常意味着：在构造函数中获取资源，在析构函数中释放资源。

**`std::lock_guard`** 就是一个 RAII 的锁包装器：
```cpp
void increment() {
    for (int i = 0; i < 100000; ++i) {
        std::lock_guard<std::mutex> lock(mtx);  // lock 在这里被获取
        ++counter;                               // 访问共享资源
    }  // lock 对象离开作用域，析构函数自动调用 unlock()
        // 即使这里抛异常，lock_guard 也会确保 unlock 被调用
}
```

**为什么更好？**
- 不需要手动 `unlock()`
- 异常安全：如果代码抛异常，锁也会被正确释放
- 代码更简洁，减少出错概率

### 3.4 std::unique_lock：更灵活的锁管理

`unique_lock` 是比 `lock_guard` 更灵活的版本，但开销稍大。

**支持的功能**：
```cpp
std::unique_lock<std::mutex> lock(mtx);

// 1. 支持延迟加锁：先创建锁对象，稍后再加锁
std::unique_lock<std::mutex> lock;
lock.lock(mtx);
// ...

// 2. 支持手动解锁（然后可以再锁）
lock.unlock();

// 3. 支持尝试加锁（非阻塞）
if (lock.try_lock()) {
    // 获取到锁了
}

// 4. 支持与 condition_variable 配合使用（lock_guard 不行）
```

**何时用 `unique_lock`？**
- 需要与 `condition_variable` 配合使用时
- 需要灵活控制锁的获取和释放时机时
- 其他情况，`lock_guard` 通常足够且更高效

### 3.5 std::recursive_mutex：允许同一线程多次加锁

**什么是递归锁？** 同一个线程可以多次获取同一个锁，而不会造成死锁。每次 `lock()` 需要匹配一次 `unlock()`。

```cpp
std::recursive_mutex rmtx;

void inner() {
    std::lock_guard<std::recursive_mutex> lock(rtmx);
    // 可以安全地再次调用 outer()
}

void outer() {
    std::lock_guard<std::recursive_mutex> lock(rtmx);
    inner();  // 如果是普通 mutex，这里会死锁；递归锁允许通过
}
```

**为什么不用普通 mutex？** 普通 mutex 同一个线程多次 lock 会导致未定义行为（通常死锁）。

**为什么需要递归锁？**
- 某些递归函数需要访问共享资源
- 简化锁的管理（不用处处传锁）

**缺点**：可能隐藏设计问题。如果需要频繁递归加锁，可能说明设计需要重构。

### 3.6 避免死锁的策略

#### 死锁的常见原因

1. **ABBA 死锁**：两个线程以不同顺序获取两把锁
```cpp
// ❌ 危险
void task_a() {
    std::lock_guard<std::mutex> lock1(mtx1);
    std::lock_guard<std::mutex> lock2(mtx2);  // 线程A先锁1后锁2
}

void task_b() {
    std::lock_guard<std::mutex> lock2(mtx2);
    std::lock_guard<std::mutex> lock1(mtx1);  // 线程B先锁2后锁1
    // 如果同时执行，可能死锁
}
```

2. **锁没有及时释放**：忘记 unlock，或者异常导致 unlock 没执行
3. **嵌套调用**：函数A获取锁后调用函数B，而函数B也要获取同一把锁

#### 解决方案

**方案1：固定加锁顺序**
```cpp
// ✅ 所有线程按同样顺序获取锁：始终先锁1，再锁2
void task_a() {
    std::lock_guard<std::mutex> lock1(mtx1);
    std::lock_guard<std::mutex> lock2(mtx2);
}

void task_b() {
    std::lock_guard<std::mutex> lock1(mtx1);  // 顺序与A一致
    std::lock_guard<std::mutex> lock2(mtx2);
}
```

**方案2：使用 std::lock 一次性获取多把锁**
```cpp
// ✅ std::lock 会使用死锁避免算法，同时获取多把锁
void task_a_safe() {
    std::lock(mtx1, mtx2);  // 同时获取两把锁，不会死锁
    std::lock_guard<std::mutex> lock1(mtx1, std::adopt_lock);
    std::lock_guard<std::mutex> lock2(mtx2, std::adopt_lock);
    // work
}

void task_b_safe() {
    std::lock(mtx2, mtx1);  // 顺序不同也没关系
    std::lock_guard<std::mutex> lock2(mtx2, std::adopt_lock);
    std::lock_guard<std::mutex> lock1(mtx1, std::adopt_lock);
    // work
}
```

**`std::adopt_lock` 的作用**：告诉 `lock_guard` "锁已经被获取了"，不要再调用 `lock()`。

**方案3：使用 scoped_lock（C++17）**
```cpp
// ✅ 更简洁的语法
void task_a() {
    std::scoped_lock lock(mtx1, mtx2);  // 自动处理死锁避免
    // work
}
```

**方案4：减少锁的使用**
- 使用无锁数据结构
- 使用原子操作
- 尽量缩小锁的粒度

---

## 4. 条件变量 (Condition Variable)

### 4.1 什么是条件变量？它解决什么问题？

**条件变量**用于线程间的**同步通信**——让一个线程等待另一个线程满足某个条件后再继续。

**场景举例**：生产者-消费者问题
- 消费者线程需要从队列中取数据
- 如果队列为空，消费者应该**等待**，而不是一直轮询（浪费CPU）
- 当生产者放入数据后，应该**通知**消费者解除等待

这就是条件变量的核心功能：**等待 + 通知**。

### 4.2 基本用法

```cpp
#include <condition_variable>
#include <mutex>
#include <thread>
#include <queue>

std::queue<int> q;           // 共享队列
std::mutex mtx;              // 保护队列的锁
std::condition_variable cv;  // 条件变量

// 生产者：放入数据
void producer() {
    for (int i = 0; i < 5; ++i) {
        {
            std::lock_guard<std::mutex> lock(mtx);
            q.push(i);
            std::cout << "Produced: " << i << "\n";
        }
        cv.notify_one();  // 通知一个等待中的消费者
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
}

// 消费者：取出数据
void consumer() {
    while (true) {
        std::unique_lock<std::mutex> lock(mtx);
        // wait 会原子地：1.解锁 mtx  2.等待条件满足  3.重新加锁 mtx
        cv.wait(lock, [this](){ return !q.empty(); });
        
        int val = q.front();
        q.pop();
        lock.unlock();  // 及时解锁，让生产者可以继续放入数据
        
        std::cout << "Got: " << val << "\n";
        if (val == 4) break;  // 收到最后一个，退出
    }
}

int main() {
    std::thread prod(producer);
    std::thread cons(consumer);
    prod.join();
    cons.join();
}
```

**执行流程**：
1. 初始状态：队列空，消费者调用 `wait()`，会解锁并阻塞
2. 生产者放入 0，调用 `notify_one()` 唤醒消费者
3. 消费者被唤醒后重新加锁，检查条件（队列非空），取走数据
4. 重复直到所有数据被消费

### 4.3 wait() 的第二个参数：防止虚假唤醒

**什么是虚假唤醒？** 条件变量的 `wait()` 有时会"无缘无故"醒来，这不是 bug，而是一种设计特性（为了实现效率）。所以你不能假设醒来就意味着条件满足。

**正确做法**：使用 `wait()` 的第二个参数（predicate）来检查条件：
```cpp
// ❌ 危险：可能在队列空的时候醒来，导致访问空队列
cv.wait(lock);

// ✅ 安全：只有条件为真才解除阻塞
cv.wait(lock, [](){ return !q.empty(); });
// wait 的伪代码逻辑：
// while (!predicate()) {
//     wait();
// }
```

### 4.4 notify_one vs notify_all

**`notify_one()`**：唤醒等待队列中的一个线程（如果有的话）
- 适用于只有一个消费者的情况
- 效率更高，因为只唤醒一个线程

**`notify_all()`**：唤醒所有等待的线程
- 适用于多个消费者，或者条件可能有不同解释的情况
- 所有被唤醒的线程都会检查条件，然后只有一个会成功获得锁

```cpp
// notify_all 示例：广播一个事件
cv.notify_all();  // 所有等待线程都被唤醒
```

### 4.5 为什么要用 unique_lock 而不是 lock_guard？

因为 `wait()` 需要**在等待时解锁**，在醒来后**重新加锁**。

`lock_guard` 不支持这个操作（它没有 `unlock()` 接口），所以必须使用更灵活的 `unique_lock`。

```cpp
// wait 期间的锁状态变化：
// 1. 调用 wait() 前：lock 持有锁
// 2. 进入 wait()：lock 释放锁，线程阻塞
// 3. 被 notify：线程醒来，重新获取锁
// 4. wait() 返回：lock 持有锁
```

---

## 5. 异步与 Future

### 5.1 什么是异步编程？为什么要用 Future？

**同步编程**：调用一个函数，必须等待它执行完毕才能继续。
```cpp
int result = compute();  // 程序在这里阻塞，等待 compute 完成
do_something(result);   // 然后才能做下一件事
```

**异步编程**：发起一个任务，不必等待它完成，继续做其他事，之后再获取结果。
```cpp
std::future<int> fut = std::async(compute);  // 立即返回，不阻塞
do_something_else();                         // 做其他事
int result = fut.get();                      // 获取结果（如果还没好，会阻塞在这里）
```

**Future** 就是这个"未来的结果"的占位符。你可以在结果准备好之前继续做其他事，然后随时用 `get()` 来获取。

### 5.2 std::async 与 std::future

```cpp
#include <future>
#include <iostream>

int compute(int x) {
    std::this_thread::sleep_for(std::chrono::seconds(2));  // 模拟耗时计算
    return x * x;
}

int main() {
    std::cout << "Starting task...\n";
    
    // std::async 启动一个异步任务，立即返回
    std::future<int> fut = std::async(std::launch::async, compute, 10);
    
    std::cout << "Task started, doing other work...\n";
    int result = fut.get();  // 如果任务还没完成，阻塞等待
    
    std::cout << "Result: " << result << "\n";  // 输出 100
}
```

**执行流程**：
1. `std::async` 创建一个新线程执行 `compute(10)`
2. `fut` 是一个"未来的结果"的句柄
3. 主线程继续执行（打印"doing other work..."）
4. `fut.get()` 如果 `compute` 还没完成，主线程阻塞；完成后返回结果

### 5.3 launch 策略：async 和 deferred

```cpp
// std::launch::async：立即在新线程执行
std::future<int> fut1 = std::async(std::launch::async, task);
// 任务会立即开始在新线程执行

// std::launch::deferred：延迟调用（懒执行）
std::future<int> fut2 = std::async(std::launch::deferred, task);
// 任务不会立即执行，只有调用 get()/wait() 时才在当前线程执行

// 不指定（默认）：由系统决定
std::future<int> fut3 = std::async(task);
// 通常等同于 async，但行为取决于实现
```

**如何选择？**
- `async`：需要真正并行执行时
- `deferred`：延迟执行不影响结果，且希望避免线程创建开销时（适合纯计算任务）

### 5.4 std::promise：在线程间传递值

**Promise** 用于在一个线程中设置值，在另一个线程中读取。

```cpp
void divide(std::promise<int>& prom, int a, int b) {
    try {
        if (b == 0) {
            throw std::runtime_error("Division by zero");
        }
        prom.set_value(a / b);  // 设置成功结果
    } catch (...) {
        prom.set_exception(std::current_exception());  // 设置异常
    }
}

int main() {
    std::promise<int> prom;          // 创建 promise
    std::future<int> fut = prom.get_future();  // 获取关联的 future
    
    std::thread t(divide, std::ref(prom), 10, 2);  // 在新线程执行
    
    try {
        std::cout << fut.get() << "\n";  // 获取结果
    } catch (const std::exception& e) {
        std::cout << "Error: " << e.what() << "\n";
    }
    
    t.join();
}
```

**Promise 和 Future 的配对**：
- `promise.set_value()` / `promise.set_exception()`：在"生产者"端设置值
- `future.get()`：在"消费者"端获取值
- 每个 `promise` 只能被 `set_value()` 一次

**使用场景**：当你需要在普通线程函数中返回结果时（不能用 `std::async` 直接包装的场景）。

### 5.5 std::packaged_task：包装可调用对象

**packaged_task** 把任何可调用对象（函数、lambda、 functor）包装成可以异步执行的任务，并自动关联一个 promise。

```cpp
int main() {
    // 创建一个包装任务
    std::packaged_task<int(int, int)> task([](int a, int b) {
        return a + b;
    });
    
    std::future<int> fut = task.get_future();  // 获取 future
    std::thread t(std::move(task), 3, 4);       // 移动任务到线程并执行
    
    std::cout << fut.get() << "\n";  // 输出 7
    t.join();
}
```

**何时用 packaged_task？**
- 在线程池中分发任务时
- 需要手动管理线程和任务的关联时

### 5.6 std::shared_future：多个等待者

**普通 future 只能调用一次 `get()`**，但有时多个线程都需要等待同一个结果。

```cpp
std::shared_future<int> sfut = fut.share();
// 或者直接从 promise 获取
std::future<int> fut = prom.get_future();
std::shared_future<int> sfut(fut.share());

// shared_future 可以复制，多个线程各自调用 get()
```

---

## 6. 线程局部存储 (thread_local)

### 6.1 什么是线程局部存储？

**线程局部存储（Thread-Local Storage, TLS）** 为每个线程提供独立的变量副本。不同线程访问同一个 `thread_local` 变量，实际上访问的是各自线程的副本，互不干扰。

```cpp
thread_local int thread_id = 0;  // 每个线程有自己的 thread_id

void worker() {
    thread_id = std::hash<std::thread::id>{}(std::this_thread::get_id());
    std::cout << "Worker thread_id: " << thread_id << "\n";
    // 这里读写的是当前线程的副本
}

int main() {
    thread_id = 42;  // 主线程的 thread_id 是 42
    
    std::thread t1(worker);
    std::thread t2(worker);
    
    t1.join();
    t2.join();
    
    std::cout << "Main thread_id: " << thread_id << "\n";  // 输出 42
    // t1 和 t2 的 thread_id 是各自的值，与主线程无关
}
```

### 6.2 与普通全局变量的区别

| 特性 | 普通全局变量 | thread_local 变量 |
|------|-------------|------------------|
| 存储位置 | 所有线程共享同一份 | 每个线程有独立副本 |
| 线程间干扰 | 可能，需要加锁保护 | 不需要，天然线程安全 |
| 生命周期 | 程序启动到结束 | 线程启动到结束 |

### 6.3 常见应用场景

1. **线程安全的日志记录器**
```cpp
thread_local std::ostringstream log_buffer;
// 每个线程有自己的日志缓冲区，最后统一写出
```

2. **每个线程的缓存**
```cpp
thread_local std::unordered_map<int, std::string> cache;
// 不同线程缓存不同数据，互不干扰
```

3. **线程相关的配置**
```cpp
thread_local int max_retry = 3;  // 不同线程可以设置不同的重试次数
```

4. **随机数生成器（线程安全）**
```cpp
thread_local std::mt19937 rng(std::random_device{}());
// 每个线程有自己的随机数生成器，避免锁竞争
```

---

## 7. 原子操作 (atomic)

### 7.1 什么是原子操作？为什么需要它？

**原子操作**是不可中断的操作——在执行过程中不会被其他线程干扰，要么完全执行，要么完全不执行，不存在"执行到一半"的状态。

**为什么比锁更好？**
- 更简洁：不需要 `lock()` / `unlock()`
- 更高效：直接硬件指令，无锁竞争
- 更安全：不会有死锁

**对比**：
```cpp
// 用锁的方式
std::mutex mtx;
int counter = 0;

void increment() {
    std::lock_guard<std::mutex> lock(mtx);
    ++counter;  // 安全但有开销
}

// 用原子操作的方式
std::atomic<int> counter{0};

void increment() {
    counter.fetch_add(1);  // 同样安全，更高效
}
```
### 7.2 基本类型 `std::atomic<T>`

C++ 提供了一系列原子类型，最常用的是 `std::atomic<T>`：

```cpp
#include <atomic>

std::atomic<int> counter{0};           // 原子整数
std::atomic<bool> flag{false};          // 原子布尔
std::atomic<std::uint64_t> big_num{0};  // 原子大整数

// 基本操作
counter.store(10);           // 原子写入
int val = counter.load();    // 原子读取
counter.fetch_add(1);         // 原子加法，返回原值
counter.fetch_sub(1);         // 原子减法
counter.exchange(42);         // 原子交换，返回旧值

// 简化的运算符形式
counter++;                   // 等价于 fetch_add(1)
counter += 5;                // 等价于 fetch_add(5)
```

### 7.3 常用原子操作一览

| 操作 | 用法 | 说明 |
|------|------|------|
| `load()` | `val = counter.load()` | 原子读取当前值 |
| `store(val)` | `counter.store(val)` | 原子写入新值 |
| `fetch_add(val)` | `old = counter.fetch_add(1)` | 原子加 val，返回**加前的值** |
| `fetch_sub(val)` | `old = counter.fetch_sub(1)` | 原子减 val，返回**减前的值** |
| `fetch_and(val)` | `old = counter.fetch_and(mask)` | 原子按位与 |
| `fetch_or(val)` | `old = counter.fetch_or(mask)` | 原子按位或 |
| `exchange(val)` | `old = counter.exchange(42)` | 原子交换，总是返回旧值 |
| `compare_exchange_weak()` | CAS 弱版本 | 条件原子交换 |
| `compare_exchange_strong()` | CAS 强版本 | 条件原子交换 |

### 7.4 什么是 CAS？比较并交换

**CAS（Compare-And-Swap）** 是一种重要的原子操作，用于实现无锁数据结构。

```cpp
// compare_exchange_weak 的语义：
// 如果当前值 == expected，则把当前值设置为 desired，返回 true
// 否则，把 expected 设置为当前值，返回 false

int expected = 10;
int desired = 20;

// 如果 counter 当前是 10，把它改成 20
// 如果不是 10，expected 会变成 counter 的当前值
bool success = counter.compare_exchange_weak(expected, desired);

if (success) {
    // 交换成功，counter 现在是 20
} else {
    // 交换失败，expected 现在是 counter 的当前值
    // 可以重试
}
```

**弱版本 vs 强版本**：
- `weak`：可能"假失败"（即使相等也返回 false），但性能更好；适合在循环中使用
- `strong`：保证不假失败，但性能稍差；适合单次尝试

### 7.5 内存序（Memory Order）：最核心也最复杂的概念

**什么是内存序？** 它决定了原子操作如何影响其他线程对内存的可见性和排序。

**为什么需要关心？** 现代CPU和编译器会进行各种优化（指令重排、缓存），内存序定义了"什么样的重排是允许的"。

#### 六种内存序

| 内存序 | 说明 | 适用场景 |
|--------|------|----------|
| `memory_order_seq_cst` | 顺序一致性（最强） | 默认值，最安全但效率最低 |
| `memory_order_acquire` | 获取屏障 | 读取操作，确保之前的写入对当前线程可见 |
| `memory_order_release` | 释放屏障 | 写入操作，确保当前的写入对后续读取可见 |
| `memory_order_consume` | 只对依赖项 | 更宽松的 acquire，性能更好 |
| `memory_order_relaxed` | 完全宽松 | 只保证原子性，不保证可见性和顺序 |
| `memory_order_acq_rel` | 获取+释放 | 读-改-写操作 |

#### 图解三种常用模式

**1. 顺序一致性（seq_cst）**：
```
线程A: store(x=1, seq_cst) → store(y=1, seq_cst)
线程B: load(y) → load(x)
结果：线程B看到的写入顺序与A一致
```

**2. Release-Acquire（生产者-消费者）**：
```cpp
// 生产者
data = 42;
flag.store(true, std::memory_order_release);  // 释放屏障：确保 data 写入在 flag 之前

// 消费者
while (!flag.load(std::memory_order_acquire)) {  // 获取屏障：确保看到 flag 时也看到 data
    std::this_thread::yield();
}
assert(data == 42);  // 一定能读到 42
```

**3. Relaxed（只保证原子性）**：
```cpp
counter.fetch_add(1, std::memory_order_relaxed);  // 只保证 counter 本身是原子的
// 不保证操作之间的顺序，不保证对其他线程立即可见
// 适用于：计数器、统计等不依赖其他变量的场景
```

#### 选择建议

**除非明确知道自己在做什么，否则使用默认的 `seq_cst`**：
```cpp
counter.fetch_add(1);  // 使用默认的顺序一致性
```

只有当你：
1. 分析出这是性能瓶颈
2. 理解了各种内存序的含义
3. 有 benchmark 数据支持

才考虑使用更宽松的内存序。

---

## 8. 线程安全设计模式

### 8.1 为什么要设计模式？

多线程编程有很多常见场景（生产消费、读写分离等），前辈们总结出了一些经过验证的设计模式。遵循这些模式可以避免常见错误，让代码更清晰。

### 8.2 模式一：保护共享数据

**核心思想**：把共享数据的访问都封装起来，用 mutex 保护。

```cpp
class ThreadSafeCounter {
private:
    int value = 0;                          // 共享数据
    mutable std::mutex mtx;                   // mutable：const 方法也需要加锁

public:
    // 读取操作：加锁保护
    int get() const {
        std::lock_guard<std::mutex> lock(mtx);
        return value;
    }
    
    // 写入操作：加锁保护
    void increment() {
        std::lock_guard<std::mutex> lock(mtx);
        ++value;
    }
    
    void reset() {
        std::lock_guard<std::mutex> lock(mtx);
        value = 0;
    }
};
```

**要点**：
- 把 mutex 作为类的成员变量
- 所有访问共享数据的方法都要加锁
- mutex 也要 mutable，因为 const 方法（getter）也需要加锁

### 8.3 模式二：线程安全的单例（Double-Checked Locking）

**单例模式**：确保一个类只有一个实例，并且全局可访问。

```cpp
class Singleton {
private:
    Singleton() = default;  // 私有构造函数

public:
    // ❌ 普通的 getInstance 不安全
    static Singleton* bad_get() {
        // 两个线程可能同时通过第一个检查，都创建实例
        static Singleton* instance = new Singleton();
        return instance;
    }
    
    // ✅ 双重检查锁定（DCLP）
    static Singleton* get() {
        // 第一次检查：快速路径，大多数情况下直接返回
        Singleton* tmp = instance.load(std::memory_order_acquire);
        if (!tmp) {
            // 第二次检查：加锁后再次确认
            std::lock_guard<std::mutex> lock(mtx);
            tmp = instance.load();
            if (!tmp) {
                tmp = new Singleton();
                instance.store(tmp, std::memory_order_release);
            }
        }
        return tmp;
    }
};
```

**DCLP 的原理**：
- 第一次检查不加锁：大多数情况下实例已创建，直接返回（快速路径）
- 第二次检查加锁：确保只有一个线程创建实例
- 内存序：确保正确初始化和发布

### 8.4 模式三：生产者-消费者

**场景**：一个线程生产数据，另一个线程消费数据。数据通过队列传递。

```cpp
template<typename T>
class SafeQueue {
private:
    std::queue<T> q;
    std::mutex mtx;
    std::condition_variable cv;

public:
    // 生产者：放入数据，通知消费者
    void push(T val) {
        {
            std::lock_guard<std::mutex> lock(mtx);
            q.push(std::move(val));
        }
        cv.notify_one();  // 通知等待中的消费者
    }
    
    // 消费者：取出数据，可能需要等待
    T pop() {
        std::unique_lock<std::mutex> lock(mtx);
        // 等待直到队列非空
        cv.wait(lock, [this]{ return !q.empty(); });
        
        T val = std::move(q.front());
        q.pop();
        return val;
    }
};
```

**流程**：
1. 生产者获取锁，放入数据，释放锁，通知消费者
2. 消费者获取锁，检查队列是否为空
3. 如果为空，释放锁并阻塞等待
4. 被通知后重新获取锁，取出数据

### 8.5 模式四：读写锁（读多写少场景）

**场景**：读操作可以并发，写操作必须独占。

```cpp
#include <shared_mutex>

class ReadWriteBuffer {
private:
    std::vector<int> data;
    mutable std::shared_mutex mtx;  // 读写锁

public:
    // 写操作：独占锁
    void write(int val) {
        std::unique_lock<std::shared_mutex> lock(mtx);  // 独占锁
        data.push_back(val);
    }
    
    // 读操作：共享锁
    int read(size_t idx) const {
        std::shared_lock<std::shared_mutex> lock(mtx);  // 共享锁
        return data[idx];
    }
};
```

**锁的类型**：
- `unique_lock<shared_mutex>`：写锁，独占访问
- `shared_lock<shared_mutex>`：读锁，多个读可以同时进行

**性能分析**：
- 如果大部分是读操作，shared_mutex 比普通 mutex 效率高
- 如果写操作多，普通 mutex 可能更好（避免读锁开销）

---

## 9. 常见问题与最佳实践

### 9.1 常见错误汇总

| 错误 | 后果 | 解决方案 |
|------|------|----------|
| 未 join/detach 就销毁 thread | 程序终止 | 使用 join()，或使用 RAII 包装器 |
| 死锁（循环等待） | 线程卡死 | 固定加锁顺序，使用 std::lock |
| 数据竞争 | 未定义行为（结果随机） | 使用 mutex 或 atomic |
| 使用已销毁对象的锁 | 未定义行为 | 确保锁生命周期覆盖所有使用者 |
| 引用捕获到 lambda 后线程仍运行 | 悬空引用，程序崩溃 | 使用值捕获或 move，或者用 promise 传递结果 |
| 忘记 notify | 线程永远等待 | 生产者操作后记得 notify |
| 虚假唤醒导致越界 | 程序崩溃 | 使用 wait(predicate) 形式 |

### 9.2 最佳实践清单

1. **优先使用 RAII**：`lock_guard` / `unique_lock` 自动释放锁，异常安全
   ```cpp
   // ✅ 异常安全
   void process() {
       std::lock_guard<std::mutex> lock(mtx);
       do_something();  // 如果这里抛异常，锁也会正确释放
   }
   
   // ❌ 危险
   void process() {
       mtx.lock();
       do_something();  // 如果这里抛异常，unlock() 永远不会执行
       mtx.unlock();
   }
   ```

2. **减少锁粒度**：只锁必要区域，尽快释放
   ```cpp
   // ✅ 好：锁的范围小
   void process(Item& item) {
       mtx.lock();
       item.prepare();
       mtx.unlock();
       item.compute();  // 不需要锁的操作放在外面
       mtx.lock();
       item.save();
       mtx.unlock();
   }
   ```

3. **避免死锁**：固定加锁顺序，或使用 `std::lock`
   ```cpp
   // ✅ 所有地方按同样顺序加锁
   // 或者使用 std::lock(mtx1, mtx2) 一次性获取
   ```

4. **优先使用 atomic**：简单操作无需锁
   ```cpp
   // ✅ 简单计数器用 atomic
   std::atomic<int> counter{0};
   counter++;
   ```

5. **使用 async**：简单任务优先用 `std::async`
   ```cpp
   // ✅ 比手动创建线程更简洁
   std::future<int> fut = std::async(std::launch::async, compute, data);
   ```

6. **线程数选择**：
   - **CPU 密集型**（计算为主）：线程数 ≈ CPU 核心数
   - **I/O 密集型**（等待为主）：线程数 > CPU 核心数（因为等待时可以让出CPU）

7. **避免全局锁**：考虑 `shared_mutex` 或无锁结构

8. **使用 `thread_local`** 保存线程私有数据，减少同步需求

### 9.3 线程池模式

**什么是线程池？** 预先创建一组线程，重复利用它们执行任务，避免频繁创建销毁线程的开销。

```cpp
class ThreadPool {
    std::vector<std::thread> workers;                         // 工作线程列表
    std::queue<std::function<void()>> tasks;                   // 任务队列
    std::mutex mtx;                                            // 保护任务队列
    std::condition_variable cv;                                // 条件变量
    bool stop = false;                                         // 停止标志

public:
    explicit ThreadPool(size_t n) {
        for (size_t i = 0; i < n; ++i) {
            workers.emplace_back([this] {
                while (true) {
                    std::function<void()> task;
                    {
                        std::unique_lock<std::mutex> lock(mtx);
                        // 等待任务或停止信号
                        cv.wait(lock, [this]{ return stop || !tasks.empty(); });
                        
                        if (stop && tasks.empty()) return;
                        task = std::move(tasks.front());
                        tasks.pop();
                    }
                    task();  // 执行任务（不在锁内）
                }
            });
        }
    }
    
    template<typename F>
    void enqueue(F&& f) {
        {
            std::unique_lock<std::mutex> lock(mtx);
            tasks.emplace(std::forward<F>(f));
        }
        cv.notify_one();  // 通知一个工作线程
    }
    
    ~ThreadPool() {
        {
            std::unique_lock<std::mutex> lock(mtx);
            stop = true;
        }
        cv.notify_all();  // 通知所有线程退出
        for (auto& w : workers) w.join();
    }
};
```

**使用示例**：
```cpp
ThreadPool pool(4);  // 创建4个线程的池

pool.enqueue([]{ std::cout << "Task 1\n"; });
pool.enqueue([]{ std::cout << "Task 2\n"; });
pool.enqueue([]{ std::cout << "Task 3\n"; });
// 任务被分发到4个线程执行
// pool 销毁时，所有线程正确退出
```

---

## 附录：术语表

| 英文术语 | 中文术语 | 简要说明 |
|---------|---------|---------|
| Thread | 线程 | 程序执行的最小单位 |
| Process | 进程 | 程序的一次执行实例，有独立地址空间 |
| Mutex | 互斥锁 | 保证同一时刻只有一个线程访问资源 |
| Lock | 锁 | mutex 的操作接口 |
| Deadlock | 死锁 | 多个线程互相等待对方持有的锁 |
| Livelock | 活锁 | 线程在运行但无法取得进展 |
| Data Race | 数据竞争 | 多个线程同时访问共享资源，至少一个写操作 |
| Race Condition | 竞态条件 | 程序结果依赖执行时序 |
| Condition Variable | 条件变量 | 线程同步机制，用于等待特定条件 |
| Future | Future | 代表异步操作结果的占位符 |
| Promise | Promise | 用于在线程间传递值 |
| Atomic | 原子操作 | 不可分割的操作，不会被其他线程干扰 |
| Memory Order | 内存序 | 控制编译器和CPU对内存访问的重排 |
| RAII | 资源获取即初始化 | 用对象管理资源生命周期 |
| Thread Pool | 线程池 | 预先创建线程，复用执行任务 |
| TLS | 线程局部存储 | 每个线程独立的变量副本 |
