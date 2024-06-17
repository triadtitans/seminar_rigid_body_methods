# Constraints

In addition to $B^TB = I$, other constraints can be formulated to describe beams connecting two bodies (or a body and a point in space).
Anchorpoints can also be implemented that way (as beams of length zero).

As with springs, the starting point are two points $x_1$, $x_2$ in different systems of inertia.
If $U_1(x_1)$ and $U_2(x_1)$ denote their position in the global system of, then the aim is to keep
$\| U_1(x_1) - U_2(x_2) \|$ constant.
This makes for a massless beam.

## Primary constraints

The first approach is to calculate the length at starting time $l_0 = \| U_1(x_1(t_0)) - U_2(x_2(t_0)) \|$.
At every step, the system can then be forced to fulfill $l_0 = \| U_1(x_1) - U_2(x_2) \|$.

This is a constraint that only depends on the state $q$ of the global Lagrangian of the system.



```{admonition} TODO
jupyter(lite) example
```
