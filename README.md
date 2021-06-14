# Topology optimization of lattice materials with nonlinear elasticity law
Project repository for *Numerical Analysis for Partial Differential Equations* - A.Y. 2020-2021

- Teresa Babini (teresa.babini@mail.polimi.it)
- Manfred Nesti (manfred.nesti@mail.polimi.it)

For the implementation we used `FreeFem++`, which is an open source programming language based on `C++`, focused on solving partial differential equations using the finite element method. To install `FreeFem++` and for the documentation you can refer to [FreeFem++ documentation](https://doc.freefem.org/documentation/index.html).

## Nonlinear method

In `nonlinear/` you can find the software we developed to solve the nonlinear unit cell optimization problem. This is the graph showing the dependencies bewteen files

<img src='https://g.gravizo.com/svg?digraph%20G%20%7B%0A%20%20edge%20%5Bstyle%20%3D%20dashed%5D%0A%20%20%22run.sh%22%20-%3E%20%22main.edp%22%0A%20%20edge%5Bstyle%20%3D%20normal%5D%0A%20%20%22main.edp%22%20-%3E%20%22constraints.edp%22%3B%0A%20%20%22main.edp%22%20-%3E%20%22params.edp%22%3B%0A%20%20%22params.edp%22%20-%3E%20%22print_params.edp%22%3B%0A%20%20%22main.edp%22%20-%3E%20%22macros.edp%22%3B%0A%20%20%22main.edp%22%20-%3E%20%22J.edp%22%3B%0A%20%20%22main.edp%22%20-%3E%20%22gradJ.edp%22%3B%0A%20%20%22main.edp%22%20-%3E%20%22makemetrica.edp%22%3B%0A%20%20subgraph%20cluster_adaptmesh%20%7B%0A%20%20%20%20label%20%3D%20%22adaptmesh%22%0A%20%20%20%20%22makemetrica.edp%22%20-%3E%20%22sparse2full.edp%22%3B%0A%20%20%20%20%22makemetrica.edp%22%20-%3E%20%22makepatch.edp%22%3B%0A%20%20%7D%0A%20%20subgraph%20cluster_cost_function%20%7B%0A%20%20%20%20label%20%3D%20%22cost_function%22%0A%20%20%20%20%22J.edp%22%20-%3E%20%22primal.edp%22%3B%0A%20%20%20%20%22J.edp%22%20-%3E%20%22newton.edp%22%3B%0A%20%20%20%20%22gradJ.edp%22%20-%3E%20%22dual.edp%22%3B%0A%20%20%7D%0A%7D%0A
'>

- **`params.edp` & `print_params.edp`**:
This is the module you can use to set your parameters for the simulation.
In the load section you can decide if to start a simulation from scratch of if or to load a previously computed density (and its mesh) to start from that point. If you use the first option, you need to give an initial density that you can hard-code or set randomly, otherwise you need to give the path and the index of the density you want to load.
In the params section you can specify the desired Poisson's ratio nu and Young coefficient E of the base material you want to use. Notice that the lambda (`L`) coefficient is computed using the 2D formula since we are using 2D materials. In this section you can also set the target Poisson's ratio `nutarget` you want to obtain.
In the spaces sections you find the spaces for the density (simple of periodic), for the displacements and for the constraints on the area.
The `print_params.edp` module helps you taking track of your tuning trials, printing in the `output.txt` file all the parameters you have chosen.

- **`macros.edp`**:
This module contains all the macro definitions we need in the simulation, like the gradient of a vector, the deformation gradient and the Green-Lagrange strain tensor, the second Piola-Kirchhoff stress tensor and so on. In the previous section you can find all their definitions and other more variables.

- **`constraints.edp`**:
This module contains the functions which return the volume constraints in the format `IPOPT` is able to use. These functions are indeed directly passed in the `IPOPT` call in `main.edp`

- **`cost_function/ folder`**:
This module contains the submodules related to the cost function J and its gradient (see `J.edp` and `gradJ.edp`), which respectively contains the primal problem (to be solved iteratively using the Newton's method) and the dual problem (see `primal.edp`, `dual.edp` and `newton.edp`).

- **`adaptmesh/ folder`**:
This folder contains some modules used to create the metric that `FreeFem++` fucntion `adaptmesh` reads to perform the grid adaptation.

- **`run.sh`**:
To start a simulation you need to run this script with `./run.sh`. This script creates a new folder in `nonlinear/results` named with the current timestamp, it runs `main.edp` also saving all the output in `output.txt` which it moves in the current simulation folder, together with all the other `FreeFem++` outputs of the simulation, .

- **`main.edp`**:
This is the main script which is called by `run.sh`. It includes all the necessary and start the iterative algorithm using the index `ii` for the optimization procedure. The index `jj` is used inside `IPOPT`, which solves many time the primal problem estimating nu and a single time the dual for each `jj`. In the main cycle you can find the power penalty law, the filters and the mesh adaptivity that can be performed also only at some specific iterations (but not at the last one) activating the corresponding `if` condition. During all the optimization (and in particular before and after some filter usage) the density and the meshes are always plotted and saved, moreover, some useful information are printed both in the terminal and in the `output.txt` file.

## Validation tests

During the implementation phase we started from scratch by some simple cases and tests, in order to test step-by-step our work and validate the model. In `tests/` you can find the material related to this topic. This is the graph showing the dependencies between files.

DOT FILE

- **`tensile_linear.edp`**:
The first thing we did was to develop a simple tensile problem in which a rectangular full 2D material (density equal to 1 everywhere) is stretched on the right boundary, free-movement condition characterize top boundary and symmetric BCs are imposed on the other boundaries.
Solved the problem, the Poisson's ratio is computed and we had to find a way to compute the transverse and axial strain valid in the formulation of our optimization problem for a nonlinear material. Therefore, once was done through the `convect` function of `FreeFem++`, more reliable with respect to the physical meaning of the quantity used in the formula but not suited for the derivation of the cost function J, and then with an average of the displacements on the boundaries of interest. These two estimates, with the same imposed right displacement on the right boundary, are saved into `tensile_linear.csv` for variable values of the latter. We can see that, for each values of the imposed displacement, the Poisson's ratio remains the same and that it is the imposed one. Moreover, the Poisson's ratios estimated in the two way coincide.

- **`tensile_nonlinear_FF.edp`**:
After that, we started taking into account the nonlinearity. We started from the example of nonlinear elasticity law provided by `FreeFem++` documentation [here](https://doc.freefem.org/models/nonlinear-elasticity.html) in which the nonlinearity comes in the varepsilon tensor, in which also the second order terms are considered.
We adapt the code to solve the same tensile problem of the previous test, adding and making change from 1 to 0 the parameter `nl` representing the weight of the nonlinear part of epsilon. In `tensile_nonlinear_FF.csv` you can see that we have nu = 0.68 for `nl` equal to 1 and that nu to 0.3 for `nl` tending to 0: this confirms that the nonlinear model is consistent with the linear one since it gives the same result in linear regime on the same test problem. This results can be used as a possible comparison for our nonlinear model.

- **`tensile_nonlinear_KS.edp` & `check_newton_jac.edp`**:
Since, in our model, the nonlinearity comes from a nonlinear elastic energy-based formulation, differently from `FreeFem++` model, in this test we take the primal problem we have formulated and implemented, testing if also this is consistent with the linear case. In `tensile_nonlinear_KS` folder you can find the output of this test.

  - In `linear_consistency.csv` you can see that if the enforced displacement tends to 0, the estimated nu tends to 0.3, since, reducing the enforced displacement we are limiting the nonlinear effects. So, our primal problem is also consistent with the linear case.

  - In `newton_convergence.csv` you find the reducing increments used as a convergence criterion for the Newton's method.

  - Finally, in `check_newton_jacobian.txt`, you can find the results of a validation test on the Newton jacobian computation, to verify if the derivation was done correctly.


- **`check_gradJ.edp`**:
Finally, in this script was validated whether if the gradient of the cost functional J and consequently the dual problem have been computed correctly.
