# Object Transformation
We first have to define how we treat the motion of bodies in general.
$\newcommand{\RR}[0]{{\mathbb{R}}}$

## Transformations of Space
The motion of a body in $\mathbb{R}^3$ can be described using two types of functions:

 - **Translations**
    $T_{x_0}(x) = x + x_0$,
    defined by three parameters: $x_0 \in \mathbb{R}^{3}$, for three dimensions in space.
 - **Rotations**
    $R_O(x) = O \cdot x$
     with $O$ being an orthogonal transformation $O: \mathbb{R}^{3} \mapsto \mathbb{R}^{3}$ having $det(O) = 1$ (to exclude mirroring) and $O^T = O^{-1}$.
     Rotations have three degrees of freedom for the three axes of rotation.

```{prf:definition} Lie group

A **lie group** is a **group** which is also a **smooth manifold** on which the group operations are smooth functions.
If the group operation of a lie group can be seen as a matrix multiplication, it is called a **matrix lie group**.
The topological tangent space of a matrix lie group is called its **lie algebra**.
```

```{prf:definition} Special orthogonal Group $SO(3)$

The special orthogonal group consists of all rotations $R_O$.
```

```{prf:definition} Special euclidean group $SE(3)$

The special euclidean group consists of all rotations $R_O$ combined with all translations $T_{x_0}$.
We write an element $E \in SE(3)$ as $ E = (a, O)$ where $a$ defines a translation vector and $O$ a rotation matrix.
An element of $SE(3)$ shall be called a **transformation**.
The group operation on $SE(3)$ is defined as $(t_1, O_1) \cdot (t_2, O_2) = (O_1 t_2 + t_1, O_1 O_2)$
```
{cite}`betschstruc{Chapter 2.1}`

The implementation in ASC-ODE uses $SE(3)$, but also the product group $SO(3) \times \RR^3$.
The group operations of these groups are implemented as `+` for $SO(3) \times \RR^3$ and `*` for $SE(3)$.
(See the python API.)


$SO(3)$, $SE(3)$ and $SO(3) \times \RR^3$ are lie groups {cite}`betschstruc{p. 96}`.
They are even matrix lie groups {cite}`betschstruc{p. 95}`.
As their subgroup $SO(3)$ (rotations) is not commutative, they are not commutative either.

In the following example, ASC-ODE also makes use of the following:
$R \in SO(3)$ if and only if there exists an orthonormal matrix $B$ and $\varphi \in [0, \pi]$ such that
\begin{equation}
   A = B^{-1}
   \begin{pmatrix}
      1 & 0           & 0 \\
      0 & cos~ \varphi & -sin~ \varphi \\
      0 & sin~ \varphi & cos~ \varphi
   \end{pmatrix}
   B
\end{equation}

This matrix has a one-dimensional eigenspace, the axis of rotation.
$\varphi$ is the rotation angle.
The lower right block of the matrix lies in $SO(2)$, which is commutative. Therefore, rotations around the same axis are commutative.

For any given matrix $R \in SO(3)$, the axis of rotation can be calculated as its eigenvector with eigenvalue 1.
(Although there exists more than one eigenvector if $R = I$.)
The angle can be calculated due to the fact that the trace of a matrix is similarity-invariant:
\begin{equation}
   \varphi = arccos \left( \frac{tr(R) - 1}{2} \right)
\end{equation}

{cite}`havl{12.4.14}`

````{div} full-width
```{dropdown} Jupyterlite
<iframe src="https://triadtitans.github.io/rigid_body_interactive/lab/index.html?path=trafo_demo.ipynb" width=100% height="700"></iframe>
```
````

(inertiaframes)=
## Spatial Frame and Body Frame
The motion of a body can now be described by a function $U: \mathbb{R} \rightarrow SO(3) \times \RR^3$:

$$ U(t)(x) = a(t) + O(t) \cdot x $$

with $x \in \RR^3$.

This leaves us with the possibility to look at a body in two different ways:

 - **The spatial frame (global)**
    A global coordinate system which stays fixed in time.
 - **The body frame (local)**
    A coordinate system specific to the body in which the body is stationary.

    {cite}`geomech{Chapter 2}`

Let $a(t), O(t)$ describe the transformation of a body.
Then $U$ converts vectors from the body frame to the spatial frame.
Therefore, the body frame can be seen as the affine space
\begin{equation}
   U(\RR^3) = a(t) + O(t) \cdot \RR^3
\end{equation}

During the project, $U$ was used as such a conversion function. This has proven useful for multibody interaction (via springs and beams) and visualisation.

<!-- Let $(B_1, B_2, B_3)$ be the initial coordinates of the body relative to the spatial basis $(E_1, E_2, E_3)$. Then the body frame relative to the spatial frame at time $t \in \mathbb{R}^+$ is the three dimensional affine space
$a(t) + span\{ O(t)B_1, O(t)B_2, O(t)B_3 \}$

We now see that $r_0$ denotes the local position of a body and $r(t)$ the global coordinates. -->

<!-- ## Storing transformations

For storing a transformation $u(x) = p + R \cdot x \in SE(3)$, ASC-ODE stores the components in a vector $X \in \mathbb{R}^{12}$.
Three different shapes of $X$ have developed:

 - **"The intuitive way"**: $ X = (p_1, p_2, p_3, R_{11}, R_{12}, R_{13}, R_{23}, \ldots) $ That is: First $p$, then $R$ in row-major ordering.
 - **"Range-component-first"**: $ X = (p_1, R_{11}, R_{12}, R_{13}, R_{23}, p_2, R_{21}, \ldots) $ Components are grouped together per output coordinate. This makes things far more beautiful in the next chapter.
 - **"Pythreejs-style"**: $ X = (R_{11}, R_{21}, R_{31}, R_{12}, R_{22}, \ldots , p_1, p_2, p_3) $ This is the way that the visualisation framework pythreejs goes.
A transformation $(a,O) \in SE(3)$ can be stored by storing $a$ and $O$ seperately. However, storing it as the matrix
\begin{pmatrix}

\end{pmatrix}
-->

## Motion in $SO(3)$

ASC-ODE treats velocity in $SO(3)$ and $\RR^3$ separately.

```{prf:definition} Skew symmetric matrix
A **skew-symmetric** matrix is a matrix $\widehat{\omega}$ such that
\begin{equation}
   \widehat{\omega}^T = -\widehat{\omega}
\end{equation}.
Here, the hat $\widehat{\cdot}$ will be commonly used to denote skew-symmetry.
```

```{prf:lemma}
\begin{equation}
\forall~ t~ \exists~ \widehat{\omega}_{body}~ \text{skew-symmetric}:~~ \frac{dO}{dt}(t) = O(t)\widehat{\omega}_{body}
\end{equation}

or alternatively:

\begin{equation}
\forall~ t~ \exists~ \widehat{\omega}_{space}~ \text{skew-symmetric}:~~ \frac{dO}{dt}(t) = \widehat{\omega}_{space}O(t)
\end{equation}

$\widehat{\omega}_{body}$ and $\widehat{\omega}_{space}$ are called the body and space angular velocities. {cite}`geomech{2.1.24}`
ASC-ODE uses $\widehat{\omega}_{body}$.
```
````{prf:proof}
For the first equation, we prove $\exists~\widehat{\omega} ~ \text{skew-symmetric:}~ \widehat{\omega} = O^{-1}\dot{O}$:
```{math}
\begin{equation}
0 = \dot{I} = (O^TO)~\dot{} = \dot{O}^TO + O^T\dot{O} = (O^T \dot{O})^T + O^T\dot{O} =  (O^{-1} \dot{O})^T + O^{-1}\dot{O} =
\widehat{\omega}^T + \widehat{\omega}
\end{equation}
```
{cite}`{See}geomech{proof of lemma 2.1.5}`.

For the second equation, exchange $(O^TO)~\dot{}~$ for $(OO^T)~\dot{}~$
````

````{prf:remark} Hat map
The hat $\widehat{\cdot}$ can be seen as a function
\begin{align}
\widehat{\cdot}: \RR^3 & \rightarrow \{ M \in \RR^{3 \times 3} ~|~ M~ \text{skew symmetric}\} \\
\omega & \mapsto
   \begin{pmatrix}
      0 & -\omega_3 & \omega_2 \\
      \omega_3 & 0 & -\omega_1 \\
      -\omega_2 & \omega_1 & 0
   \end{pmatrix}
\end{align}

This function is linear and bijective.
Note that for $a, b \in \RR^3$, the following holds true: $a \times b = \widehat{a}b$.
{cite}`geomech{Thm. 2.1.12; 2.1.16}`
````
The skew-symmetric matrices are even the (topological) tangent space of SO(3) {cite}`hairer{p. 119}`.
From that and the remark above follows that angular velocity can be written as a vector $\omega \in \RR^3$.
The overall velocity of a body can therefore be written as a vector in $\RR^6$.
