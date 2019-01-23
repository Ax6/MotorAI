%% Data generation
% Output training set generation
out_train_set_norm = rand(NN_OUTPUT_NEURONS, TRAINING_SET_SIZE);
out_train_set = motorParameters.denormalise(out_train_set_norm);
sim_parameters_ = table();
sim_parameters_{:, :} = out_train_set';
sim_parameters_.Properties.VariableNames = motorParameters.getNames();

% Input training set generation
in_train_set = zeros(NN_INPUT_NEURONS, TRAINING_SET_SIZE);

for(p = 1:TRAINING_SET_SIZE)
    motorSimulation.setParameters(sim_parameters_(p,:));
    y = motorSimulation.run();
    in_train_set(:, p) = [y(:, 1); y(:, 2)];
    if ~rem(p, 100)
        dispStatus("Train set generation", 100 * p/TRAINING_SET_SIZE);
    end
end

%% Train
trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
net = fitnet(NN_HIDDEN_LAYER_NEURONS, trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 0.7;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.15;

% Train the Network
[net, tr] = train(net, in_train_set, out_train_set_norm, 'UseParallel','yes');%,'UseGPU','only');
