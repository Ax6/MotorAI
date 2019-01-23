# MotorAI
CoDeAS project about neural network electric motor parameter estimation.

The first stage of this project is to aim at estimating all parameters
of any DC Motor (brushed). Estimation is performed by a neural network based on
the measured system response given a specified input
signal.

## Model
Following model simplifications have been taken into account
1. **Ke** (Electromotive constant) and **Kt** (Torque constant)
are considered equal.
2. Motor is **unloaded** therefore the only inertia is the rotor inertia

DC Motor parameters to be estimated
- **R** Winding resistance
- **L** Winding inductance
- **K** Torque constant
- **f** Viscous friction coefficient
- **Jm** Rotor inertia

## Training
Training is conduced offline in a simulation environment.
Trained neural networks are compared with each other
based on their performance. Network performance is calculated on
real DC Motors taken from various datasheets.

---
Aaron Russo, Edoardo Galletti
