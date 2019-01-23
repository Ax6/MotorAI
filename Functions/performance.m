function [total, parameters, error, estimation] = performance(net, test, parameters, simulation)
    error = zeros(parameters.getCount(), size(test, 1));
    estimation = zeros(parameters.getCount(), size(test, 1));
    for p=1:size(test, 1)
        simulation.setParameters(test(p,:));
        y = simulation.run();
        out = sim(net, [y(:, 1); y(:, 2)]);
        estimation(:, p) = parameters.denormalise(out);
        error(:, p) = (parameters.normalise(test{p,:}') - out) .^ 2;
    end
    parameters = mean(error, 2);
    total = mean(parameters);
end