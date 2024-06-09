# Livings Principle 
The mechanical system we are modeling is consisting of $N$ rigid bodies, each having 6 degrees of freedom. The
3 cartesian coordinates and the three axes of rotation respectivley. This would suggest the following state space

\begin{equation}
    \tilde\mathcal{Q} = \mathbb{R}^{6N}.
\end{equation}

But instead we use the following space

\begin{equation}
    \mathcal{Q} = (\mathbb{R}^{3}\cross\mathbb{R}^{3\cross3})^N.
\end{equation}
This means the position of body at a Time $t$ is given as a translation vector $a\in\mathbb{r}^3$ and 
a rotation matrix $b\in\mathbb{B}^{3\cross3}$. That $B$ is actually a rotation matrix is enforced through 
additional constrainsts explained in a later section.

In order to apply Variational Integration to the mechanics of this rigid body system we have to specify an action functional
to be varied and extremized. Normally this is the Integral over the Lagrangian as in CITE

\begin{equation}
    \mathcal{S}(q) = \int_{t_0}^{T} L(q,\dot{q}) \,dt.
\end{equation}

Where $L:\mathcal\cross\mathcal \to \mathbb{R}$ ist the Lagrangian given through $L(q,\dot{q})=T(\dot{q})+U(q)$, where
$T$ and $U$ are kinetic and potential energy respectivley. Note that $T$ depends only on $\dot{q}$ and $U$ only on $q$.

Livings Principle however describes an alternative action functional to be extremized. {cite}`Kinon2023` 
This reads as follows

\begin{equation}
    \mathcal{S}(q,v,p) = \int_{t_0}^{T} L(q,v) + p*(\dot{q}-v) \,dt.
\end{equation}

Note the two additonal indepent variables $v\in T \mathcal{Q}$ and $p T^{*} \mathcal{Q}$. Where $T\mathcal{Q}$
is the tangential space of \mathcal{Q}.

This functional can be understood as a Lagrianan with constraint 
$\dot{q}-v$ and corresponding lagrangian multipliers $p$. 

