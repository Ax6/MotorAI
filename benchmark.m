addpath Functions;
addpath Classes;
import Parameters.*;
import Simulation.*;
benchmark_file = load('DCMotors');

%% SETTINGS
% Simulation
DATA_SAMPLING_FREQUENCY = 500;
SIM_DURATION = 0.1;
SIM_TIME = 0:1/DATA_SAMPLING_FREQUENCY:(SIM_DURATION - 1/DATA_SAMPLING_FREQUENCY);

% Network
NN_INPUT_NEURONS = 100; % i and w
NN_HIDDEN_LAYER_NEURONS = mancini.generateHiddenLayers();
NN_OUTPUT_NEURONS = 5;

% Training
TRAINING_SET_SIZE = 40000;
TRAINING_MAX_VALIDATION_FAILS = round(TRAINING_SET_SIZE * 0.0025);
TRAINING_MAX_EPOCHS = 30000;
TRAINING_GPU_ENABLE = true;

%% SETUP
Motors = benchmark_file.DCMotors(:, 4:end);
Motors.L = Motors.L * 1e-3;
motorParameters = Parameters();
motorSimulation = Simulation(SIM_TIME);

motorParameters.range('R', [1e-1 1e2]) ...
               .range('L', [1e-5 1e-2]) ...
               .range('K', [1e-3 1]) ...
               .range('f', [1e-7 1e-4]) ...
               .range('Jm', [1e-8 1e-4]);

motorSimulation.addTF("[Jm f]", "[L*Jm, R*Jm + f*L, K*K + f*R]"); % Current (i) TF
motorSimulation.addTF("K", "[L*Jm, R*Jm + f*L, K*K + f*R]"); % Speed (w) TF

%% RUN
% Data and network consistency check
if NN_OUTPUT_NEURONS ~= motorParameters.getCount()
    error("Inconsistency: output network size different from motor training output size");
end
if NN_INPUT_NEURONS ~= length(SIM_TIME) * 2
    error("Inconsistency: input network size different from");
end

% Train
gym;

% Performance
[p_total, p_params, p_error, p_motors] = performance(net, Motors, motorParameters, motorSimulation)
