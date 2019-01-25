net_files = dir("net_*");

Motors.f(:) = 5e-3;

for i=1:length(net_files)
    name = net_files(i).name;
    file = load(name);
    net = file.net;
    try
        [p_total, p_params, p_error, p_motors] = performance(net, Motors, motorParameters, motorSimulation);
        disp(strcat(name, ": ", num2str(p_total)));
    catch
        warning(strcat(name, ": ", "Cazzo nope"));
    end
end