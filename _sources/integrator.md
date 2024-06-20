# The Integrator
With Livens Principle and the Lagrangian at our disposal we are now ready to examine the integrator
employed in our project. Trough variation of the liven's principle we obtain equations as in [](#livensprinciple)
which we discretize in time. This result in a nonlinear syststem of equations.

We start again with the Livens principle which states that the variation of the action functional {eq}`livens` vanishes and take again the variation with respect to each variable. As shown in the chapter about the livens principle we get 

$$ v=\dot{q}$$

$$ p=\frac{\partial T}{\partial v}(v) $$

For the third equation we have used that the boundary terms from the equation by parts vanish because we have chosen test functions which vanish at $t=0$ and $t=T$. We have then obtained a system of ODEs but now still require initial conditions $q(0)$ and $p(0)$.
Therefore for the variation with respect to $q$ we modify the action integral by adding boundary terms

$$
\int_{0}^{T} T(v) - V(q) + p(\dot{q} - v) \,dt + \bar{p}(0)q(0) - \bar{p}(T)q(T)
$$

We introduce the new variables $\bar{p}$ which is independent but approximates the same function $p$. If we now take again the variation with respect to $q$ and integration py parts we get 

$$
\int_{0}^{T} (\frac{\partial V}{\partial q}(q)-\dot{q})\delta q \,dt + (p-\bar{p})q\Biggr|_{0}^{T}=0 \ \ \forall \delta q
$$

This equation contains the differential equation in $(0, T)$, and boundary conditions $p(0)=\bar{p}(0)$ and $p(T)=\bar{p}(T)$.

## Numerical Method
We now derive the nurmecial method behind our variational Integrator. 
The Liven's principle including boundary terms can be interpreted as follows:
Given starting values $q(0)$ and $\bar{p}(0)$, we can solve for functions $q, v, p$ on $[0, T]$, and the value $\bar{p}(T)$. At the end-point we take $q(T)$ and the momentum $\bar{p}$. If we now continou on a time intervall $[T, T_2]$ with the initial values $q(T)$ and $\bar{p}(T)$.
Given a time interval $[t_i, t_{i+1}]$ we approximate $q\biggr|_{[t_i, t_{i+1}]}$ by a linear polynomial and the variables $v$ and $p$ by costant functions $p_i$ and $v_i$ on $[t_i, t_{i+1}]$. The moments $\bar{p}(t_i)$ are only existing in the point $t_i$.

We now get a time-stepping method propagating $(q(t_i), p(t_i))$ to $(q(t_{i+1}), p(t_{i+1}))$, which we will now specify.
For the Method we will use the fact that we can write the velocity and impulse as $v_i = (v_{a_i}, B_{i+1/2}v_{rot_i})$ and $p_i = (p_{a_i}, B_{i+1/2}p_{rot_i})$ where $v_{rot_i}$ and $p_{rot_i}$ denot skew-symmetric matrices.
We start with a fixed time interval $[t_i, t_i +h]$ the first Euler-Lagrange equation

$$
\int_{t_i}^{t_i+h} (\dot{q} - v) \delta q \,dt = h(\frac{q_{i+1} - q_i}{h} -v_i) \delta q = 0 \iff \frac{q_{i+1} - q_i}{h} = v_i
$$

In our case we have $q_i = (a_i, B_i), \ q_{i+1} = (a_{i+1}, B_{i+1})$ then get

$$
\frac{1}{h}(a_{i+1}-a_i, B_{i+1} - B_i) = (v_{a_i}, B_{i+1/2}v_{rot_i})
$$

$$
\frac{1}{h}(a_{i+1}-a_i) = v_{a_i}, \ \ \ 3 \ equations
$$

$$
\frac{1}{h}Skew(B_{i+1/2}^{-1}(B_{i+1} - B_i)) = \hat{v}_{rot_i}, \ \ \ 3 \ equations
$$

Where $\hat{v}_{rot_i}$ is now the matix $v_{rot_i}$ transformd by the hat-map. From now on we only consider $\hat{v}_i = (v_{a_i}, \hat{v}_{rot_i})$ as our velocity and $\hat{p}_i = (p_{a_i}, \hat{p}_{rot_i})$ with $\hat{p}_{rot_i}$ as the skew symmetric part of $p_{rot_i}$ as our momentum. Accordingly we also use the notation $\hat{\bar{p}}_i$ for $\bar{p}_i$.

Through the second equation we get

$$
\int_{t_i}^{t_i+h} (\frac{\partial T}{\partial v}(v) - p) \delta v \,dt = \int_{t_i}^{t_i+h} (Mv - p) \delta v \,dt = h(Mv_i -p_i) \delta v = 0 \iff \frac{\partial T}{\partial v}(v) = Mv_i = p_i
$$

where the second equality holds because we assume $v_i$ and $p_i$ to be constant on $[t_i, t_i +h]$. And get with our new notaion

$$
M\hat{v}_i = \hat{p}_i\ \ \ 6 \ equations
$$


The last equation is a bit more complicated to integrate

$$
\int_{0}^{T} (\frac{\partial V}{\partial q}(q)-\dot{q})\delta q \,dt + (p-\bar{p})q\Biggr|_{0}^{T}=0 \ \ \forall \delta q
$$

We us the trapezoidal-rule for $\frac{\partial V}{\partial q}(q)$ and integrate the rest to get

$$
p_i(\delta q_{i+1} - \delta q_i) + \frac{h}{2}(\frac{\partial V}{\partial q}(q_i) \delta q_i + \frac{\partial V}{\partial q}(q_{i+1}) \delta q_{i+1}) - \bar{p}_i \delta q_{i+1} + \bar{p}_i \delta q_i = 0
$$

This equation is then split up into 

$$
(\frac{h}{2}\frac{\partial V}{\partial q}(q_i) + \bar{p}_i - p_i)\delta q_i) 0 = \iff (\frac{\bar{p}_i - p_i}{h/2}) = -\frac{\partial V}{\partial q}(q_i)
$$

and following the same principle

$$
(\frac{h}{2}\frac{\partial V}{\partial q}(q_{i+1}) + p_i - \bar{p}_{i+1})\delta q_{i+1}) 0 = \iff (\frac{p_i - \bar{p}_{i+1}}{h/2}) = -\frac{\partial V}{\partial q}(q_{i+1})
$$

If we now replace erverything with our skew-symmetric notation we derive

$$
\frac{\bar{p}_{a_i} - p_{a_i}}{h/2} = f_{trans}(q_{i})\ \ \ 3 \ equations
$$

$$
\frac{{p}_{a_i} - \bar{p}_{a_{i+1}}}{h/2} = f_{trans}(q_{i+1})\ \ \ 3 \ equations
$$

$$
Skew(B_i^T(\frac{B_i\bar{p}_{rot_i}-B_{i+1/2}p_{rot_i}}{h/2} - f_{rot}(q_{i}))) = 0\ \ \ 3 \ equations
$$

$$
\ Skew(B_{i+1}^T(\frac{B_{i+1/2}p_{rot_i} - B_{i+1}\bar{p}_{rot_{i+1}}}{h/2} - f_{rot}(q_{i+1}))) = 0\ \ \ 3 \ equations
$$

And last but not least we have to make sure that $B_{i+1}$ is a rotation matrix

$$
B_{i+1}^T B_{i+1} = I\ \ \ 6 \ equations
$$

We now count the unknowns. We have given $q_i, \ \bar{p}_i$ and would like to find $q_{i+1}, \ \bar{p}_{i+1}$. As we have seen we actually just need to find $q_{i+1}, \ \hat{\bar{p}}_{i+1}$ ($12$ and $6$ variables) for which we need to find $\hat{v}_i, \ \hat{p}_i$ which have $6$ and $6$ variables. All together we have $30$ unknowns and $30$ variables.