for i=1:400
    motorSimulation.setParameters(sim_parameters_(i, :));
    y = motorSimulation.run();
    figure(1)
    hold on
    plot(SIM_TIME, y(:, 1));
    figure(2)
    hold on
    plot(SIM_TIME, y(:, 2));
end