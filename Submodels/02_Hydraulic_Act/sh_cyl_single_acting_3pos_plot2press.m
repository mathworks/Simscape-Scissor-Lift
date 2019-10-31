% Code to plot simulation results from sh_cyl_single_acting_3pos
%
% Copyright 2015 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sh_cyl_single_acting_3pos', 'var')
    sim('sh_cyl_single_acting_3pos')
end

% Reuse figure if it exists, else create new figure
if ~exist('h2_sh_cyl_single_acting_3pos', 'var') || ...
        ~isgraphics(h2_sh_cyl_single_acting_3pos, 'figure')
    h2_sh_cyl_single_acting_3pos = figure('Name', 'sh_cyl_single_acting_3pos');
end
figure(h2_sh_cyl_single_acting_3pos)
clf(h2_sh_cyl_single_acting_3pos)

% Get simulation results
simlog_t = simlog_sh_cyl_single_acting_3pos.Valve_Actuator.P.series.time;
simlog_cylpA = simlog_sh_cyl_single_acting_3pos.Cylinder.A.p.series.values('Pa');
simlog_valveqPA = simlog_sh_cyl_single_acting_3pos.x3_Way_Valve.orifice_P.flow_rate.series.values('m^3/s');
simlog_valveqAT = simlog_sh_cyl_single_acting_3pos.x3_Way_Valve.orifice_T.flow_rate.series.values('m^3/s');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_cylpA, 'LineWidth', 1)
grid on
title('Cylinder Pressure')
ylabel('Pressure (Pa)')

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_valveqPA, 'LineWidth', 1);
hold on
plot(simlog_t, simlog_valveqAT, 'LineWidth', 1);
hold off
grid on
title('Flow Through Valve')
legend({'Orifice PA','Orifice AT'},'Location','Best')
ylabel('Flow Rate (m^3/s)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_cylpA simlog_valveqPA simlog_valveqAT simlog_handles
