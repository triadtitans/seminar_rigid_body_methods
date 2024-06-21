# An Extension: Constraints

In addition to $B^TB = I$, other constraints can be formulated, e.g. to describe beams connecting two bodies (or a body and a point in space).

**Example: Massless Beams** As with springs, the starting point are two points $x_1$, $x_2$ in different systems of inertia.
If $U_1(x_1)$ and $U_2(x_1)$ denote their position in the global system of inertia, then the aim is to keep
$\| U_1(x_1) - U_2(x_2) \|$ constant.
This makes for a massless beam.

## Adding Constraints

```{prf:definition}
An equation is called scleronomic if it does not depend on time.
It is called holonomic if it has the shape $f(x) = 0$.
{cite}`theorph`
```

Consider the scleronomic, holonomic system of constraints
\begin{equation}
g(q) = 0
\end{equation}
with $g:\mathbb{R}^d \to \mathbb{R}^m$ as an extra equation that a mechanical system should fulfill.
Let the individual constraints $g_i$ be independent.
Then the Jacobian of $g$, namely $J_g$, has full rank.

Mathematically, this constraint can be added into the system by further augmenting the Lagrangian function.
We obtain

$$
    \mathcal{S}(q,v,p) = \int_{t_0}^{T} L(q,v) + p(\dot{q}-v) + \lambda \cdot g(q) \,dt.
$$

{cite}`ggl`

### An Alternative Point of View

Such primary constraints can also be dealt with implicitly.
If $\lambda$ is considered to belong to $q$, the action functional can be rewritten to

$$
    \mathcal{S}(q,v,p) = \int_{t_0}^{T} T(v) - (V(q) - \lambda \cdot g(q)) + p(\dot{q}-v) \,dt.
$$

Therefore, modifying the calculation of $V$ and adding the equation $g(q) = 0$ is sufficient.

### A Drawback

In ASC-ODE however, this has proven not to work.
In the implementation, the momentum tried to compensate for the constraint and left the cotangent space.
This lead to the numerical system being so unstable that only a few simulation steps were possible.

## Secondary constraints

A partial solution proved to lie in adding an additional constraint to the system, namely:

$$
    0 = \frac{d}{dt} g(q(t)) = J_g(q(t)) \cdot \dot{q}(t) = J_g(q(t)) \cdot R(t) \cdot v(t) \\
    = J_g(q(t)) \cdot R(t) \cdot M^{-1} \cdot p(t) =: g^v(q(t), p(t))
$$

Note that these equations need to be viewed on a global scale as g might depend on any body's transformation!
Therefore, $q(t)$ needs to contain all transformations;
$M$ and $R(t)$ are block diagonal matrices containing all mass and rotation matrices of all bodies.

This constraint now depends on both $q$ and $p$ and can therefore not be dealt with by modifying $V(q)$.

This results in a change in the equations of motion, see below. New parts of the system are highlighted.

**For every body:**

$$
\frac{1}{h}(a_{i+1}-a_i) = v_{a_i} \bf{~+ \frac{\partial g^v}{\partial p}(q_{i+1}, p_{i+1})_{trans}}
$$

$$
\frac{1}{h}Skew(B_{i+1/2}^{-1}(B_{i+1} - B_i)) = \hat{v}_{rot_i} \bf{~+ \frac{\partial g^v}{\partial p}(q_{i+1}, p_{i+1})_{rot}}
$$

<hr>

$$
M\hat{v}_i = \hat{p}_i
$$

<hr>

$$
\frac{\bar{p}_{a_i} - p_{a_i}}{h/2} = f_{trans}(q_{i}) \bf{~+ \frac{d}{d p}} \bf{~+ \frac{\partial g^v}{\partial q}(q_{i}, p_{i})_{trans}}
$$

$$
\frac{{p}_{a_i} - \bar{p}_{a_{i+1}}}{h/2} = f_{trans}(q_{i+1}) \bf{~+ \frac{\partial g^v}{\partial q}(q_{i+1}, p_{i+1})_{trans}}
$$

$$
Skew(B_i^T(\frac{B_i\bar{p}_{rot_i}-B_{i+1/2}p_{rot_i}}{h/2} - f_{rot}(q_{i}) \bf{~- \frac{\partial g^v}{\partial q}(q_{i}, p_{i})_{rot}})) = 0
$$

$$
\ Skew(B_{i+1}^T(\frac{B_{i+1/2}p_{rot_i} - B_{i+1}\bar{p}_{rot_{i+1}}}{h/2} - f_{rot}(q_{i+1}) \bf{~- \frac{\partial g^v}{\partial q}(q_{i+1}, p_{i+1})_{rot}})) = 0
$$

$$
B_{i+1}^T B_{i+1} = I
$$

**Globally:**

$$
    \bf{g(q) = 0}
$$

$$
    \bf{g^v(q, p) = 0}
$$

Note that the primary constraints are integrated into the force.

### Performance

The problem with the resulting algorithm is a lack of performance.
To be precise, computing $J_g(q)$ proves to be numerically expensive.

For every step, the computer *recursively* needs to:
 - solve a system of equations
    - set up the Jacobian of the system
        - evaluate the equation function of the system itself
            - calculate the derivative of $g^v$
                - evaluate $g^v$
                    - calculate $J_g$
                        - evaluate $g$

**What is the cost of this computation?**
Taking a system with $b$ bodies and $c$ constraints:
 - solve a system of equations: $O(1)$ as the Newton solver converges quickly, in ASC-ODE within 10 steps
 - set up the Jacobian of the system: $O((b + c)^2)$ evaluations of the equation function (using numerical differentiation)
 - evaluate the equation function of the system itself: $O(b + c)$, one system of equations for every body and constraint
 - calculate the derivative of $g^v$: $O((b + c)^2)$
 - Evaluate $g^v$: evaluate $J_g$ once
 - calculate $J_g$: $O(b+c)$
 - evaluate $g$: $O(1)$

This makes for a total cost of $O((b+c)^6)$ for every step.

However, already the most minimal setup including a beam has proven to be rather computationally expensive.
Apart from that, further tests will have to be made on whether or not more than one beam or beams of length zero are feasible.

Adding to that, it can be recommended to take additional measures to stabilize the algorithm when using constraints.
