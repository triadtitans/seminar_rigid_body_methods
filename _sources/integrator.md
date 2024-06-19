# The Integrator
With Livens Principle and the Lagrangian at our disposal we are now ready to examine the integrator
employed in our project. Trough variation of the livings principle we obtain equations as in [](#livensprinciple)
which we discretize in time. This result in a nonlinear syststem of equations.

We start again with the Livens principle which states that the variation of the action functional {eq}`livens` vanishes and take again the variation with respect to each variable. As shown in the chapter about the livens principle we get 

$$ v=\dot{q}$$

$$ p=\frac{\partial T}{\partial v}(v) $$

For the third equation we have used that the boundary terms from the equation by parts vanished because we hav chosen test function which vanish at $t=0$ and $t=T$. We have then obtained a system of ODEs but now still require initial conditions $q(0)$ and $p(0)$.
Therefore for the variation with respect to $q$ we modify the action integral by adding boundary terms

$$
\int_{0}^{T} T(v) - V(q) + p(\dot{q} - v) \,dt + \hat{p}(0)q(0) - \hat{p}(T)q(T)
$$

We introduce new variables $\hat{p}$ which independent but approximate the same function $p$. If we now take again the variation with respect to $q$ and integration py parts we get 

$$
\int_{0}^{T} (\frac{\partial V}{\partial q}(q)-\dot{q})\delta q \,dt + (p-\hat{p})q\Biggr|_{0}^{T}=0 \ \ \forall \delta q
$$

This equation contains the differential equation in $(0, T)$, and boundary conditions $p(0)=\hat{p}(0)$ and $p(T)=\hat{p}(T)$.

## Numerical Method
We now derive the nurmecial method behind our variational Integrator. 
The Liven's principle including boundary terms can be interpreted as follows:
Given starting values $q(0)$ and $\hat{p}(0)$, we can solve for functions $q, v, p$ on $[0, T]$, and the value $\hat{p}(T)$. At the end-point we take $q(T)$ and th momentum $\hat{p}$. If we now continou on a time intervall $[T, T_2]$ with the initial values $q(T)$ and $\hat{p}(T)$.
Given a time interval $[t_i, t_{i+1}]$ we approximate q\biggr|_{[t_i, t_{i+1}]} by a linear polynomial and the variables $v$ and $p$ by costant functions on $[t_i, t_{i+1}]$. The moments $\hat{p}(t_i)$ are only existing in the point $t_i$.

We now get a time-stepping method propagating $(q(t_i), p(t_i))$ to $(q(t_{i+1}), p(t_{i+1}))$, which we will now specify.

We start with a fixed time interval $[t_i, t_i +h]$ the first Euler-Lagrange equation

$$
\int_{t_i}^{t_i+h} (\dot{q} - v) \delta q \,dt = h(\frac{q_{i+1} - q_i}{h} -v_i) \delta q = 0 \iff \frac{q_{i+1} - q_i}{h} = v_i
$$

In our case we have $q_i = (a_i, B_i), \ q_{i+1} = (a_{i+1}, B_{i+1})$ and we remember that the derivative of the position $\dot{q} = v_i = (v_{a_i}, B_{i+1/2}\hat{v}_i)$ with $B_{i+1/2} \in SO(3)$ and $\hat{v}_i$ being a skew-symmetric matrix. We then get

$$
\frac{1}{h}(a_{i+1}-a_i, B_{i+1} - B_i) = (v_{a_i}, B_{i+1/2}\hat{\omega}_i)
$$

$$
\frac{1}{h}(a_{i+1}-a_i) = v_{a_i}, \ \ \ 3 \ equations
$$

$$
\frac{1}{h}Skew(B_{i+1/2}^{-1}(B_{i+1} - B_i)) = \hat{v}_i, \ \ \ 3 \ equations
$$

Where $\hat{v}_i$ is now the matix $\hat{\omega}$ transformd by the hat-map.

Through the second equation we get

$$
\int_{t_i}^{t_i+h} (\frac{\partial T}{\partial v}(v) - p) \delta v \,dt = \int_{t_i}^{t_i+h} (Mv - p) \delta v \,dt = h(Mv_i -p_i) \delta v = 0 \iff Mv_i = p_i
$$

where the second equality holds because we assume $v$ and $p$ to be constant on $[t_i, t_i +h]$.
