%%
DATA_SAMPLING_FREQUENCY = 500;
SIMULATION_DURATION = 0.1 - 1/DATA_SAMPLING_FREQUENCY;
STEP_OPT = stepDataOptions('StepAmplitude', 5);

%% MOTOR PARAMETERS
R = 0.1; % Ohm
L = 0.59e-3; % H
Ke = 0.64; % N*m/A %CAMBIA
Kt = 0.64; % N*m/A
K = Kt;
f = 0;%4.18e-3; % N*m*s
Jm = 46e-3; % Kg/m^2s

