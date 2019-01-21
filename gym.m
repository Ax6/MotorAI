%% Parameters range
R_range = [0.1 100];
L_range = [0.01 10]*1e-3;
K_range = [0.001 1];
Jm_range = [1e-3 0.1];
f = 0;

%% Training Setup
output_parameters_range = [R_range; L_range; K_range; Jm_range];
TRAINING_SIZE = 10000;
NN_INPUT_NEURONS = 100;
NN_HIDDEN_LAYER_NEURONS = 20;
NN_OUTPUT_NEURONS = 4;

%% Output training set generation
out_train_set = rand(length(output_parameters_range), TRAINING_SIZE);
out_train_set_nolog = logDecode(output_parameters_range, out_train_set);
sim_parameters_ = num2cell(out_train_set_nolog, 2);

[R_set, L_set, K_set, Jm_set] = sim_parameters_{:};

%% Input training set generation
in_train_set = zeros(NN_INPUT_NEURONS, TRAINING_SIZE);

for(p = 1:TRAINING_SIZE)
    [w, i] = simulate(R_set(p), L_set(p), K_set(p), Jm_set(p));
    in_train_set(:, p) = [w; i];
    p
end
