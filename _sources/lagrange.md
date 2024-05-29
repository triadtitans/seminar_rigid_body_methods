# Lagrangian mechanics

## An introduction to langrangian mechanics

There is now a way to move a body. However, this motion shall follow the laws of physics.
The approach of this project was to use langrangian mechanics.


## Applying lagrangian mechanics to the project

### Describing position and rotation
The generalised coordinates of a mass-point with rotation consist of the components of the translation vector and rotation matrix.
However, not all matrices are allowed; the rotation matrix needs to describe a valid rotation.
That is, it needs to lie in the special orthogonal group.


\begin{align}
    B ~ \text{orthonormal} \\
    \Leftrightarrow \forall x \in \mathbb{R}^3:~ \| Bx \| & = \| x \| \\
    \Leftrightarrow \forall x \in \mathbb{R}^3:~ \| Bx \|^2 & = \| x \|^2 \\
    \Leftrightarrow \forall x \in \mathbb{R}^3:~ xB^TBx & = x^Tx \\
    \Leftrightarrow B^TB & = I
\end{align}
 {cite}`mn`

Therefore, the program only needs to check whether or not $B^TB = I$.
This can be broken down into 9 scalar equations, one for each compontent of $I$.
However, as $B^TB$ is symmetric {cite}`havl`, the program only needs to check six of these equations.

These generalised coordinates and constraints describe the configuration space of one mass-point with added rotation.


### Kinetic energy

In order to use the laws of langrangian mechanics, the langrangian function $L = T - V$ of the rigid-body system needs to be set up.
It holds that:

\begin{equation}
    T(\dot{u}) = \int_B \rho
\end{equation}

In addition, other constraints can be formulated to describe beams connecting two bodies (or a body and a point in space).
Anchorpoints can also be implemented that way (as beams of length zero).

