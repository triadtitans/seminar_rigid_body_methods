# A Brief Overview of Lagrangian Mechanics

In this section we give a brief overview of lagrangian approach to mechanics, as later chapter require some of its
concepts or terminology. For a more in depth explaination with lively examples see e.g. {cite}`Morin_2008`.
In order to model mechanical system, like a mass on spring, one possibilty 
would be, to determine all forces action on the system and then use Newton's Laws of Motion
to determine the equation(s) of motion. That is the (system of) differential equation(s) which 
the motion of the system fullfills. As motion of the system we understand a function $q: [t_0,\infty)\to\mathcal{Q}$
which maps each point in time to a state $q\in\mathcal{Q}$ of the system. This process is however
ardous and difficult to automize. Luckily there is a better way...

## The Euler-Lagrange Equation

Given a mechanical system in some minimal coordinates $\mathcal{Q}$, this means each $q\in\mathcal{Q}$
correspond to one possible state of the system. For a example a pendulum on a rod could be
modeled with $\mathcal{Q} = [0,2\pi)$ or a mass in space with $\mathcal{Q} = \mathbb{R}^3$.
We search for a method to 
 generate the equations of motions, which are then integrated numerically, resulting
in a function $q: [t_0,\infty)\to\mathcal{Q}$. This function predicts the behaivour of a system at times
after $t_0$. While it is difficult to analyze all acting forces it is generally easy, given
a positon $q\in\mathcal{Q}$ and a velocity $\dot{q}\in\mathcal{Q}$ at a point $t\in\mathbb{R}$ in time to calculate 
the kinetic energy $K: \mathcal{Q} \to \mathbb{R}$ and the potential energy $U: \mathcal{Q} \to \mathbb{R}$.

So we define the Lagrangian as follow:

$$
    L: 
        \begin{cases} 
            \mathcal{Q}\times \mathcal{Q} \to \mathbb{R}\\ 
            (q,v) \mapsto T(v)-U(q)
        \end{cases}
$$

The Lagrangian depends on two values the position and the velocity. Having a Lagrangian we can 
formulate the Euler-Lagrange equations: Let $q: [t_0,\infty)\to\mathcal{Q}$ q describes the motion 
of the system with Lagrangian $L$ iff following differential equations holds:

$$
\frac{\partial L}{\partial q}(q(t),\dot{q}(t)) =  \frac{d}{dt}\frac{\partial L}{\partial v}(q(t),\dot{q}(t))\\
$$

Now the usefullnes of the Lagrangian approach becomes clear. Given a mechanical system it is easy to calculate
the Lagrangian, the resulting Euler-Lagrange Equation can than be numerically solved.

## The Principle Of Stationary Action

Although the Euler-Lagrange equations are sufficent to calculate the motion of the system, they seem
a bit arbitrary. Therefore we want add a little bit of background and expand on a larger principle,
as a bonus we gain a new approach for integration the Euler-Lagrange Equation numerically.

Consider following functional:

```{math}
    :label: action
    \mathcal{S}(q) = \int_{t_0}^{T} L(q(t),\dot{q}(t)) \,dt.
```
This is called the action of the mechanical system we are modeling. The Principle of Stationary Action
states, that the motion $q: [t_0,\infty)\to\mathcal{Q}$ of the system is a stationary point of this 
functional. This means that for small variations $q+\varepsilon\cdot\delta q$ where 
$\delta q : [t_0,\infty)\to\mathcal{Q}$ with $\delta q(t_0)=\delta q(T)=0$, the
action fullfills $\mathcal{S}(q+\delta q) >= \mathcal{S}(q)$. (Or the reverse equation).

With mathematical tools from the calculus of variations it can be shown, that such stationary points
are exactly given by the Euler-Lagrange equation. A similar calculation is shown in the chapter
on Livens Principle. On a side note, while we focus in this project
only on simple mechanical systems this Stationary Action Principle plays a much larger and wider 
role in physics.

Now instead of deriving the (differntial) equations of motion from the stationary action principle 
and solving them numerically, one could try to replace the integral in {eq}`action` trough a
finite sum. When performing similar calculations as in derivation of the Euler-Lagrange equation
but in a discrete manner, one obtains a discrete analogon to the Euler-Lagrange. This approach
is followed by variational integrators. {cite}`hairer`
