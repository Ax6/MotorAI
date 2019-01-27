plotPerformanceOnSettings(Motors);

function plotPerformanceOnSettings(Motors)
    file = load('performanceTable');
    ptable = file.performanceTable;
    layers = ptable.HiddenLayersNeurons;
    llayers = zeros(size(ptable, 1), 3);
    performance = ptable.RealCasePerformance;
    for i=1:size(ptable,1)
        val = str2num(layers(i, :));
        toFill = val;
        toFill(end + (3 - length(val))) = 0;
        llayers(i, :) = toFill;
    end
   

    
    [xq,yq] = meshgrid(0:200, 0:100);
    vq = griddata(llayers(:,1), llayers(:,2),performance,xq,yq);
    mesh(xq,yq,vq)
    hold on
    %plot3(llayers(:,1), llayers(:,2),performance)
    surf(xq, yq, vq, 'EdgeColor','none','LineStyle','none');
    hold on
    scatter3(llayers(:,1), llayers(:,2), performance,'x','r');
end

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