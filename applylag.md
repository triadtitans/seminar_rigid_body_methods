# Applying lagrangian mechanics

## Describing position and rotation
The generalised coordinates of a mass-point with rotation consist of the components of the translation vector and rotation matrix.
A solver like ASC-ODE solves for a matrix that forms the rotation matrix of the body.
Therefore, it needs to ensure that the resulting matrix $B$ actually lies in $SO(3)$.

 - $\bf{det B = 1}$ This has proven to be negligable.
 - $\bf{B}$ **orthonormal** needs to be reformulated into an equation that is easy to check.

\begin{align}
    B ~ \text{orthonormal} \\
    \Leftrightarrow \forall x \in \mathbb{R}^3:~ \| Bx \| & = \| x \| \\
    \Leftrightarrow \forall x \in \mathbb{R}^3:~ \| Bx \|^2 & = \| x \|^2 \\
    \Leftrightarrow \forall x \in \mathbb{R}^3:~ xB^TBx & = x^Tx \\
    \Leftrightarrow B^TB & = I
\end{align}

Therefore, the program only checks whether or not $B^TB = I$.
This can be broken down into 9 scalar equations, one for each compontent of $I$.
However, as $B^TB$ is symmetric {cite}`havl`, the program only needs to check six of these equations.

These generalised coordinates and constraints describe the configuration space of one mass-point with added rotation.


## Kinetic energy

In order to use the laws of langrangian mechanics, the langrangian function $L = T - V$ of a rigid-body needs to be set up.
Let $ U(t)(x) = (t) + R(t) \cdot x \in SE(3) $. (See [](inertiaframes).)

Let $X \in \mathbb{R}^{12}$ be a vector that stores the components of $p(t)$ and $R(t)$.
Let $B$ be the body that is supposed to be moved and $\rho$ its density.
Let $U$ be the function that moves the body's inertia frame.
Then there exists a matrix $ M \in \mathbb{R}^{12 \times 12} $ such that:

\begin{equation}
    T(\dot{U}) = \frac{1}{2} \int_B \rho \| \dot{U} \|^2 dx = \frac{1}{2} \dot{X}^T M \dot{X}
\end{equation}

The first equation above is essentially a continuous version of $ T = \frac{1}{2} \sum_i m_i \dot{x}_i$ {cite}`theorph`.
$\dot{x}_i $ denotes a generalised coordinate.

As for the second equation, $\left( f, g \right) := \frac{1}{2} \int_B \rho \left( f \cdot g \right) dx $ is a scalar product, which is easy to prove.
$M$ is a version of the scalar product's gram matrix. A version in the sense that is compatible with a vector representation of functions in $SE(3)$.

````{dropdown} The gram matrix
Consider $ S := \{ U(x) = p + R \cdot x ~|~ p(t) \in \mathbb{R}^3, R(t) \in \mathbb{R}^{3 \times 3} \} $.
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

```{admonition} TODO
jupyter(lite) example
```

## Potential energy

ASC-ODE also implements potential energy.
To account for interactions between bodies, the potential is calculated **globally**.
That is, all potential energies of all bodies are summed up.
Let $q_i \in SE(3)$ represent the transformations of the individual bodies.
Then the result is a scalar-valued potential function
\begin{equation}
    V( q_1, q_2, q_3, ...).
\end{equation}

$V$ is then differenciated with respect to all components of all $q_i$.
As the derivative of the potential is the force, the values of resulting gradient are forces.
These forces act on the component values of the $q_i$ and thus on the transformations of the objects.

ASC-ODE implements the following types of forces using the global potential:

### "Gravity"

A simplified form of gravity can be implemented via a constant force that depends on the mass.
A force that acts homogenously on the body does not influence it's rotation.
Therefore, the body can be seen as a point mass. The bodies can also be treated individually.

Using $F = m \cdot a$, the force on a point mass can be specified as an acceleration vector $a \in \mathbb{R}^3$ and the body mass $m$.
For any given translation vector $x$, the antiderivative or potential of that force is $ m \cdot (a \cdot x)$.

In ASC-ODE, the mass is automatically calculated and the *negative* acceleration vector can be specified: rbs.gravity = (0, 9.81, 0) for downward force.


## Other constraints TODO: move to seperate chapter
In addition to $B^TB = I$, other constraints can be formulated to describe beams connecting two bodies (or a body and a point in space).
Anchorpoints can also be implemented that way (as beams of length zero).


## Putting it together
