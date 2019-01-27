runMotorsSimulations(Motors, motorSimulation);

function runMotorsSimulations(Motors, motorSimulation)    
    figure(1);
    title("DC Motor, step response (i/V)");
    ylabel("Current [A]");
    xlabel("Time [s]");
    figure(2);
    title("DC Motor, step response (\omega/V)");
    ylabel("Speed [rad/s]");
    xlabel("Time [s]");

    for p=1:size(Motors,1)
        motorSimulation.setParameters(Motors(p,:));
        y = motorSimulation.run();
        i = y(:, 1);
        w = y(:, 2);
        figure(1);
        hold on
        plot(motorSimulation.t, i);
        figure(2);
        hold on
        plot(motorSimulation.t, w);
    end
end

function runMotorsPerformance(Motors, motorParameters, motorSimulation)
    net_files = dir("net*");
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
end