
> [!NOTE]
> 1. 使用 twinx() 来实现双 Y 轴：
> `ax2=ax1.twinx()` 新建 Axes 对象强制绑定 x 轴，其 y 轴放到画布右侧
> 2. tick_params（） 用于修改 y 轴刻度的颜色
> 3. 调用 legend() 不能在单独每一轴上使用，而是需要先合并线对象 `lines=l1+l2` 再得到标签 `labels`，最后调用 `ax1.legend(lines,labels)`
> 4. **扩展：** 使用 twiny() 可以共享 Y 轴来实现双 X 轴（位于上下）

```python
import matplotlib.pyplot as plt
import numpy as np
plt.rcParams["font.family"] = ["Microsoft YaHei"]

# 有机玻璃
t_organic = np.array([0, 30, 90, 150, 210, 270, 330, 390, 450, 510, 570, 630, 690])
deltaT_organic = np.array([0.15, 2.575, 3.100, 3.250, 3.250, 3.200, 3.150, 3.075, 3.075, 3.050, 3.025, 2.975, 2.950])
T_organic = np.array([-1.35, -2.575, -2.025, -1.500, -0.925, -0.425, 0.025, 0.500, 1.000, 1.475, 1.950, 2.400, 2.825])

# 橡胶
t_rubber = np.array([0, 30, 90, 150, 210, 270, 330, 390, 450, 510, 570, 630, 690])
deltaT_rubber = np.array([0.100, 0.650, 1.150, 1.350, 1.400, 1.425, 1.450, 1.425, 1.425, 1.425, 1.425, 1.400, 1.400])
T_rubber = np.array([-1.225, -1.250, -0.950, -0.550, -0.125, 0.250, 0.675, 1.100, 1.525, 1.975, 2.400, 2.775, 3.200])

def plot_dual(t, dt, T, title):
    fig, ax1 = plt.subplots(figsize=(9, 6), dpi=120)

    # 左轴 温差ΔT
    ax1.set_xlabel("加热时间 t/s")
    ax1.set_ylabel("温差 ΔT/K")
    l1 = ax1.plot(t, dt, "ro-", label="ΔT")
    ax1.tick_params(axis="y", labelcolor="r")
    ax1.grid(alpha=0.3)

    # 右轴 中心面温度T
    ax2 = ax1.twinx()
    ax2.set_ylabel("中心面温度 ΔT/K")
    l2 = ax2.plot(t, T, "bD--", label="T")
    ax2.tick_params(axis="y", labelcolor="b")
    ax2.grid(alpha=0.3)

    # 图例合并
    lines = l1 + l2
    labels = [line.get_label() for line in lines]
    ax1.legend(lines, labels, loc="upper left")
    plt.title(title)
    plt.tight_layout()

    return fig

fig_organic = plot_dual(
    t_organic, deltaT_organic, T_organic, "有机玻璃：温差、中心面温度与加热时间关系"
)
fig_rubber = plot_dual(
    t_rubber, deltaT_rubber, T_rubber, "橡胶：温差、中心面温度与加热时间关系"
)
plt.show()
```