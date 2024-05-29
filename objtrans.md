# Object transformation
We first have to define how we treat the motion of bodies in general.

## Transformations of Space
The motion of bodies in $\mathbb{R}^3$ can be described using two functions:

 - **Translations**,
    $g_1(r) = (r + r_0)$
    Defined by three parameters: $r_0 \in \mathbb{R}^{3}$, for three dimensions in Space.
 - **Rotations**,
    $g_2(r) = (Or)$
     with $O$ being a orthogonal Transformation $O: \mathbb{R}^{3} \mapsto \mathbb{R}^{3}$ having $det(O) = 1$ (for Rotations) and $O^T = O^{-1}$. Rotations have three Parameters for the three axes of rotation.

````{prf:definition} Lie group

A **Lie group** is a **group** which is also a **smooth manifold** on which the group operations are smooth functions.
````

````{prf:definition} Special orthogonal Group $SO(3)$

The Special orthogonal group consists of proper Rotations $g_2(O)$ and forms a **lie group**.
````

````{prf:definition} Special euclidean group $SE(3)$

The special euclidean group consists of proper Rotations $g_2(O)$ combined with translations $g_1(r_0)$ and forms a **lie group**. We write an element $E \in SE(3)$ as $ E = (a, O)$ where $a$ defines a translations and $O$ a rotation.
````

## Spatial frame and body frame
The motion of a body in general can now be described by a function $U: \mathbb{R} \rightarrow SE(3)$ and the initial coordinates of the body $r_0$ as the following:

$$r(t) = a(t) + O(t)r_0$$

This leaves us with the possibility to look at a body in two different ways:

 - **The spatial frame (global)**
    A coordinates system which stays fixed in time and in which our initial position $r_0$ is defined.
 - **The body frame (local)**
    A coordinate system specific to the body where the body is stationary in.

Let $(B_1, B_2, B_3)$ be the initial coordinates of the body relative to the spatial basis $(E_1, E_2, E_3)$. Then the body frame relative to the spatial frame at time $t \in \mathbb{R}^+$ is the the three dimensional affine room
$a(t) + span{ O(t)B_1, O(t)B_2, O(t)B_3 }$

We now see that $r_0$ denotes the local position of a body and $r(t)$ the global coordinates.
