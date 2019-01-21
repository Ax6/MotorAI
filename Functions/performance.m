function [total, parameters] = performance(net, test)
    error = zeros(1,4);
    for p=1:size(test, 1)
        params = [test.R(p), test.L(p), test.K(p), test.Jm(p)];
        [w, i] = simulate(params);
        out = myNeuralNetworkFunction_test18([w; i]);
        error = error + (logEncode(params) - out) .^ 2;
    end
    parameters = error ./ size(test,1);
    total = mean(parameters);
end