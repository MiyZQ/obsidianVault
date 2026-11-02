
### 力学方程建模

> [!NOTE] 质点抛体运动
> 质量为 $m$ 的质点从原点以速度 $v_0=(v_{0x},v_{0y})$ 抛出，重力加速度为 $g$，空气阻力系数为 $k$

可列运动方程$$
\begin{cases}
m\ddot{x}=-k\dot{x} \\
m\ddot{y}=-mg-k\dot{y}
\end{cases}
$$
初始条件$$
x(0)=0,y(0)=0,\dot{x}(0)=v_{0x},\dot{y}(0)=v_{0y}
$$
```python
import sympy as sp
sp.init_printing(use_unicode=True)
# 符号定义
t,m,g,k,v_0x,v_0y = sp.symbols('t m g k v_0x v_0y',real=True,positive=True)
x = sp.Function('x')(t)
y = sp.Function('y')(t)
# ODE
eq_x = sp.Eq(m*sp.diff(x,t,2),-k*sp.diff(x,t))
eq_y = sp.Eq(m*sp.diff(y,t,2),-m*g-k*sp.diff(y,t))
# 初始条件
ics_x = {
    x.subs(t,0): 0,
    sp.diff(x,t).subs(t,0): v_0x
}
ics_y = {
    y.subs(t,0): 0,
    sp.diff(y,t).subs(t,0): v_0y
}
# 求解
sol_x = sp.dsolve(eq_x,x,ics=ics_x)
sol_y = sp.dsolve(eq_y,y,ics=ics_y)
# 打印
sp.pprint(sol_x)
sp.pprint(sol_y)
```
> 也可以转成 LaTeX，使用 `sp.latex(sol_x)` 再打印

### Lagrange 力学建模


> [!NOTE] 弹簧、滑块、单摆耦合系统
> 光滑水平面上质量为 $M$ 的滑块左端连接劲度系数为 $k$ 的水平弹簧，弹簧原长时滑块在原点；
> 滑块铰接长为 $l$ 的轻杆，杆末端固定有质量为 $m$ 的小球，杆和小球在竖直面中运动

定义广义坐标
	$x(t)$ 为滑块相对原点的平移
	$\theta(t)$ 为杆与竖直向下的夹角

Lagrange 力学量 $L=T-V$，列出方程
$$
\dfrac{\text{d}}{\text{d}t}\left(\dfrac{\partial L}{\partial\dot{\theta}}\right)-\dfrac{\partial L}{\partial\theta}=0
$$
动能 $T=T_\text{滑块}+T_\text{小球}$
势能 $V=V_\text{弹簧}+V_\text{小球}$
将广义坐标代入上面方程计算

```python
import sympy as sp
sp.init_printing(use_unicode=True)

# 符号定义
t,M,m,g,l,k = sp.symbols('t M m g l k',real=True,positive=True)
x = sp.Function('x')(t)
theta = sp.Function('theta')(t)
# 小球直角坐标
x_m = x + l*sp.sin(theta)
y_m = -l*sp.cos(theta)
# 速度分量
v_M = sp.diff(x,t)
v_mx = sp.diff(x_m,t)
v_my = sp.diff(y_m,t)
# Lagrange 量
T = sp.Rational(1,2)*M*v_M**2 + sp.Rational(1,2)*m*(v_mx**2+v_my**2)
V = sp.Rational(1,2)*k*x**2 + m*g*y_m
L = T-V
# Lagrange 方程
def lagrange_eq(L,q):
    L_q = L.diff(q)
    L_qdot = L.diff(q.diff(t))
    return sp.simplify(sp.Eq(L_qdot.diff(t)-L_q,0))
eq_x = lagrange_eq(L,x)
eq_theta = lagrange_eq(L,theta)
# 打印
sp.pprint(eq_x)
sp.pprint(eq_theta)
```

下面使用 Scipy 进行数值模拟，用到：
	scipy.integrate.solve_ivp 数值求解
	matplotlib 绘图

**数值求解：**
```python
import scipy
import numpy as np
from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt

# 将 Derivative 对象、函数对象全替换为形式符号，解出 x'' 、 theta''
xdot, thetadot     = sp.symbols(r"\dot{x} \dot{\theta}", real=True)
xddot, thetaddot   = sp.symbols(r"\ddot{x} \ddot{\theta}", real=True)

deriv_subs = {
    sp.Derivative(x,     (t, 2)): xddot,
    sp.Derivative(theta, (t, 2)): thetaddot,
    sp.Derivative(x,     t):      xdot,
    sp.Derivative(theta, t):      thetadot,
}

eq_x_s     = eq_x.subs(deriv_subs)
eq_theta_s = eq_theta.subs(deriv_subs)

sol = sp.solve([eq_x_s, eq_theta_s], [xddot, thetaddot], dict=True)[0]
xddot_expr     = sp.simplify(sol[xddot])
thetaddot_expr = sp.simplify(sol[thetaddot])

x_old, theta_old = x, theta
x, theta = sp.symbols('x theta', real=True)
func_subs = {x_old: x, theta_old: theta}

xddot_expr     = xddot_expr.subs(func_subs)
thetaddot_expr = thetaddot_expr.subs(func_subs)

# 转移到 scipy，使用状态向量 y
y = (t,x,xdot,theta,thetadot,M,m,g,l,k)
xddot_func = sp.lambdify(y,xddot_expr)
thetaddot_func = sp.lambdify(y,thetaddot_expr)

# 设定初始值与常量
def cst_func(M=1,m=0.2,g=9.8,l=1,k=10):
    return {
        'M': M,
        'm': m,
        'g': g,
        'l': l,
        'k': k
    }
    
def ics_func(t_span=(0,30),state=[0,0,np.pi/4,0],*args,**kwargs):
    return {
        't_span': t_span,
        'y0': state,
        't_eval': np.linspace(*t_span,1000),
        'args': tuple(cst_func(*args,**kwargs).values()),
        'method': 'Radau'
    }

# 数值求解
def ode(t,state,M,m,g,l,k):
    x,xdot,theta,thetadot = state
    xddot = xddot_func(t,x,xdot,theta,thetadot,M,m,g,l,k)
    thetaddot = thetaddot_func(t,x,xdot,theta,thetadot,M,m,g,l,k)
    return [xdot,xddot,thetadot,thetaddot]

all = {
    't_span': (0,30),
    'state': [0,0,np.pi/4,0],
    'M': 1,
    'm': 0.2,
    'g': 9.8,
    'l': 1,
    'k': 10
}

ics = ics_func(**all)
sol = solve_ivp(fun=ode,**ics)
```

> [!Attention] 
> 在转为 Scipy 前，必须把 Sympy 解出的 ODE 解中所有 Derivative 对象、Function 对象全替换为形式符号，否则 lambdify 函数解析会有问题

**绘图：**
```python
plt.rcParams['figure.dpi'] = 120
plt.rcParams["font.family"] = ["SimHei", "Microsoft YaHei"]
plt.rcParams["axes.unicode_minus"] = False

def set_ax(ax):
    ax.set_xlabel('t(s)')
    ax.grid(True)
    ax.legend()

fig,axes = plt.subplots(2,1,figsize=(12,8))
ax1 = axes[0]
ax2 = axes[1]

ax1.plot(ics['t_eval'],sol.y[0],label='$x(t)$')
ax2.plot(ics['t_eval'],sol.y[2],label=r'$\theta(t)$')

set_ax(ax1)
set_ax(ax2)

ax1.set_title('滑块位移 $x(t)$')
ax1.set_ylabel('x(m)')

ax2.set_title(r'摆角 $\theta(t)$')
ax2.set_ylabel(r'$\theta$(rad)')

line1 = r"$" + sp.latex(eq_x) + r"$"
line2 = r"$" + sp.latex(eq_theta) + r"$"
txt = line1 + "\n" + line2

ax2.text(0.02, -0.32, txt, 
transform=ax2.transAxes, bbox=dict(boxstyle="round",fc="white",alpha=0.7), ha="left")

plt.tight_layout()
plt.subplots_adjust(bottom=0.15)
plt.show()
```
