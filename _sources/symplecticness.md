# Symplecticness
In this chapter we focus on the important property of symplecticness of maps.
At first a general definition of symplecticness of smooth maps is given, its importance to mechanical systems and a geometric interpretation and.

## Symplecticnes of smooth mappings
Symplecticness is defined by so called two-forms on \mathbb{R}^{2d}, which is a skew-smmetric, bilinear form.
Such a form can be described by a Matrix $J$ and gives the following definition.

A linear map $L: \mathbb{R}^{2d} \rightarrow \mathbb{R}^{2d}$ is called symplectic with regard to the structure matrix $J$ if 

$$
L^{T}JL = J 
$$

A differential map $\varphi: \mathbb{R}^{2d} \rightarrow \mathbb{R}^{2d}$ is called symplectic with regard to the structure matrix $J$ if the jacobian Matrix $\varphi'(p,g)$ is symplectic

$$
\varphi'(p,g)^{T}J\varphi'(p,g)
$$

On our phase space $\mathbb{R}^{2d}$ a symplectic two form $\Omega$ is induced by the matrix

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
\Omega(\xi, \eta) = \sum_{i=1}^{d} 2^{-n}
\xi^{p}_i \eta^{p}_i - \xi^{q}_i\eta^{p}_i
$$




