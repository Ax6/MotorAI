%% Parameters range
R_range = [0.1 100];
L_range = [0.01 10]*1e-3;
K_range = [0.001 1];
Jm_range = [1e-3 0.1];

%% Training Setup
output_parameters_range = [R_range; L_range; K_range; Jm_range];
TRAINING_SIZE = 2000;
DATA_SAMPLING_FREQUENCY = 500;
SIMULATION_DURATION = 0.1 - 1/DATA_SAMPLING_FREQUENCY;
NN_INPUT_NEURONS = 100;
NN_HIDDEN_LAYER_NEURONS = 20;
NN_OUTPUT_NEURONS = 4;

%% Output training set generation
out_train_set = rand(length(output_parameters_range), TRAINING_SIZE);
out_train_set_nolog = logDecode(output_parameters_range, out_train_set);
sim_parameters_ = num2cell(out_train_set_nolog, 2);

[R_set, L_set, K_set, Jm_set] = sim_parameters_{:};

%sys = tf(zeros(1,1,1, RANDOM_OUTPUT_GEN_ATTEMPTS));
%for(i = 1:RANDOM_OUTPUT_GEN_ATTEMPTS)
%   sys(1,1,1,i) = tf(K_set(i), [ ...
%       L_set(i)*Jm_set(i), ...
%       R_set(i)*Jm_set(i) + f*L_set(i), ... 
%       K_set(i)*K_set(i) + R_set(i)*f ...
%       ]);
%end

%% Input training set generation
in_train_set = zeros(NN_INPUT_NEURONS, TRAINING_SIZE);

for(i = 1:TRAINING_SIZE)
    R = R_set(i);
    L = L_set(i);
    K = K_set(i);
    Jm = Jm_set(i);

    SimulationOutput = sim('data_gen', ...
        'StopTime', num2str(SIMULATION_DURATION));
    simout = SimulationOutput.simout;
    in_train_set(:, i) = [simout.w.Data; simout.i.Data];
    
    i
end
