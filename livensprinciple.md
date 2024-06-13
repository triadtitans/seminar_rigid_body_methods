# Livens principle
This section will introduce livens principle, show that it is equivalent to the Lagrangian approach of mechanics
and explain how it is used in our integrator. First however we need some background on conjugate momenta and the configuration manifold.

## Conjugate Moment $p$
If we consider a mechanical system described in some minimal coordinates $\mathcal{Q}$, we
know the lagrangian takes the form

$$
    L: 
        \begin{cases} 
            \mathcal{Q}\times \mathcal{Q} \to \mathbb{R}\\ 
            (q,v) \mapsto T(v)-U(q)
        \end{cases}
$$

And it has already been established that the path $q: \mathbb{R} \to \mathcal{Q}$ taken by the system
follows the euler lagrange equation. In order to move from lagrangian to hamiltonian mechanics
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
This definition obviously requires that the map $v \mapsto p(q,v)$ is invertibly for every $q\in\mathcal{Q}$.
Such an inverse assigns a velocity $v$ to a pair of position and conjugate moment and is called Legendre Transform.
{cite}`hairer{p.p. 181, 182}`. Having conjugate momenta to our disposal we can formulate hamiltions 
canoncial equation of motion:

$$
    \dot{p} = -\frac{\partial H}{\partial q}(p,q) \quad
    \dot{q} = \frac{\partial H}{\partial p}(p,q)
$$
It can be shown (and is in {cite}`hairer`) that these equations are equivalent to the now already
familiar euler lagrangian equation.

As we discuss the livens principle these conjugate momenta will resurface. But before that we have
to adjust our theory a little bit in order to accommodate constrained systems. Untial now 
the configuration space $\mathcal{Q}$ was always choosen minimally, this means that 
postion, velocity and conjugate moment all live in the same space $\mathcal{Q}$. If the
coordinates however are not choosen minimally this generally has not to be the case.

## Configuration Manifold $\mathcal{Q}$

The mechanical system we are modelling consists of $N$ rigid bodies, each having 6 degrees of freedom. The
3 cartesian coordinates and the three axes of rotation respectively. This would suggest the following
minimal  configuration space

$$
    \mathcal{Q_{\text{min}}} = \mathbb{R}^{6N}.
$$

But in this minimal coordinates, the rotation of a body is rather hard to work with. It would be preferable if
the rotation was represented as matrix $B\in\mathbb{R}^{3\times3}$. As in

$$
    \tilde{\mathcal{Q}} = (\mathbb{R}^{3}\times\mathbb{R}^{3\times3})^N.
$$

The position of body at a Time $t$ should be given as a translation vector $a\in\mathbb{R}^3$ and 
a rotation matrix $B\in\mathbb{R}^{3\times3}$. This means that we have to restrict $\mathcal{Q}$ to only allow
such matrices:

$$
    \mathcal{Q} = \{(a,B) \in \mathbb{R}^{3}\times\mathbb{R}^{3\times3} \mid B^TB=I \}^N
$$

Finally $\mathcal{Q}$ is a (sub)manifold  (of $\tilde{\mathcal{Q}}$) given trough the condition $g(q)=0$, where 

$$
    g: 
        \begin{cases} 
            \tilde{\mathcal{Q}} \to \mathbb{R} \\ 
            (a,B) \mapsto B^TB-I 
        \end{cases}
$$

This manifold is of course $SE(3)$.
Now we can speak about the postion of a body (or a whole system of bodies), the next step is to investigate
how velocities should be treated. Given a path $q : \mathbb{R} \to \mathcal{Q}$
the velocity is time derivative of the position $ v = \dot{q} $. This means at every time $t$ 

```{math}
    v(t) \in T_{q(t)}\mathcal{Q}
```

Here $T_q\mathcal{Q}$ is the tangential space of $\mathcal{Q}$ in point $q$. Now we can define the tangent bundle
$T\mathcal{Q} = \{(q,v) \mid q\in\mathcal{Q},\; v \in  T_q\mathcal{Q} \} $ 
and the lagrangian of our system as a function of the following form.
```{math}
    L: 
        \begin{cases} 
            {T\mathcal{Q}} \to \mathbb{R} \\
            (q,v) \mapsto T(v)-U(q)
        \end{cases}
```
Note the different domain as compared to the lagrangian for minimal coordinates. 

The conjugate momenta are given trough the legendre transform via $p=\frac{\partial}{\partial v}L(q,v)$.
For every $v\in T_q\mathcal{Q}$ this derivative can be understood as linear map $T_q \to \mathbb{R}$
and therefore as a functional in the dual space of the tangent space $p=\in T^*_q$. Analgous
to the tanget bundle we also introduce the cotangent bundle
$T^*\mathcal{Q} = \{(p,q) \mid q\in\mathcal{Q},\; p \in  T^*_q\mathcal{Q} \}$. Both the 
tangent and cotanget bundle can also be described via a constraint analogous to $\mathcal{Q}$.

## Action Integral $\mathcal{S}$


In order to apply Variational Integration to the mechanics of this rigid body system we have to specify an action functional to be varied and extremized. Normally this is the Integral over the Lagrangian as in {eq}`test`

```{math}
    :label: test
    \label{actionintegral}
    \mathcal{S}(q) = \int_{t_0}^{T} L(q,\dot{q}) \,dt.
```

Where $L:T\mathcal{Q}\to \mathbb{R}$ ist the Lagrangian given through $L(q,\dot{q})=T(\dot{q})+U(q)$,
$T$ and $U$ beeing the kinetic and potential energy respectivley. Note that $T$ depends only on $\dot{q}$ and $U$ only on $q$.

Livens orinciple however describes an alternative action functional to be extremized. {cite}`Kinon2023` 
This reads as follows

$$
    \mathcal{S}(q,v,p) = \int_{t_0}^{T} L(q,v) + p(\dot{q}-v) \,dt.
$$(livens)

Note the two additonal indepent variables $v\in T \mathcal{Q}$ and $p \in T^{*} \mathcal{Q}$. Where $T\mathcal{Q}$,
$T^*\mathcal{Q}$ are the tangent and cotanget bundle.

This functional can be understood as a Lagrianan with constraint $\dot{q}-v$ and corresponding lagrangian multipliers $p$. 
These lagrangian multiplies can later be identified as the conjugate momenta of the system.


## Varying $\mathcal{S}$
In this section we show that by varying $\mathcal{S}$ we can obtain the Euler-Lagrange equations.

We vary $\mathcal{S}$ we respect to each individual variable seperatly.
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
Now we integrate partially using the $\delta q(0)=\delta q(T)=0$ assumption:
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
Trough variation of $v$ and $p$ in a similiar fashion we obtain:

$$
\frac{\partial L}{\partial v} = 
            p 
\quad\quad
            \dot{q}=v \\
$$
At this point we c an identify $p$ as the conjugate momentum. Combining this equation we
receive the Langrage Euler equation.

$$
\frac{\partial L}{\partial q}(q,v) = \frac{\partial L}{\partial q}(q,\dot{q}) =
            \dot{p}(q,\dot{q}) =  \frac{d}{dt}\frac{\partial L}{\partial v}(q,\dot{q})\\
$$
Now we have shown that the functional {eq}`livens` describes the same system as the Lagrangian. For
a more in depth investigation of the properties of th livens principle see {cite}`Kinon2023`.klinon