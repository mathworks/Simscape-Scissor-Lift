% Code to plot simulation results from sh_cyl_single_acting_3pos
%
% Copyright 2017-2024 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sh_cyl_single_acting_3pos', 'var')
    sim('sh_cyl_single_acting_3pos')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sh_cyl_single_acting_3pos', 'var') || ...
        ~isgraphics(h1_sh_cyl_single_acting_3pos, 'figure')
    h1_sh_cyl_single_acting_3pos = figure('Name', 'sh_cyl_single_acting_3pos');
end
figure(h1_sh_cyl_single_acting_3pos)
clf(h1_sh_cyl_single_acting_3pos)

% Get simulation results
simlog_t = simlog_sh_cyl_single_acting_3pos.Valve_Actuator.A.series.time;
simlog_valveA = simlog_sh_cyl_single_acting_3pos.Valve_Actuator.A.series.values('1');
simlog_valveB = simlog_sh_cyl_single_acting_3pos.Valve_Actuator.B.series.values('1');
simlog_valveP = simlog_sh_cyl_single_acting_3pos.Valve_Actuator.S.series.values('m');
simlog_cylP = simlog_sh_cyl_single_acting_3pos.Cylinder.p_out.series.values('m');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_cylP, 'LineWidth', 1)
grid on
title('Piston Position')
ylabel('Position (m)')
simlog_handles(2) = subplot(2, 1, 2);
yyaxis left
plot(simlog_t, simlog_valveP, 'LineWidth', 1)
ylabel('Spool Position (m)')
yyaxis right
plot(simlog_t, simlog_valveA, simlog_t, simlog_valveB, 'LineWidth', 1)
ylabel('Inputs (V)')
grid on
title('Valve Actuator')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_handles
clear simlog_valveP simlog_valveA simlog_valveB
clear simlog_cylP 
