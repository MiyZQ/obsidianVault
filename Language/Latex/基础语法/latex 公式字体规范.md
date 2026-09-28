
### 正、斜体区分

通常表示==微分==的 $\mathrm{d}x$ 应该使用*正体* 即罗马体，latex 代码为

```latex
$\mathrm{d}x$
```

表示==常数==的 e、i、j，===函数名===，==运算符==应该使用*正体*，如：

$\mathrm{e}^{\mathrm{i}\theta}=\cos\theta+\mathrm{i}\sin\theta$ 的 latex 代码为

```latex
$\mathrm{e}^{\mathrm{i}\theta}=\cos\theta+\mathrm{i}\sin\theta$
```

> [!NOTE]
> 包括 sin、cos 这些函数使用正体，`\cos` 相当于 `\mathrm{cos}`

所有的==未知变量== $x,y,t,v$ 等，==角度符号== $\theta,\alpha,\beta,\phi$ 等，==物理标量== $力F,速度v,质量m$ 等都应使用默认的*斜体*

### 物理量的单位

表示物理量的单位时，应使用 siunitx 包的 `\SI{}{}` 命令，使用*正体*

如电荷值的 latex 代码为

```latex
$e=\SI{1.6e-19}{\coulomb}$ 
```

某个面电荷密度表示为

```latex
$\rho_\mathrm{s}=\SI{2e2}{\micro\coulomb\cdot\metre^{-2}}$
```

### 粗正体、粗斜体区分

==矩阵==、==向量==通常使用*粗正体*，如 $\mathbf{Ax}=\mathbf{b}$ 的 latex 代码为

```latex
$\mathbf{Ax}=\mathbf{b}$
```

有时国内可能用*粗斜体* $\boldsymbol{Ax}=\boldsymbol{b}$，其代码为

```latex
$\boldsymbol{Ax}=\boldsymbol{b}$
```

表示==矢量角度==、==物理矢量==时使用*粗斜体*，如 $\boldsymbol{\theta}$、$力\boldsymbol{F}$

### 下标

如果下标表示==文字/含义==使用*正体*；表示==变量/序号==使用*斜体*

正体如相对介电常数 $\varepsilon_\mathrm{r}$ 的 latex 代码为

```latex
$\varepsilon_\mathrm{r}$
```

以及表示初态、末态 $v_\mathrm{0},v_\mathrm{t}$

```latex
$v_\mathrm{0},v_\mathrm{t}$
```

斜体如速度分量 $v_x,v_y,v_z$

```latex
$v_x,v_y,v_z$
```

以及序号 $x_i,\alpha_n$

```latex
$x_i,\alpha_n$
```

### 希腊字母

1. 普通变量默认斜体希腊
2. 特殊函数/算子一般用\var
3. 物理的粒子/常量等用\mathrm{ }，注意*大写希腊默认正体*

#### 小写表
$$\begin{align*}
\alpha,\beta,\gamma,\delta,\epsilon,\varepsilon,\zeta,\eta,\theta,\vartheta,\iota,\kappa,\varkappa,\lambda,\mu,\nu \\ \xi,\omicron,\pi,\varpi,\rho,\varrho,\sigma,\varsigma,\tau,\upsilon,\phi,\varphi,\chi,\psi,\omega
\end{align*}$$
```latex
\alpha,\beta,\gamma,\delta,\epsilon,\varepsilon,\zeta,\eta,\theta,\vartheta,\iota,\kappa,\varkappa,\lambda,\mu,\nu,\xi,\omicron,\pi,\varpi,\rho,\varrho,\sigma,\varsigma,\tau,\upsilon,\phi,\varphi,\chi,\psi,\omega
```

#### 大写表
$$
\Gamma,\varGamma,\Delta,\varDelta,\Theta,\varTheta,\Lambda,\varLambda,\Xi,\varXi,\Pi,\varPi,\Sigma,\varSigma,\Upsilon,\varUpsilon,\Phi,\varPhi,\Psi,\varPsi,\Omega,\varOmega
$$
```latex
\Gamma,\varGamma,\Delta,\varDelta,\Theta,\varTheta,\Lambda,\varLambda,\Xi,\varXi,\Pi,\varPi,\Sigma,\varSigma,\Upsilon,\varUpsilon,\Phi,\varPhi,\Psi,\varPsi,\Omega,\varOmega
```
