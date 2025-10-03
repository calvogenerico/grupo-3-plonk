 - Zero Test:\
    $\forall x$ $\in$ $X$ y $X$ $\subset$ $\mathbb{F}_p$
    $$
     f(x) = 0
    $$
 -  sum Test:\
    sea $X$ $\subset$ $\mathbb{F}_p$, $C_0 \in \mathbb{F}_p$
    $$
    \sum_{(x_1,...,x_n) \in H^n}  f(x_1,x_2,...,x_n) = C_0
    $$
- Product Test:\
    sea $X$ $\subset$ $\mathbb{F}_p$
    $$
    \prod_{x:X} f(x) = 1
    $$

---
---
## Zero Test
Tenemos $f,t$ $\in$ $\mathbb{F}_{p}^{\leq d}$ $\left[ X \right]$ y $H=\{h \in \mathbb{F}_p | f(h) = 0 \}$, $|H| = k$ con $k \leq d$, defino $f$ y $t$ como
$$
f(x) = Z_H(x)t(x) \iff t(x)= \frac{f(x)}{Z_H(x)}
$$
y $Z_H(x) = \prod_{h:H}(X-h)$, en base a esto, se puede hacer un protocolo que compruebe Zero Test

> Evaluar $Z_H(x)$ toma $O(log(k))$ siendo $|H| = k$, mediante un Expresion Tree precomputado.
$$

\boxed{
	\begin{array}{cc}
        \textbf{Prover} \\
       t' \gets\frac{f'(x)}{Z_{H'}(x)}  \\ \\
       f'(z) = t'(z) Z_{H'}(z)
    \end{array}
}
\begin{array}{cc}
    \xrightarrow{com(f'),com(t')} \\
    \xleftarrow{z} \\
    \xrightarrow{f'(z), t'(z)}\\
    \xleftarrow{\{0,1\}}
\end{array}
\boxed{
	\begin{array}{cc}
        \textbf{Verifier} \\
        z \gets \mathbb{F}_p  \\ \\
        f'(z) = t'(z) Z_H(z)? \\
    \end{array}
}
$$
---
---
## Product Check
La idea de product check es verificar si dos SRS ($H$) son permutaciones, asi que para ello defino la siguiente recursion
$$
\begin{array}{c}
    w_0 = 1 \\
    w_i = w_{i-1} * \frac{H_i}{H'_i} \\
    H' \text{es la permutacion de } H \iff w_n = 1
\end{array}
$$
Un ejemplo, $H = \{ 1, 2, 3\}$ y $H' = \{ 3, 1, 2\}$ 
$$
    w_0 = 1 \\
    w_1 = 1 * \frac{1}{3} \\
    w_2 =  1 * \frac{1}{3} * \frac{2}{1} \\
    w_3 =  1 * \frac{1}{3} * \frac{2}{1} * \frac{3}{2} \\
    w_3 = 1
$$
---
---
Y que pasa con $H = \{ 1, 8\}$ y $H' = \{ 2, 4\}$ 
$$
\begin{array}{c}
    w_0 = 1 \\
    w_1 = 1 * \frac{1}{2} \\
    w_2 =  1 * \frac{1}{2} * \frac{8}{4} \\
    w_2 = 1
\end{array}
$$
Hay como salvar esto si usamos polinomios donde ahora digo que
$$
    w_0 = t(X) = 1 \\
    w_i = w_{i-1} * \frac{X-H_i}{X-H'_i} \\
    H' \text{es la permutacion de } H \iff w_n = 1
$$
---
---
Definimos que dos polinomios tienen iguales raices cuando
$$

    \frac{t(X) \prod_i^n(X - H_i)}{\prod_i^n(X - H'_i)} = 1 \\
    \iff t(X) \prod_i^n(X - H_i) = \prod_i^n(X - H_i) \\
    \iff f(X) - g(X) = 0 \\
    \hat f(x)= f(x) - g(x) = 0 ,\> \forall x \in H
$$
 - Por lo que puedo realizar ProductCheck como un caso particular de ZeroTest. \
 - Con esto tambien se puede probar si dos polinomios $f, g$ son permutaciones, con ZeroTest se puede verificar evaluando en el mismo punto ambos polinomios.

---
---
 ## Interpolacion de Lagrange
 $$
    f(x) = \sum_{i=0}^{n}f(h_i) * L_i(X), \\  L_i(X)=\prod_{j\neq i}\frac{X-h_j}{h_i -h_j}
 $$
 ## FFT(Fast Fourier Lagrange)
 $$
    f(x)=f_{even}(x^2)-x*f_{odd}(x^2)
 $$