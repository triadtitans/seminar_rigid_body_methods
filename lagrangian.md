# A Brief Overview of Lagrangian Mechanics

In this section we give a brief overview of the Lagrangian approach to mechanics, as later chapters require some of its
concepts and terminology. For a more in-depth explanation with lively examples see e.g. {cite}`Morin_2008`.
In order to model a mechanical system, like a mass on a spring, one possibilty
would be to determine all forces acting on the system and then use Newton's laws of motion
to determine the equation(s) of motion. The latter is/are the (system of) differential equation(s) which describe(s)
the motion of the system. As motion of the system we understand a function $q: [t_0,\infty)\to\mathcal{Q}$
which maps each point in time to a state $q\in\mathcal{Q}$ of the system. However, this process is
arduous and difficult to automate. Luckily, there is a better way...

## The Euler-Lagrange Equation

Given a mechanical system in some minimal coordinates $\mathcal{Q}$, this means each $q\in\mathcal{Q}$
corresponds to one possible state of the system. For example, a pendulum on a rod could be
modelled with $\mathcal{Q} = [0,2\pi)$ or a mass in space with $\mathcal{Q} = \mathbb{R}^3$.
We search for a method to 
 generate the equations of motion, which are then integrated numerically, resulting
in a function $q: [t_0,\infty)\to\mathcal{Q}$. This function predicts the behaviour of a system
after the starting time $t_0$. While it is difficult to analyze all acting forces, it is generally easy, given
a positon $q\in\mathcal{Q}$ and a velocity $\dot{q}\in\mathcal{Q}$ at a point $t\in\mathbb{R}$ in time to calculate 
the kinetic energy $K: \mathcal{Q} \to \mathbb{R}$ and the potential energy $U: \mathcal{Q} \to \mathbb{R}$.

So we define the Lagrangian as follows:

$$
    L: 
        \begin{cases} 
            \mathcal{Q}\times \mathcal{Q} \to \mathbb{R}\\ 
            (q,v) \mapsto T(v)-U(q)
        \end{cases}
$$

The Lagrangian depends on two values: the position and the velocity. Having a Lagrangian, we can
formulate the Euler-Lagrange equations: Let $q: [t_0,\infty)\to\mathcal{Q}$ describe the motion
of the system with Lagrangian $L$. Then the following differential equation holds:

$$
\frac{\partial L}{\partial q}(q(t),\dot{q}(t)) =  \frac{d}{dt}\frac{\partial L}{\partial v}(q(t),\dot{q}(t))\\
$$

Now the usefulness of the Lagrangian approach becomes clear. Given a mechanical system it is easy to calculate
the Lagrangian. The resulting Euler-Lagrange equation can then be numerically solved.

## The Principle Of Stationary Action

Although the Euler-Lagrange equations are sufficient to calculate the motion of the system, they seem
a bit arbitrary. That is why we want to add a little bit of background and expand on a larger principle.
As a bonus we gain a new approach for integrating the Euler-Lagrange equation numerically.

Consider the following functional:

```{math}
    :label: action
    \mathcal{S}(q) = \int_{t_0}^{T} L(q(t),\dot{q}(t)) \,dt.
```
This is called the action of the mechanical system we are modelling. The principle of stationary action
states that the motion $q: [t_0,\infty)\to\mathcal{Q}$ of the system is a stationary point of this
functional. This means that for small variations $q+\varepsilon\cdot\delta q$ where 
$\delta q : [t_0,\infty)\to\mathcal{Q}$ with $\delta q(t_0)=\delta q(T)=0$, the
action fulfills $\mathcal{S}(q+\delta q) \geq \mathcal{S}(q)$. (Or $\mathcal{S}(q+\delta q) \leq \mathcal{S}(q)$.)

With mathematical tools from the calculus of variations it can be shown that such stationary points
are exactly given by the Euler-Lagrange equation. A similar calculation is shown in the chapter
on the Livens principle. On a side note, while this project focuses
only on simple mechanical systems, this stationary action principle plays a much larger
role in physics.

Now instead of deriving the (differential) equations of motion from the stationary action principle
and solving them numerically, one could try to replace the integral in {eq}`action` through a
finite sum. When performing similar calculations as in the derivation of the Euler-Lagrange equation
but in a discrete manner, one obtains a discrete analogon to the Euler-Lagrange equations. This approach
is followed by variational integrators. {cite}`hairer`
