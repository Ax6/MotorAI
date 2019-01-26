addpath Classes;
import Coach.*

% Coach
COACH_ATTEMPTS = 20;
START_ID = 17;

mancini = Coach();
mancini.set(Coach.SETTING_NN_NEURONS_GENERATION, Coach.GEN_MODE_RANDOM);
mancini.set(Coach.SETTING_NN_LAYERS_GENERATION, Coach.GEN_MODE_STATIC);
mancini.hiddenLayersRanges = [[140 170]; [40 60]];

names = {'set_size', 'input_size', ...
    'hidden_size', 'output_size', 'training_performance', 'real_performance' ...
    'tp_params', 'tp_motors', 'p_params', 'p_motors'};
nnp = table();
nnp{end+1,:} = {'Training set size', 'Input layer neurons', ...
'Hidden layer neurons', 'Output layer neurons', ...
'Training Performance', 'Real-Case Performance' ...
'tp_params', 'tp_motors', 'p_params', 'p_motors'};
nnp.Properties.VariableNames = names;
nnp.Properties.RowNames = {'nn_info'};

for id=START_ID:(COACH_ATTEMPTS + START_ID - 1)
    benchmark;
    nnp.set_size{end+1} = TRAINING_SET_SIZE;
    nnp.input_size{end} = NN_INPUT_NEURONS;
    nnp.hidden_size{end} = NN_HIDDEN_LAYER_NEURONS;
    nnp.output_size{end} = NN_OUTPUT_NEURONS;
    nnp.training_performance{end} = tp_total;
    nnp.real_performance{end} = p_total;
    nnp.tp_params{end} = tp_params;
    nnp.p_params{end} = p_params;
    nnp.tp_motors{end} = tp_motors;
    nnp.p_motors{end} = p_motors;
    save(strcat('net', num2str(id), '.mat'), 'net');
    save('performanceTable.mat', 'nnp');
end


