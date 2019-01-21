%% Settings
% Parameters
PARAMETERS_SETTINGS = table( ...
    [1e-1; 1e2], [1e-5; 1e-2], [1e-3; 1], [1e-7; 1e-4], [1e-5; 1e-2], 'VariableNames', ...
    {'R'       , 'L'        , 'K'     , 'Jm'       , 'f'}, 'RowNames', {'min', 'max'});      

% Training
TRAINING_SIZE = 2000;
NN_OUT_PARAMETERS = width(PARAMETERS_SETTINGS);
NN_INPUT_NEURONS = length(SIM_TIME) * 2; % i and w
NN_HIDDEN_LAYER_NEURONS = 20;
NN_OUTPUT_NEURONS = NN_OUT_PARAMETERS;

%% Data generation
% Output training set generation
normalization_ranges = PARAMETERS_SETTINGS{{'min','max'},:}';
out_train_set_norm = rand(NN_OUT_PARAMETERS, TRAINING_SIZE);
out_train_set_ = logDecode(normalization_ranges, out_train_set_norm);
sim_parameters_ = table();
sim_parameters_{:, :} = out_train_set_';
sim_parameters_.Properties.VariableNames = PARAMETERS_SETTINGS.Properties.VariableNames;

% Input training set generation
in_train_set = zeros(NN_INPUT_NEURONS, TRAINING_SIZE);

for(p = 1:TRAINING_SIZE)
    [w, i] = simulate(sim_parameters_(p,:), ...
                      'InputSignal', 'step', ...
                      'Time', SIM_TIME);
    in_train_set(:, p) = [w; i];
    if ~rem(p, 100)
        dispStatus("Train set generation", 100 * p/TRAINING_SIZE);
    end
end

%% Train
