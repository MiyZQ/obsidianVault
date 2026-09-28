引入库`<bitset>`
bitset类似一个字符数组，由二进制低位向高位排列：b0、b1、...，因此按bi的顺序依次输出与直接输出b的结果相反

- **声明**：
	`bitset <n> b;`，n表示二进制位数，初始均为0：
	`bitset <n> b(m)`，m为unsigned int类型，得到m二进制数组，如m=1，n=3得到b为001
	`bitset <n> b(s)`，s为二进制字符串，如s="1101"，n=6得到b为001101
	`bitset <n> b(s,pos,n)`，表示从s\[pos]开始读取n位长度

- **类函数运算**：
	`b.any()`    b是否含有1的二进制位
	`b.none()`   b是否不含有1的二进制位
	`b.count()`  b中1进制位的个数
	`b.size()`     b中元素个数，即长度
	`b.test(i)`    b索引为i处是否为1
	`b.set(i)`     b索引为i处设置为1
	`b.reset()`   将b所有位归零，若含参数i表示将索引i处归零
	`b.flip()`      b所有位取反
	`unsigned long a=b.to_long()`   转换为unsigned long类型