clc;
addpath Functions;
benchmark_file = load('DCMotors');
Motors = benchmark_file.DCMotors;

simulation_setup;
gym;

figure
hold on
for p=1:size(Motors, 1)
    [w, i] = simulate(Motors(p,:), 'InputSignal', 'step', 'Time', SIM_TIME);
    plot(SIM_TIME, w);
end