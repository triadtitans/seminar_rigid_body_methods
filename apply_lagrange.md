# Applying lagrangian mechanics 

## Describing position and rotation
The generalised coordinates of a mass-point with rotation consist of the components of the translation vector and rotation matrix.
However, not all matrices are allowed; the rotation matrix needs to describe a valid rotation.
That is, it needs to be orthonormal.


\begin{align}
    B ~ \text{orthonormal} \\
    \Leftrightarrow \forall x \in \mathbb{R}^3:~ \| Bx \| & = \| x \| \\
    \Leftrightarrow \forall x \in \mathbb{R}^3:~ \| Bx \|^2 & = \| x \|^2 \\
    \Leftrightarrow \forall x \in \mathbb{R}^3:~ xB^TBx & = x^Tx \\
    \Leftrightarrow B^TB & = I
\end{align}

Therefore, the program only needs to check whether or not $B^TB = I$.
This can be broken down into 9 scalar equations, one for each compontent of $I$.
However, as $B^TB$ is symmetric {cite}`havl`, the program only needs to check six of these equations.

These generalised coordinates and constraints describe the configuration space of one mass-point with added rotation.


## Kinetic energy

In order to use the laws of langrangian mechanics, the langrangian function $L = T - V$ of the rigid-body system needs to be set up.
Let $ u(t)(x) = p(t) + R(t) \cdot x \in SE(3) $.
Let $X \in \mathbb{R}^{12}$ be a vector that stores the components of $p(t)$ and $R(t)$.
Let $B$ be the body that is supposed to be moved by $u$ and $\rho$ its density.
Then there exists a matrix $ M \in \mathbb{R}^{12 \times 12} $ such that:

\begin{equation}
    T(\dot{u}) = \frac{1}{2} \int_B \rho \| \dot{u} \|^2 dx = \frac{1}{2} \dot{X}^T M \dot{X}
\end{equation}
The dot denotes the time derivative.

The first equation above is essentially a continuous version of $ T = \frac{1}{2} \sum_i m_i \dot{x}_i$ {cite}`theorph`.
$\dot{x}_i $ denotes a generalised coordinate.

As for the second equation, $\left( f, g \right) := \frac{1}{2} \int_B \rho \| f \cdot g \| dx $ is a scalar product, which is easy to prove.
$M$ is a version of the scalar product's gram matrix. A version in the sense that is compatible with a vector representation of functions in $SE(3)$.

````{dropdown} The gram matrix
Consider $ S := \{ u(x) = p + R \cdot x ~|~ p(t) \in \mathbb{R}^3, R(t) \in \mathbb{R}^{3 \times 3} \} $.
$S$ is isomorphic to $\mathbb{R}^{12}$ (via "storing" the entries of $p$ and $R$ into $X \in \mathbb{R}^{12}$).
Let $\varphi: \mathbb{R}^{12} \to S$ be an isomorphism between the two spaces.
$S$ is thus finite-dimensional and a gram matrix of the scalar product $(\cdot, \cdot)$ on $S$ can be calculated.
As $S$ and $\mathbb{R}^{12}$ are isomorphic, $M$ can be defined: $M_{ij} := (\varphi(e_i), \varphi(e_j))$.
$ SE(3) $ is a subset of $S$, which makes the above applicable.
````

For an arbitrary object, netgen's occ bindings provide enough information to assemble $M$, namely:
The mass of the object, it's center of mass and it's inertia tensor $\Theta = (\int_B \rho ~ x \cdot x - x_i x_j)_{i,j=1}^3$ {cite}`theorph`.
The components of the inertia tensor are called moments of inertia.
Using the right ordering of $X$, one obtains:

\begin{equation}
    M = \begin{pmatrix}
            m & m \cdot c \\
            m \cdot c & I \\
            & & m & m \cdot c \\
            & & m \cdot c & I \\
            & & & & m & m \cdot c \\
            & & & & m \cdot c & I \\
        \end{pmatrix}
\end{equation}

where $I$ can be calculated from the inertia tensor:

\begin{equation}
    I_{ij} = \begin{cases}
                \Theta_{ij} & i \neq j \\
                \frac{1}{2} (\Theta_{22} + \Theta_{33} - \Theta_{11}) & i = j = 1 \\
                \vdots & \vdots
            \end{cases}
\end{equation}

## Other constraints
In addition to $B^TB = I$, other constraints can be formulated to describe beams connecting two bodies (or a body and a point in space).
Anchorpoints can also be implemented that way (as beams of length zero).


## Kinetic energy

```{todo}
write something
```

## Putting it together


