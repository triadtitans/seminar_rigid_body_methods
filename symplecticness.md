# Symplecticness
In this chapter we focus on the important property of symplecticness of maps.
At first a general definition of symplecticness of smooth maps is given, then its importance to mechanical systems and a geometric interpretation follow. {cite}`Reich` {cite}`hairer`

## Symplecticnes of smooth mappings

Symplecticness is defined by so called Structure Matrices in $\mathbb{R}^{2d \times 2d}$, which can and will be in our case, a skew-smmetric, bilinear form.
Such a form can be described by a Matrix $J$ and gives the following definition.

A linear map $L: \mathbb{R}^{2d} \rightarrow \mathbb{R}^{2d}$ is called symplectic with regard to the structure matrix $J$ if 

$$
L^{T}JL = J 
$$

A differential map $\varphi: \mathbb{R}^{2d} \rightarrow \mathbb{R}^{2d}$ is called symplectic with regard to the structure matrix $J$ if the jacobian Matrix $\varphi'(p,q)$ is symplectic

$$
\varphi'(p,q)^{T}J\varphi'(p,q)
$$

On our phase space $\mathbb{R}^{2d}$ a skew-symmetric, bilinear form $\Omega$ is induced by the matrix

$$
J = \begin{pmatrix}
              0 & I_{d}\\
              -I_{d} & 0\\
          \end{pmatrix} \in \mathbb{R}^{2d \times 2d}
$$

For $d = 1, \Omega(\xi, \eta) = \xi^p \eta^q - \xi^q\eta^p$ as the oriented area of the parallogram spanned by $\xi = \begin{pmatrix}
\xi^q \\
\xi^p
\end{pmatrix}$ and $\eta = \begin{pmatrix}
\eta^q \\
\eta^p
\end{pmatrix}$. In higher dimensions we get the sum of the oriented Areas of the Projections onto the coordinate planes $(q_i, p_i)$, by

$$
\Omega(\xi, \eta) = \sum_{i=1}^{d} \xi^{p}_i \eta^{q}_i - \xi^{q}_i\eta^{p}_i
$$

We now consider a 2-dimensional sub manifold $M$ of $\mathbb{R}^{2d}$, given by a parameterization as $M = \psi(K), K \subset \mathbb{R}^{2}$, with $\psi(s, t)$ being a continously differentiable function.
We can then consider M as the limit of a union of small parallelograms spanned by

$$
\frac{\partial \psi}{\partial s}(s, t)ds\ \text{and}\ \frac{\partial \psi}{\partial t}(s, t)dt
$$ 

For one such parallelogram we consider now the sum over the Projections as given above and get as the limit

$$
\int_M \Omega = \iint_K \Omega(\frac{\partial \psi}{\partial s}(s, t), \frac{\partial \psi}{\partial t}(s, t)) \,ds\,dt
$$

If we now take a symplectic mapping $\varphi: \mathbb{R}^{2d} \rightarrow \mathbb{R}^{2d}$ we get that

$$
\varphi^*\Omega(\xi, \eta) := \Omega(\varphi'(p,q)\xi, \varphi'(p,g)\eta) = \Omega(\xi, \eta) 
$$

accordingly to the definition before. And therfore also

$$
\int_M \Omega = \iint_K \Omega(\varphi'(p,q)\frac{\partial \psi}{\partial s}(s, t), \varphi'(p,q)\frac{\partial \psi}{\partial t}(s, t)) \,ds\,dt
$$

For $d = 1$ this implies the conservation of area under a symplectic map and for $d > 1$ the conservation of a sum of oriented areas of projections of $M$ on to the $(q_i , p_i)$-coordinate planes.

## The wedge product

The above definitions for symplecticness of a given map is not very convenient which is why we will derive now a different approach with the wedge product.
We consider the parial derivative of a function f as

$$
df(\xi) = \sum_{i=1}^{n} \frac{\partial f}{\partial z_1}dz_i(\xi)
$$

with $dz_i(\xi) = \xi_i$. If we now apply a map $\varphi: \mathbb{R}^{n} \rightarrow \mathbb{R}^{n}$ we can define 

$$
\hat{z} = \varphi(z)\ and \ \hat{f}(z) = f(\hat{z}) = f(\varphi(z))
$$

and get 

$$
d\hat{f} = \sum_{i=1}^{n} \sum_{j=1}^{n} \frac{\partial f}{\partial \hat{z}_j}\frac{\partial \varphi}{\partial z_i}dz_i
= \sum_{i=1}^{n} \frac{\partial f}{\partial \hat{z}_j}d\hat{z}_j
$$

with $d\hat{z}_j = \sum_{i=1}^{n}{\frac{\partial \varphi}{\partial z_i}dz_i}$ and $d\hat{z} = \varphi_z(z)\cdot{d_z}$

We can rewrite the bilinear from from above as

$$
\Omega(\xi, \eta) = \sum_{i=1}^{d}[dp_i(\xi)dq_i(\eta) - dq_i(\xi)dp_i(\eta)] = \sum_{i=1}^{d} dq_i \land dp_i = dq \land dp
$$

The symplecticnes of $\varphi$ now reduces to the statement

$$
dq \land dp = d\hat{q} \land d\hat{p},\ \ (\hat{q}, \hat{p}) = \varphi(q,p) 
$$

For the wedge product some useful prperties are known which make claculations easier

1. Skew-symmetry
2. Bilinearity
3. Rule of Matrix multiplication:

$$
dq \land (Adp) = (A^{T}dq) \land dp
$$

4. Followed by 1. and 3.

$$
dq \land (Adq) = 0
$$
if A is a symmetric matrix.

We now have a bunch of tools to check if maps are symplectic.
For more details on the wedge-product, differential 1-forms and symplecticness, see {cite}`Reich`.
