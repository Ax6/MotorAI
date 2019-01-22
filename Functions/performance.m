function [total, parameters, motors] = performance(net, test, parameters, simulation)
    error = zeros(parameters.getCount(), size(test, 1));
    for p=1:size(test, 1)
        simulation.setParameters(test(p,:));
        y = simulation.run();
        out = sim(net, [y(:, 1); y(:, 2)]);
        error(:, p) = (parameters.normalise(test{p,:}') - out) .^ 2;
    end
    motors = error;
    parameters = mean(motors, 2);
    total = mean(parameters);
end