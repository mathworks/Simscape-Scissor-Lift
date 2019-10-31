% Code to plot simulation results from sm_scissor_lift_testenv
%% Plot Description:
%
% The plots below show the actuator extension and the force applied during
% this test.
%
% Copyright 2017-2019 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_scissor_lift_testenv', 'var')
    sim('sm_scissor_lift_testenv')
end

% Reuse figure if it exists, else create new figure
if ~exist('h2_sm_scissor_lift_testenv', 'var') || ...
        ~isgraphics(h2_sm_scissor_lift_testenv, 'figure')
    h2_sm_scissor_lift_testenv = figure('Name', 'sm_scissor_lift_testenv');
end
figure(h2_sm_scissor_lift_testenv)
clf(h2_sm_scissor_lift_testenv)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_act = logsout_sm_scissor_lift_testenv.get('Actuator');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_act.Values.Actuator.Extension.Time, simlog_act.Values.Actuator.Extension.Data, 'LineWidth', 1);
grid on
title('Actuator Extension')
ylabel('Extension (m)');

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_act.Values.Actuator.Extension.Time, simlog_act.Values.Actuator.Force.Data, 'LineWidth', 1)
grid on
title('Actuator Force')
ylabel('Force (N)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_handles temp_colororder
clear simlog_act

