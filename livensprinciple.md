# Livens principle
This section, we will introduce the Livens principle, show that it is equivalent to the Lagrangian approach of mechanics
and explain how it is used in our integrator. Firstly, however, we need some background on conjugate momenta and the configuration manifold.

## Conjugate Moment $p$
If we consider a mechanical system described in some minimal coordinates $\mathcal{Q}$, we
know that the Lagrangian takes the form

$$
    L: 
        \begin{cases} 
            \mathcal{Q}\times \mathcal{Q} \to \mathbb{R}\\ 
            (q,v) \mapsto T(v)-U(q)
        \end{cases}
$$

In addition, it has already been established that the path $q: \mathbb{R} \to \mathcal{Q}$ taken by the system
fulfills the Euler-Lagrange equation. In order to move from Lagrangian to Hamiltonian mechanics
one defines the conjugate momenta as follows:

$$
    p = \frac{\partial}{\partial v}L(q,v)
$$

This assigns to every possible state of the system $(q,v)\in \mathcal{Q}\times \mathcal{Q} $ a conjugate moment 
$p(q,v)$. This allows us to define the Hamiltonian of the system

$$
    H: 
        \begin{cases} 
            \mathcal{Q}\times \mathcal{Q} \to \mathbb{R}\\ 
            (p,q) \mapsto p^T\dot{q} - L(q,\dot{q})
        \end{cases}
$$
This definition obviously requires that the map $v \mapsto p(q,v)$ is invertible for every $q\in\mathcal{Q}$.
Such an inverse assigns a velocity $v$ to a pair of position and conjugate moment and is called Legendre transform.
(See the section on the mass matrix){cite}`hairer{p.p. 181, 182}`
Having conjugate momenta to our disposal, we can formulate Hamilton's canonical equation of motion:

$$
    \dot{p} = -\frac{\partial H}{\partial q}(p,q) \quad
    \dot{q} = \frac{\partial H}{\partial p}(p,q)
$$
It can be shown {cite}`{and is in}hairer` that these equations are equivalent to the now already
familiar Euler-Lagrange equation.

As we discuss the Livens principle, these conjugate momenta will resurface. But before that, we have
to adjust our theory a little bit in order to accommodate constrained systems. Until now,
the configuration space $\mathcal{Q}$ was always chosen minimally.
This means that positions, velocities and conjugate momenta all live in the same space $\mathcal{Q}$. However, if the
coordinates are not minimal, this is generally not the case.

## Configuration Manifold $\mathcal{Q}$

The mechanical system we are modelling consists of $N$ rigid bodies, each having 6 degrees of freedom; the
three cartesian coordinates and the three axes of rotation respectively. This would suggest the following
minimal configuration space

$$
    \mathcal{Q_{\text{min}}} = \mathbb{R}^{6N}.
$$

But in these minimal coordinates, the rotation of a body is rather hard to work with. It would be preferable if
the rotation was represented as a matrix $B\in\mathbb{R}^{3\times3}$:

$$
    \tilde{\mathcal{Q}} = (\mathbb{R}^{3}\times\mathbb{R}^{3\times3})^N.
$$

The position of a body at a time $t$ should be given as a translation vector $a\in\mathbb{R}^3$ and
a rotation matrix $B\in\mathbb{R}^{3\times3}$. This means that we have to restrict $\mathcal{Q}$ to only allow
such matrices:

$$
    \mathcal{Q} = \{(a,B) \in \mathbb{R}^{3}\times\mathbb{R}^{3\times3} \mid B^TB=I \}^N
$$

Finally, $\mathcal{Q}$ is a (sub)manifold  (of $\tilde{\mathcal{Q}}$) given by the condition $g(q)=0$, where

$$
    g: 
        \begin{cases} 
            \tilde{\mathcal{Q}} \to \mathbb{R} \\ 
            (a,B) \mapsto B^TB-I 
        \end{cases}
$$

This manifold is of course $SE(3)$.
Now that we have a representation of the position of a body (or a whole system of bodies), the next step is to investigate
how velocities should be treated. Given a path $q : \mathbb{R} \to \mathcal{Q}$
the velocity is the time derivative of the position $ v = \dot{q} $. This means that at every point in time $t$

```{math}
    v(t) \in T_{q(t)}\mathcal{Q}
```

Here $T_q\mathcal{Q}$ is the tangent space of $\mathcal{Q}$ in point $q$. Now we can define the tangent bundle
$T\mathcal{Q} = \{(q,v) \mid q\in\mathcal{Q},\; v \in  T_q\mathcal{Q} \} $ 
and the Lagrangian of our system as a function of the following form.
```{math}
    L: 
        \begin{cases} 
            {T\mathcal{Q}} \to \mathbb{R} \\
            (q,v) \mapsto T(v)-U(q)
        \end{cases}
```
Note the difference in the domain compared to the Lagrangian for minimal coordinates.

The conjugate momenta are given by the Legendre transform via $p=\frac{\partial}{\partial v}L(q,v)$.
For every $v\in T_q\mathcal{Q}$ this derivative can be understood as linear map $T_q \to \mathbb{R}$
and therefore as a functional in the dual space of the tangent space $p \in T^*_q$. As an analogon
to the tangent bundle we also introduce the cotangent bundle
$T^*\mathcal{Q} = \{(p,q) \mid q\in\mathcal{Q},\; p \in  T^*_q\mathcal{Q} \}$. Both the 
tangent and cotangent bundle can also be described via a constraint analogous to $\mathcal{Q}$.

## Action Integral $\mathcal{S}$


In order to apply variational integration to the mechanics of this rigid body system we have to specify an action functional to be varied and extremized. Normally, this is the integral over the Lagrangian as in {eq}`test`

```{math}
    :label: test
    \label{actionintegral}
    \mathcal{S}(q) = \int_{t_0}^{T} L(q,\dot{q}) \,dt.
```

Where $L:T\mathcal{Q}\to \mathbb{R}$ is the Lagrangian given by $L(q,\dot{q})=T(\dot{q})+U(q)$,
$T$ and $U$ being the kinetic and potential energy respectivley. Note that $T$ depends only on $\dot{q}$ and $U$ only on $q$.

The Livens principle, on the other hand, describes an alternative action functional to be extremized. {cite}`Kinon2023`
This reads as follows

$$
    \mathcal{S}(q,v,p) = \int_{t_0}^{T} L(q,v) + p(\dot{q}-v) \,dt.
$$(livens)

Note the two additional independent variables $v\in T \mathcal{Q}$ and $p \in T^{*} \mathcal{Q}$. Where $T\mathcal{Q}$,
$T^*\mathcal{Q}$ are the tangent and cotangent bundle.

This functional can be understood as a Lagrangian with constraint $\dot{q}-v$ and corresponding Lagrangian multipliers $p$.
These Lagrangian multiplies can later be identified as the conjugate momenta of the system.


## Varying $\mathcal{S}$
In this section we show that by varying $\mathcal{S}$ we can obtain the Euler-Lagrange equations.

We vary $\mathcal{S}$ we respect to each individual variable separately.
Let $\delta q \in C^\infty$ be a variation of $q$, so that $\delta q(0)=\delta q(T)=0$. We
define $q^\varepsilon := q+\varepsilon\cdot\delta q $ it follows 
$\dot{q^\varepsilon}=\dot{q}+\varepsilon \cdot \delta \dot{q}$. We substitute 
$q^\varepsilon$ for $q$ in  {eq}`livens` and derivate in $\varepsilon$:

\begin{align}

\frac{d}{d\varepsilon = 0}\mathcal{S}({q^\varepsilon},v,p) 
        =&\; \frac{d}{d\varepsilon = 0}  \int_{t_0}^{T} L(q^\varepsilon,v)\cdot \delta q + p(\dot{q^\varepsilon}-v) \,dt. \\
        =&\;    \frac{d}{d\varepsilon = 0} \int_{t_0}^{T} L( q+\varepsilon\cdot\delta q,v)\cdot \delta q + p(\dot{q}+\varepsilon \cdot 
            \delta \dot{q}-v) \,dt. \\
        =&\;  \int_{t_0}^{T} \frac{\partial L}{\partial q}(q+0\cdot\delta q,v)\cdot \delta q + p\cdot\delta \dot{q} \,dt. \\

\end{align}
Now we integrate partially under the assumption that $\delta q(0)=\delta q(T)=0$:
\begin{align}

 \int_{t_0}^{T} \frac{\partial L}{\partial q}(q,v)\cdot \delta q &+ p\cdot\delta \dot{q} \,dt =\\
        =&\; \int_{t_0}^{T} \frac{\partial L}{\partial q}(q,v)\cdot \delta q \,dt + \int_{t_0}^{T}p\cdot\delta \dot{q}\, dt\\
        =&\;  \int_{t_0}^{T} \frac{\partial L}{\partial q}(q,v)\cdot \delta q \,dt + p\cdot\delta q\bigg|^T_0
            -\int_{t_0}^{T} \dot{p} \cdot \delta q \,dt\\
        =&\; \int_{t_0}^{T} \left(\frac{\partial L}{\partial q}(q,v)
            -\dot{p}\right) \cdot \delta q \,dt\\
\end{align}

As we are searching for a local extremum of $q$ the variation has to be zero, so we have:

$$
\frac{\partial L}{\partial q} = 
            \dot{p} \\
$$
Through variation of $v$ and $p$ in a similar fashion we obtain:

$$
\frac{\partial L}{\partial v} = 
            p 
\quad\quad
            \dot{q}=v \\
$$
At this point we can identify $p$ as the conjugate momentum. Combining these equations we
obtain the Euler-Langrage equation.

$$
\frac{\partial L}{\partial q}(q,v) = \frac{\partial L}{\partial q}(q,\dot{q}) =
            \dot{p}(q,\dot{q}) =  \frac{d}{dt}\frac{\partial L}{\partial v}(q,\dot{q})\\
$$
Now we have shown that the functional {eq}`livens` describes the same system as the Lagrangian. For
a more in-depth investigation of the properties of the Livens principle see {cite}`Kinon2023`.
