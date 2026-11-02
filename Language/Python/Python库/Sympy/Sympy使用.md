## Symbolic Computation

We can use `symbols()` to symbolize our variables

Aside from obvious simplifications like $x-x=0$ and $\sqrt{8}=2\sqrt{2}$, most simplifications are not performed automatically


```python
import sympy
sympy.sqrt(88)
```




$\displaystyle 2 \sqrt{22}$




```python
from sympy import symbols
x,y = symbols('x y')
expr = sympy.sin(x) + sympy.exp(y)
expr * sympy.cos(x*y)
```




$\displaystyle \left(e^{y} + \sin{\left(x \right)}\right) \cos{\left(x y \right)}$



We can use *expand*,*factor* to expand our expression or do factorization


```python
from sympy import expand,factor
expr_ep = expand(expr*sympy.cos(x*y))
expr_ep,factor(expr_ep)
```




$(exp(y)*cos(x*y) + sin(x)*cos(x*y), (exp(y) + sin(x))*cos(x*y))$



This will make all further examples pretty print with unicode characters


```python
from sympy import *
init_printing(use_unicode=True)
```

Take the derivative


```python
expr = sin(x) * exp(-2*x) / log(x)
diff(expr)
```




$\displaystyle - \frac{2 e^{- 2 x} \sin{\left(x \right)}}{\log{\left(x \right)}} + \frac{e^{- 2 x} \cos{\left(x \right)}}{\log{\left(x \right)}} - \frac{e^{- 2 x} \sin{\left(x \right)}}{x \log{\left(x \right)}^{2}}$



Compute the integral


```python
integrate(expr*log(x))
```




$\displaystyle - \frac{2 e^{- 2 x} \sin{\left(x \right)}}{5} - \frac{e^{- 2 x} \cos{\left(x \right)}}{5}$



Compute the definite intergral


```python
integrate(sin(x**2),(x,-oo,oo))
```




$\displaystyle \frac{\sqrt{2} \sqrt{\pi}}{2}$



Compute the limit


```python
limit(sin(x)/x,x,0)
```




$\displaystyle 1$



Solve the equation $x^2+1=0$


```python
solve(x**2+1,x)
```




$\displaystyle \left[ - i, \  i\right]$



Solve the differential equation $y^{''}-y=\text{e}^t$


```python
y = Function('y')
t = symbols('t')
dsolve(Eq(y(t).diff(t,2) - y(t),exp(t)),y(t))
```




$\displaystyle y{\left(t \right)} = C_{2} e^{- t} + \left(C_{1} + \frac{t}{2}\right) e^{t}$



Get the eigenvalues of matrix


```python
Matrix([[1,2],[2,2]]).eigenvals()
```




$\displaystyle \left\{ \frac{3}{2} - \frac{\sqrt{17}}{2} : 1, \  \frac{3}{2} + \frac{\sqrt{17}}{2} : 1\right\}$



Rewrite the Bessel function $J_\nu(z)$ in terms of the spherical Bessel function $j_\nu(z)$


```python
z,nu = symbols('z nu')
besselj(nu,z).rewrite(jn)
```




$\displaystyle \frac{\sqrt{2} \sqrt{z} j_{\nu - \frac{1}{2}}\left(z\right)}{\sqrt{\pi}}$



Print Sympy expression using LaTeX


```python
latex(integrate(cos(x)**2,(x,0,pi)))
```




    '\\frac{\\pi}{2}'




```python
latex(Integral(cos(x)**2,(x,0,pi)))
```




    '\\int\\limits_{0}^{\\pi} \\cos^{2}{\\left(x \\right)}\\, dx'



## Gotchas
To change the value of a Symbol in an expression, use `subs()`


```python
expr = x + 1
expr.subs(x,y(t))
```




$\displaystyle y{\left(t \right)} + 1$



Suppose we want to know if $(x+1)^2=x^2+2x+1$,We might try something like this


```python
a = (x+1)**2
b = x**2 + 2*x + 1
simplify(a-b)
```




$\displaystyle 0$




```python
a.equals(b)
```




    True



To create symbolic equalities


```python
Eq(a,1)
```




$\displaystyle \left(x + 1\right)^{2} = 1$



When come up to number division,use `Rational()` function


```python
x + Rational(1,2)
```




$\displaystyle x + \frac{1}{2}$



We use expand_trig function to further simplify our expression by some Math formula


```python
expr = sin(3*x) + cos(5*x)
expand_trig(expr)
```




$\displaystyle - 4 \sin^{3}{\left(x \right)} + 3 \sin{\left(x \right)} + 16 \cos^{5}{\left(x \right)} - 20 \cos^{3}{\left(x \right)} + 5 \cos{\left(x \right)}$



To perform multiple substitutions at once, pass a list of **(old, new)** pairs to subs()


```python
expr = x**3 + 4*x*t - z
expr.subs([(x,2),(t,3),(z,6)])
```




$\displaystyle 26$



Its ofen useful to combine this with a **list** comprehension tu do a large set of similar replacements all at once


```python
expr = x**4 -4*x**3 + 4*x**2 - 2*x + 3
replacements = [(x**i,t**i) for i in range(5) if i % 2 == 0]
expr.subs(replacements)
```




$\displaystyle t^{4} + 4 t^{2} - 4 x^{3} - 2 x + 3$



`sympify()` function can be used to convert strings into Sympy expressions


```python
str_expr = 'x**2 + 3*x -1/2'
expr = sympify(str_expr)
expr
```




$\displaystyle x^{2} + 3 x - \frac{1}{2}$



To evaluate a numerical expression into a floating point number, use `evalf()`


```python
expr = sqrt(8)
expr.evalf()
```




$\displaystyle 2.82842712474619$



By default, 15 digits of precision are used, but you can pass any number as the argument to `evalf()`


```python
pi.evalf(30)
```




$\displaystyle 3.14159265358979323846264338328$



We ofen use it with attribute `subs`  to compute the output of a function


```python
expr = cos(2*x)
expr.evalf(subs={x:pi})
```




$\displaystyle 1.0$



Sometimes there are roundoff errors smaller than the desired precision that remain after an expression is evaluated. Such numbers can be removed at the user’s discretion by setting the `chop` flag to True


```python
zero = cos(1)**2 + sin(1)**2 - 1
zero.evalf(),zero.evalf(chop=True)
```




$\displaystyle \left( -4.0 \cdot 10^{-124}, \  0\right)$



if you wanted to evaluate an expression at a thousand points, using SymPy would be far slower than it needs to be, especially if you only care about machine precision. Instead, you should use libraries like NumPy and SciPy

Use `lambdify()` function served as lambda function to transform SymPy expression to NumPy function or other


```python
import numpy as np
a = np.arange(10)
expr = sin(x)
f = lambdify(x,expr,'numpy')
f(a)
```




    array([ 0.        ,  0.84147098,  0.90929743,  0.14112001, -0.7568025 ,
           -0.95892427, -0.2794155 ,  0.6569866 ,  0.98935825,  0.41211849])



> **Warning**
>
> `sympify()`,`lambdify()` function use `eval()`.Dont use it on unsanitized input

To use lambdify with numerical libraries that it does not know about, pass a dictionary of {sympy_name:numerical_function} pairs 


```python
expr = sin(x)
def mySin(x):
    '''
    This is only accurate for small x
    '''
    return x
f = lambdify(x,expr,{'sin': mySin})
f(0.1)
```




$\displaystyle 0.1$



## Simplification
`simplify()` function attempts to apply all of functions doing simplification in an intelligent way to arrive at the simplest form of an expression


```python
simplify(gamma(x)/gamma(x-2))
```




$\displaystyle \left(x - 2\right) \left(x - 1\right)$



> the function gamma above is $\Gamma(x)$

### Polynomial/Rational Function Simplification

We have mentioned `factor()` and `expand()` function before.There also have `collect()`,`cancel()`,`apart()` function.

`collect()` function collects common powers of a term in an expression


```python
expr = x*t + x - 3 + 2*x**2 - z*x**2 + x**3
collect(expr,x)
```




$\displaystyle x^{3} + x^{2} \left(2 - z\right) + x \left(t + 1\right) - 3$



`cancel()` will take any rational function and put it into the standard canonical form $\frac{p}{q}$ where $p$ and $q$ are expanded polynomials with no common factors, and the leading coefficients of $p$ and $q$ do not have denominators


```python
expr = 1/x + (3*x/2 - 2)/(x-4)
expr,cancel(expr)
```




$\displaystyle \left( \frac{\frac{3 x}{2} - 2}{x - 4} + \frac{1}{x}, \  \frac{3 x^{2} - 2 x - 8}{2 x^{2} - 8 x}\right)$



`apart()` performs a partial fraction decomposition on a rational function


```python
expr = (4*x**3 + 21*x**2 + 10*x + 12)/(x**4 + 5*x**3 + 5*x**2 + 4*x)
expr,apart(expr)
```




$\displaystyle \left( \frac{4 x^{3} + 21 x^{2} + 10 x + 12}{x^{4} + 5 x^{3} + 5 x^{2} + 4 x}, \  \frac{2 x - 1}{x^{2} + x + 1} - \frac{1}{x + 4} + \frac{3}{x}\right)$



### Trigonometric Simplification
`trigsimp()` simplifies expressions using trigonometric identities


```python
trigsimp(sin(x)**4 - 2*cos(x)**2*sin(x)**2 + cos(x)**4)
```




$\displaystyle \frac{\cos{\left(4 x \right)}}{2} + \frac{1}{2}$



It also works with hyperbolic trig functions


```python
trigsimp(cosh(x)**2 + sinh(x)**2)
```




$\displaystyle \cosh{\left(2 x \right)}$



> In addtion, we mentioned `expand_trig()` function before, which tends to make trigonometric expressions larger

### Power
There are several identities of powers we should confirm

<table class="docutils align-default">
<thead>
<tr class="row-odd"><th class="head"><p>Identity</p></th>
<th class="head"><p>Sufficient conditions to hold</p></th>
<th class="head"><p>Counterexample when conditions are not met</p></th>
<th class="head"><p>Important consequences</p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><ol class="arabic simple">
<li><p><span class="math notranslate nohighlight"><mjx-container class="MathJax CtxtMenu_Attached_0" jax="CHTML" tabindex="0" ctxtmenu_counter="27" style="font-size: 113.1%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-msup><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-script style="vertical-align: 0.363em;"><mjx-mi class="mjx-i" size="s"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi></mjx-script></mjx-msup><mjx-msup><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-script style="vertical-align: 0.363em;"><mjx-mi class="mjx-i" size="s"><mjx-c class="mjx-c1D44F TEX-I"></mjx-c></mjx-mi></mjx-script></mjx-msup><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c3D"></mjx-c></mjx-mo><mjx-msup space="4"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-script style="vertical-align: 0.363em;"><mjx-texatom size="s" texclass="ORD"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c2B"></mjx-c></mjx-mo><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44F TEX-I"></mjx-c></mjx-mi></mjx-texatom></mjx-script></mjx-msup></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><msup><mi>x</mi><mi>a</mi></msup><msup><mi>x</mi><mi>b</mi></msup><mo>=</mo><msup><mi>x</mi><mrow data-mjx-texclass="ORD"><mi>a</mi><mo>+</mo><mi>b</mi></mrow></msup></math></mjx-assistive-mml></mjx-container></span></p></li>
</ol>
</td>
<td><p>Always true</p></td>
<td><p>None</p></td>
<td><p>None</p></td>
</tr>
<tr class="row-odd"><td><ol class="arabic simple" start="2">
<li><p><span class="math notranslate nohighlight"><mjx-container class="MathJax CtxtMenu_Attached_0" jax="CHTML" tabindex="0" ctxtmenu_counter="28" style="font-size: 113.1%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-msup><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-script style="vertical-align: 0.363em;"><mjx-mi class="mjx-i" size="s"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi></mjx-script></mjx-msup><mjx-msup><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-script style="vertical-align: 0.363em;"><mjx-mi class="mjx-i" size="s"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi></mjx-script></mjx-msup><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c3D"></mjx-c></mjx-mo><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c28"></mjx-c></mjx-mo><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-msup><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-script style="vertical-align: 0.363em;"><mjx-mi class="mjx-i" size="s"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi></mjx-script></mjx-msup></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><msup><mi>x</mi><mi>a</mi></msup><msup><mi>y</mi><mi>a</mi></msup><mo>=</mo><mo stretchy="false">(</mo><mi>x</mi><mi>y</mi><msup><mo stretchy="false">)</mo><mi>a</mi></msup></math></mjx-assistive-mml></mjx-container></span></p></li>
</ol>
</td>
<td><p><span class="math notranslate nohighlight"><mjx-container class="MathJax CtxtMenu_Attached_0" jax="CHTML" tabindex="0" ctxtmenu_counter="29" style="font-size: 113.1%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c2C"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="2"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c2265"></mjx-c></mjx-mo><mjx-mn class="mjx-n" space="4"><mjx-c class="mjx-c30"></mjx-c></mjx-mn></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mi>x</mi><mo>,</mo><mi>y</mi><mo>≥</mo><mn>0</mn></math></mjx-assistive-mml></mjx-container></span> and <span class="math notranslate nohighlight"><mjx-container class="MathJax CtxtMenu_Attached_0" jax="CHTML" tabindex="0" ctxtmenu_counter="30" style="font-size: 113.1%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c2208"></mjx-c></mjx-mo><mjx-texatom space="4" texclass="ORD"><mjx-mi class="mjx-ds mjx-b"><mjx-c class="mjx-c211D TEX-A"></mjx-c></mjx-mi></mjx-texatom></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mi>a</mi><mo>∈</mo><mrow data-mjx-texclass="ORD"><mi mathvariant="double-struck">R</mi></mrow></math></mjx-assistive-mml></mjx-container></span></p></td>
<td><p><span class="math notranslate nohighlight"><mjx-container class="MathJax CtxtMenu_Attached_0" jax="CHTML" tabindex="0" ctxtmenu_counter="31" style="font-size: 113.1%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo><mjx-mo class="mjx-n"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mn class="mjx-n"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-msup><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-script style="vertical-align: 0.363em;"><mjx-texatom size="s" texclass="ORD"><mjx-mn class="mjx-n"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2F"></mjx-c></mjx-mo></mjx-texatom><mjx-mn class="mjx-n"><mjx-c class="mjx-c32"></mjx-c></mjx-mn></mjx-texatom></mjx-script></mjx-msup><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo><mjx-mo class="mjx-n"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mn class="mjx-n"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-msup><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-script style="vertical-align: 0.363em;"><mjx-texatom size="s" texclass="ORD"><mjx-mn class="mjx-n"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2F"></mjx-c></mjx-mo></mjx-texatom><mjx-mn class="mjx-n"><mjx-c class="mjx-c32"></mjx-c></mjx-mn></mjx-texatom></mjx-script></mjx-msup><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c2260"></mjx-c></mjx-mo><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c28"></mjx-c></mjx-mo><mjx-mo class="mjx-n"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mn class="mjx-n"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c22C5"></mjx-c></mjx-mo><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mn class="mjx-n"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-msup><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-script style="vertical-align: 0.363em;"><mjx-texatom size="s" texclass="ORD"><mjx-mn class="mjx-n"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2F"></mjx-c></mjx-mo></mjx-texatom><mjx-mn class="mjx-n"><mjx-c class="mjx-c32"></mjx-c></mjx-mn></mjx-texatom></mjx-script></mjx-msup></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mo stretchy="false">(</mo><mo>−</mo><mn>1</mn><msup><mo stretchy="false">)</mo><mrow data-mjx-texclass="ORD"><mn>1</mn><mrow data-mjx-texclass="ORD"><mo>/</mo></mrow><mn>2</mn></mrow></msup><mo stretchy="false">(</mo><mo>−</mo><mn>1</mn><msup><mo stretchy="false">)</mo><mrow data-mjx-texclass="ORD"><mn>1</mn><mrow data-mjx-texclass="ORD"><mo>/</mo></mrow><mn>2</mn></mrow></msup><mo>≠</mo><mo stretchy="false">(</mo><mo>−</mo><mn>1</mn><mo>⋅</mo><mo>−</mo><mn>1</mn><msup><mo stretchy="false">)</mo><mrow data-mjx-texclass="ORD"><mn>1</mn><mrow data-mjx-texclass="ORD"><mo>/</mo></mrow><mn>2</mn></mrow></msup></math></mjx-assistive-mml></mjx-container></span></p></td>
<td><p><span class="math notranslate nohighlight"><mjx-container class="MathJax CtxtMenu_Attached_0" jax="CHTML" tabindex="0" ctxtmenu_counter="32" style="font-size: 113.1%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-msqrt><mjx-sqrt><mjx-surd><mjx-mo class="mjx-n"><mjx-c class="mjx-c221A"></mjx-c></mjx-mo></mjx-surd><mjx-box style="padding-top: 0.281em;"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi></mjx-box></mjx-sqrt></mjx-msqrt><mjx-msqrt><mjx-sqrt><mjx-surd><mjx-mo class="mjx-n"><mjx-c class="mjx-c221A"></mjx-c></mjx-mo></mjx-surd><mjx-box style="padding-top: 0.184em;"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi></mjx-box></mjx-sqrt></mjx-msqrt><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c2260"></mjx-c></mjx-mo><mjx-msqrt space="4"><mjx-sqrt><mjx-surd><mjx-mo class="mjx-n"><mjx-c class="mjx-c221A"></mjx-c></mjx-mo></mjx-surd><mjx-box style="padding-top: 0.184em;"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi></mjx-box></mjx-sqrt></mjx-msqrt></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><msqrt><mi>x</mi></msqrt><msqrt><mi>y</mi></msqrt><mo>≠</mo><msqrt><mi>x</mi><mi>y</mi></msqrt></math></mjx-assistive-mml></mjx-container></span> in general</p></td>
</tr>
<tr class="row-even"><td><ol class="arabic simple" start="3">
<li><p><span class="math notranslate nohighlight"><mjx-container class="MathJax CtxtMenu_Attached_0" jax="CHTML" tabindex="0" ctxtmenu_counter="33" style="font-size: 113.1%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo><mjx-msup><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-script style="vertical-align: 0.363em;"><mjx-mi class="mjx-i" size="s"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi></mjx-script></mjx-msup><mjx-msup><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-script style="vertical-align: 0.363em;"><mjx-mi class="mjx-i" size="s"><mjx-c class="mjx-c1D44F TEX-I"></mjx-c></mjx-mi></mjx-script></mjx-msup><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c3D"></mjx-c></mjx-mo><mjx-msup space="4"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-script style="vertical-align: 0.363em;"><mjx-texatom size="s" texclass="ORD"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44F TEX-I"></mjx-c></mjx-mi></mjx-texatom></mjx-script></mjx-msup></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mo stretchy="false">(</mo><msup><mi>x</mi><mi>a</mi></msup><msup><mo stretchy="false">)</mo><mi>b</mi></msup><mo>=</mo><msup><mi>x</mi><mrow data-mjx-texclass="ORD"><mi>a</mi><mi>b</mi></mrow></msup></math></mjx-assistive-mml></mjx-container></span></p></li>
</ol>
</td>
<td><p><span class="math notranslate nohighlight"><mjx-container class="MathJax CtxtMenu_Attached_0" jax="CHTML" tabindex="0" ctxtmenu_counter="34" style="font-size: 113.1%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44F TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c2208"></mjx-c></mjx-mo><mjx-texatom space="4" texclass="ORD"><mjx-mi class="mjx-ds mjx-b"><mjx-c class="mjx-c2124 TEX-A"></mjx-c></mjx-mi></mjx-texatom></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mi>b</mi><mo>∈</mo><mrow data-mjx-texclass="ORD"><mi mathvariant="double-struck">Z</mi></mrow></math></mjx-assistive-mml></mjx-container></span></p></td>
<td><p><span class="math notranslate nohighlight"><mjx-container class="MathJax CtxtMenu_Attached_0" jax="CHTML" tabindex="0" ctxtmenu_counter="35" style="font-size: 113.1%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-msup><mjx-texatom texclass="ORD"><mjx-mrow><mjx-mo class="mjx-sop"><mjx-c class="mjx-c28 TEX-S1"></mjx-c></mjx-mo><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo><mjx-mo class="mjx-n"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mn class="mjx-n"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-msup><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-script style="vertical-align: 0.363em;"><mjx-mn class="mjx-n" size="s"><mjx-c class="mjx-c32"></mjx-c></mjx-mn></mjx-script></mjx-msup><mjx-mo class="mjx-sop"><mjx-c class="mjx-c29 TEX-S1"></mjx-c></mjx-mo></mjx-mrow></mjx-texatom><mjx-script style="vertical-align: 0.577em;"><mjx-texatom size="s" texclass="ORD"><mjx-mn class="mjx-n"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2F"></mjx-c></mjx-mo></mjx-texatom><mjx-mn class="mjx-n"><mjx-c class="mjx-c32"></mjx-c></mjx-mn></mjx-texatom></mjx-script></mjx-msup><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c2260"></mjx-c></mjx-mo><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c28"></mjx-c></mjx-mo><mjx-mo class="mjx-n"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mn class="mjx-n"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-msup><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-script style="vertical-align: 0.363em;"><mjx-texatom size="s" texclass="ORD"><mjx-mn class="mjx-n"><mjx-c class="mjx-c32"></mjx-c></mjx-mn><mjx-mo class="mjx-n"><mjx-c class="mjx-c22C5"></mjx-c></mjx-mo><mjx-mn class="mjx-n"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2F"></mjx-c></mjx-mo></mjx-texatom><mjx-mn class="mjx-n"><mjx-c class="mjx-c32"></mjx-c></mjx-mn></mjx-texatom></mjx-script></mjx-msup></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><msup><mrow data-mjx-texclass="ORD"><mrow data-mjx-texclass="INNER"><mo data-mjx-texclass="OPEN">(</mo><mo stretchy="false">(</mo><mo>−</mo><mn>1</mn><msup><mo stretchy="false">)</mo><mn>2</mn></msup><mo data-mjx-texclass="CLOSE">)</mo></mrow></mrow><mrow data-mjx-texclass="ORD"><mn>1</mn><mrow data-mjx-texclass="ORD"><mo>/</mo></mrow><mn>2</mn></mrow></msup><mo>≠</mo><mo stretchy="false">(</mo><mo>−</mo><mn>1</mn><msup><mo stretchy="false">)</mo><mrow data-mjx-texclass="ORD"><mn>2</mn><mo>⋅</mo><mn>1</mn><mrow data-mjx-texclass="ORD"><mo>/</mo></mrow><mn>2</mn></mrow></msup></math></mjx-assistive-mml></mjx-container></span></p></td>
<td><p><span class="math notranslate nohighlight"><mjx-container class="MathJax CtxtMenu_Attached_0" jax="CHTML" tabindex="0" ctxtmenu_counter="36" style="font-size: 113.1%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-msqrt><mjx-sqrt><mjx-surd><mjx-mo class="mjx-n"><mjx-c class="mjx-c221A"></mjx-c></mjx-mo></mjx-surd><mjx-box style="padding-top: 0.122em;"><mjx-msup><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-script style="vertical-align: 0.289em;"><mjx-mn class="mjx-n" size="s"><mjx-c class="mjx-c32"></mjx-c></mjx-mn></mjx-script></mjx-msup></mjx-box></mjx-sqrt></mjx-msqrt><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c2260"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="4"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><msqrt><msup><mi>x</mi><mn>2</mn></msup></msqrt><mo>≠</mo><mi>x</mi></math></mjx-assistive-mml></mjx-container></span> and <span class="math notranslate nohighlight"><mjx-container class="MathJax CtxtMenu_Attached_0" jax="CHTML" tabindex="0" ctxtmenu_counter="37" style="font-size: 113.1%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-msqrt><mjx-sqrt><mjx-surd><mjx-mo class="mjx-lop"><mjx-c class="mjx-c221A TEX-S2"></mjx-c></mjx-mo></mjx-surd><mjx-box style="padding-top: 0.299em;"><mjx-mfrac><mjx-frac><mjx-num><mjx-nstrut></mjx-nstrut><mjx-mn class="mjx-n" size="s"><mjx-c class="mjx-c31"></mjx-c></mjx-mn></mjx-num><mjx-dbox><mjx-dtable><mjx-line></mjx-line><mjx-row><mjx-den><mjx-dstrut></mjx-dstrut><mjx-mi class="mjx-i" size="s"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi></mjx-den></mjx-row></mjx-dtable></mjx-dbox></mjx-frac></mjx-mfrac></mjx-box></mjx-sqrt></mjx-msqrt><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c2260"></mjx-c></mjx-mo><mjx-mfrac space="4"><mjx-frac><mjx-num><mjx-nstrut></mjx-nstrut><mjx-mn class="mjx-n" size="s"><mjx-c class="mjx-c31"></mjx-c></mjx-mn></mjx-num><mjx-dbox><mjx-dtable><mjx-line></mjx-line><mjx-row><mjx-den><mjx-dstrut></mjx-dstrut><mjx-msqrt size="s"><mjx-sqrt><mjx-surd><mjx-mo class="mjx-n"><mjx-c class="mjx-c221A"></mjx-c></mjx-mo></mjx-surd><mjx-box style="padding-top: 0.281em;"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi></mjx-box></mjx-sqrt></mjx-msqrt></mjx-den></mjx-row></mjx-dtable></mjx-dbox></mjx-frac></mjx-mfrac></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><msqrt><mfrac><mn>1</mn><mi>x</mi></mfrac></msqrt><mo>≠</mo><mfrac><mn>1</mn><msqrt><mi>x</mi></msqrt></mfrac></math></mjx-assistive-mml></mjx-container></span> in general</p></td>
</tr>
</tbody>
</table>

This is important to remember, because by default, SymPy will not perform simplifications if they are not true in general

Now we use these rules below


```python
x,y = symbols('x y', positive=True)
a,b,n = symbols('a b n', real=True)
z,t,c = symbols('z t c')
f,h,g = symbols('f h g', cls=Function)
```

`powsimp()` applies identities 1 and 2 from above, from left to right


```python
powsimp(x**a*x**b)
```




$\displaystyle x^{a + b}$



> In some instances, in particular, when the exponents are integers or rational numbers, and identity 2 holds, it will be applied automatically.This means that it will be impossible to undo this identity with `powsimp()`


```python
powsimp(x**2*y**2)
```




$\displaystyle x^{2} y^{2}$



`expand_power_exp()` and `expand_power_base()` apply identities 1 and 2 from right to left, respectively


```python
expand_power_exp(x**(a+b)),expand_power_base((x*y)**a)
```




$\displaystyle \left( x^{a} x^{b}, \  x^{a} y^{a}\right)$



`powdenest()` applies identity 3, from left to right


```python
powdenest((x**a)**b)
```




$\displaystyle x^{a b}$



### Exponentials and logarithms
There are 2 rules of Logarithms
1. $\log{xy}=\log{x}+\log{y}$
2. $\log{x^n}=n\log{x}$

if $x$ and $y$ are positive and $n$ is real

> Then we have functions `expand_log()` and `logcombine()` doing as their name

### Special Functions

`factorial()` is $n!$


```python
factorial(n)
```




$\displaystyle n!$



`binomial()` represents $\binom{n}{k}$


```python
binomial(n,a)
```




$\displaystyle {\binom{n}{a}}$



`gamma()` is $\Gamma(z)$


```python
gamma(z)
```




$\displaystyle \Gamma\left(z\right)$



`hyper([a_1,...,a_p],[b_1,...,b_q],z)` represents ${}_pF_q\left(\begin{matrix}a_1,\dots,a_p \\ b_1,\dots,b_q\end{matrix}\,\bigg|\,z\right)$


```python
hyper([1,2],[3],z)
```




$\displaystyle {{}_{2}F_{1}\left(\begin{matrix} 1, 2 \\ 3 \end{matrix}\middle| {z} \right)}$



A common way to deal with special functions is to rewrite them in terms of one another. This works for any function in SymPy, not just special functions. To rewrite an expression in terms of a function, use `expr.rewrite(function)`


```python
tan(x).rewrite(cos),factorial(x).rewrite(gamma)
```




$\displaystyle \left( \frac{\cos{\left(x - \frac{\pi}{2} \right)}}{\cos{\left(x \right)}}, \  \Gamma\left(x + 1\right)\right)$



To expand special functions in terms of some identities, use `expand_func()`


```python
expand_func(gamma(x+4))
```




$\displaystyle x \left(x + 1\right) \left(x + 2\right) \left(x + 3\right) \Gamma\left(x\right)$



To rewrite `hyper` in terms of more standard functions, use `hyperexpand()`


```python
hyperexpand(hyper([1,2],[3],z))
```




$\displaystyle - \frac{2}{z} - \frac{2 \log{\left(1 - z \right)}}{z^{2}}$



> `hyperexpand()` also works on the more general Meijer G-function

To simplify combinatorial expressions, use `combsimp()`


```python
combsimp(factorial(n)/factorial(n-3))
```




$\displaystyle n \left(n - 2\right) \left(n - 1\right)$



To simplify expressions with gamma functions or combinatorial functions with non-integer argument, use `gammasimp()`


```python
gammasimp(gamma(x)*gamma(1-x))
```




$\displaystyle \frac{\pi}{\sin{\left(\pi x \right)}}$



### Continued Fractions


```python
def list2frac(lst):
    expr = Integer(0)
    for i in reversed(lst[1:]):
        expr += i
        expr = 1/expr
    return lst[0] + expr
expr = list2frac([x,2,y,4,z])
expr
```




$\displaystyle x + \frac{1}{2 + \frac{1}{y + \frac{1}{4 + \frac{1}{z}}}}$



We use `Integer(0)` in `list2frac` so that the result will always be a SymPy object, even if we only pass in Python ints

We can use apart like this:


```python
apart(expr,y)
```




$\displaystyle x - \frac{4 z + 1}{2 \left(8 y z + 2 y + 6 z + 1\right)} + \frac{1}{2}$



## Calculus

We can use `diff()` to take derivatives


```python
expr = exp(x*y*z)
diff(cos(x),x),exp(x**2).diff(x,2),diff(expr,x,y,2),expr.diff(x,2,y)
```




$\displaystyle \left( - \sin{\left(x \right)}, \  2 \left(2 x^{2} + 1\right) e^{x^{2}}, \  x z^{2} \left(x y z + 2\right) e^{x y z}, \  y z^{2} \left(x y z + 2\right) e^{x y z}\right)$



To create an unevaluated derivative, use the `Derivative` class. It has the same syntax as `diff()`


```python
deriv = Derivative(expr,x,y,2,z,4)
deriv
```




$\displaystyle \frac{\partial^{7}}{\partial z^{4}\partial y^{2}\partial x} e^{x y z}$



To evaluate an unevaluated derivative, use the `doit()` method


```python
deriv.doit()
```




$\displaystyle x^{3} y^{2} \left(x^{3} y^{3} z^{3} + 14 x^{2} y^{2} z^{2} + 52 x y z + 48\right) e^{x y z}$



In terms of intergrals, we can use it like:


```python
expr_obj = (exp(-x**2-y**2),(x,-oo,oo),(y,-oo,oo))
integrate(*expr_obj),Integral(*expr_obj)
```




$\displaystyle \left( \pi, \  \int\limits_{-\infty}^{\infty}\int\limits_{-\infty}^{\infty} e^{- x^{2} - y^{2}}\, dx\, dy\right)$



As with Derivative, you can create an unevaluated integral using `Integral`. To later evaluate this integral, call `doit()`


```python
Integral(sin(x**2),x).doit()
```




$\displaystyle \frac{3 \sqrt{2} \sqrt{\pi} S\left(\frac{\sqrt{2} x}{\sqrt{\pi}}\right) \Gamma\left(\frac{3}{4}\right)}{8 \Gamma\left(\frac{7}{4}\right)}$



If wanna compute limits,try using it like:


```python
limit(1/x,x,0,'-')
```




$\displaystyle -\infty$



We use `series()` to expand function called Tylor Series Expansion


```python
expr = exp(sin(x))
expr.series(x,0,4)
```




$\displaystyle 1 + x + \frac{x^{2}}{2} + O\left(x^{4}\right)$



> If we miss 4, function would expand til $O(x^6)$ at default

The $O(x^4)$ term at the end represents the Landau order term at $x=0$


```python
expr = 1+x+O(x)
expr,expr.removeO()
```




$\displaystyle \left( 1 + O\left(x\right), \  1\right)$



As of complex function, we compute its residue by `residue()`


```python
residue(1/(1+x**2),x,I)
```




$\displaystyle - \frac{i}{2}$



We can use finite defferences when we get confused by analytic derivatives.Specifically,we use `differentiate_finite()` to replace `diff()`


```python
differentiate_finite(f(x)*g(x))
```




$\displaystyle - f{\left(x - \frac{1}{2} \right)} g{\left(x - \frac{1}{2} \right)} + f{\left(x + \frac{1}{2} \right)} g{\left(x + \frac{1}{2} \right)}$



If you already have a `Derivative` instance, you can use the `as_finite_difference()` method to generate approximations of the derivative to arbitrary order


```python
f(x).diff(x).as_finite_difference()
```




$\displaystyle - f{\left(x - \frac{1}{2} \right)} + f{\left(x + \frac{1}{2} \right)}$



here the first order derivative was approximated around x using a minimum number of points (2 for 1st order derivative) evaluated equidistantly using a step-size of 1. We can use arbitrary steps (possibly containing symbolic expressions)


```python
f(x).diff(x,2).as_finite_difference([-3*t,-t,2*t])
```




$\displaystyle \frac{f{\left(- 3 t \right)}}{5 t^{2}} - \frac{f{\left(- t \right)}}{3 t^{2}} + \frac{2 f{\left(2 t \right)}}{15 t^{2}}$



If you are just interested in evaluating the weights, you can do so manually


```python
finite_diff_weights(2, [-3, -1, 2], 0)[-1][-1]
```




$\displaystyle \left[ \frac{1}{5}, \  - \frac{1}{3}, \  \frac{2}{15}\right]$



note that we only need the last element in the last sublist returned from `finite_diff_weights`. The reason for this is that the function also generates weights for lower derivatives and using fewer points

If using `finite_diff_weights` directly looks complicated, and the `as_finite_difference()` method of Derivative instances is not flexible enough, you can use `apply_finite_diff` which takes `order`, `x_list`, `y_list` and `x0` as parameters


```python
x_list = [-3, 1, 2]
y_list = symbols('a b c')
apply_finite_diff(1, x_list, y_list, 0)
```




$\displaystyle - \frac{3 a}{20} - \frac{b}{4} + \frac{2 c}{5}$



## Solvers
We use solveset to get the roots of equation `Eq()`


```python
solveset(Eq(sin(z),1),z,domain=S.Reals)
```




$\displaystyle \left\{2 n \pi + \operatorname{asin}{\left(2 \right)}\; \middle|\; n \in \mathbb{Z}\right\} \cup \left\{2 n \pi + \pi - \operatorname{asin}{\left(2 \right)}\; \middle|\; n \in \mathbb{Z}\right\}$



We can use `linsolve()` to solve the linear system of equations

- List of Equations Form:


```python
linsolve([x+y+z-1,x+y+2*z-3],(x,y,z))
```




$\displaystyle \left\{\left( - y - 1, \  y, \  2\right)\right\}$



- Augmented Matrix Form:


```python
linsolve(Matrix([[1,1,1,1],[1,1,2,3]]),(x,y,z))
```




$\displaystyle \left\{\left( - y - 1, \  y, \  2\right)\right\}$



- $Ax=b$ Form:


```python
M = Matrix([[1,1,1,1],[1,1,2,3]])
system = A,b = M[:,:-1],M[:,-1]
linsolve(system,x,y,z)
```




$\displaystyle \left\{\left( 1, \  y, \  z\right)\right\}$



We can use `nonlinsolve()` to solve the non linear system of equations


```python
system = [exp(x)-sin(y),1/y-3]
vars = [x,y]
nonlinsolve(system,vars)
```




$\displaystyle \left\{\left( \left\{2 n i \pi + \log{\left(\sin{\left(\frac{1}{3} \right)} \right)}\; \middle|\; n \in \mathbb{Z}\right\}, \  \frac{1}{3}\right)\right\}$



> Currently `nonlinsolve` is not properly capable of solving the system of equations having trigonometric functions

If we wanna know the multiplicity of root, we can use `roots()`, which return {root:multiplicity}


```python
roots(x**3-6*x**2+9*x,x)
```




$\displaystyle \left\{ 0 : 1, \  3 : 2\right\}$



Using `dsolve()` to address with ODE


```python
diffeq = Eq(f(x).diff(x,2)-2*f(x).diff(x)+f(x),sin(x))
diffeq,dsolve(diffeq,f(x))
```




$\displaystyle \left( f{\left(x \right)} - 2 \frac{d}{d x} f{\left(x \right)} + \frac{d^{2}}{d x^{2}} f{\left(x \right)} = \sin{\left(x \right)}, \  f{\left(x \right)} = \left(C_{1} + C_{2} x\right) e^{x} + \frac{\cos{\left(x \right)}}{2}\right)$



## Matrix
`.rref()` returns a tuple of 2 elements. The first is the reduced row echelon form, the second is a tuple of indices of the pivot columns


```python
M = Matrix([[1,2,3,4],[3,5,7,9],[6,4,2,7]])
M,M.rref()
```




    (Matrix([
     [1, 2, 3, 4],
     [3, 5, 7, 9],
     [6, 4, 2, 7]]),
     (Matrix([
      [1, 0, -1, 0],
      [0, 1,  2, 0],
      [0, 0,  0, 1]]),
      (0, 1, 3)))



`.nullspace()` returns a list of column vectors that span the nullspace of the matrix


```python
M.nullspace()
```




    [Matrix([
     [ 1],
     [-2],
     [ 1],
     [ 0]])]



`columnspace()` returns a list of column vectors that span the columnspace of the matrix


```python
M.columnspace()
```




    [Matrix([
     [1],
     [3],
     [6]]),
     Matrix([
     [2],
     [5],
     [4]]),
     Matrix([
     [4],
     [9],
     [7]])]



Use `eigenvals()` to get eigenvalues, use `eigenvects()` as its name suggests, which returns a list of tuples of the form `(eigenvalue, algebraic_multiplicity, [eigenvectors])`


```python
M = Matrix([[3, -2,  4, -2], [5,  3, -3, -2], [5, -2,  2, -2], [5, -2, -3,  3]])
M.eigenvals(),M.eigenvects()
```




    ({3: 1, -2: 1, 5: 2},
     [(-2, 1, [Matrix([
        [0],
        [1],
        [1],
        [1]])]),
      (3,
       1,
       [Matrix([
        [1],
        [1],
        [1],
        [1]])]),
      (5,
       2,
       [Matrix([
        [1],
        [1],
        [1],
        [0]]),
        Matrix([
        [ 0],
        [-1],
        [ 0],
        [ 1]])])])



Use `.diagonalize()` to diagonalize a matrix, which returns a tuple (P,D), where D is diagonal and $M=PDP^{-1}$


```python
P,D = M.diagonalize()
P,D
```




    (Matrix([
     [0, 1, 1,  0],
     [1, 1, 1, -1],
     [1, 1, 1,  0],
     [1, 1, 0,  1]]),
     Matrix([
     [-2, 0, 0, 0],
     [ 0, 3, 0, 0],
     [ 0, 0, 5, 0],
     [ 0, 0, 0, 5]]))


