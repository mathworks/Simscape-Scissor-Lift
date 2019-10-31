% Code to plot simulation results from sm_scissor_lift_testenv
%% Plot Description:
%
% The plot below shows the path of the scissor lift during this test.
%
% Copyright 2017-2018 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_scissor_lift_testenv', 'var')
    sim('sm_scissor_lift_testenv')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_scissor_lift_testenv', 'var') || ...
        ~isgraphics(h1_sm_scissor_lift_testenv, 'figure')
    h1_sm_scissor_lift_testenv = figure('Name', 'sm_scissor_lift_testenv');
end
figure(h1_sm_scissor_lift_testenv)
clf(h1_sm_scissor_lift_testenv)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t = simlog_sm_scissor_lift_testenv.Scissor_Lift.Platform.Fixed.Sensing.Joint_Sense_Position.Pz.p.series.time;
simlog_Px = simlog_sm_scissor_lift_testenv.Scissor_Lift.Platform.Fixed.Sensing.Joint_Sense_Position.Px.p.series.values('m');
simlog_Py = simlog_sm_scissor_lift_testenv.Scissor_Lift.Platform.Fixed.Sensing.Joint_Sense_Position.Py.p.series.values('m');
simlog_Pz = simlog_sm_scissor_lift_testenv.Scissor_Lift.Platform.Fixed.Sensing.Joint_Sense_Position.Pz.p.series.values('m');

% Plot results
patch(...
    [1 -1 -1 1]*SCL_Par.Floor.Width*0.5,...
    [1 1 -1 -1]*SCL_Par.Floor.Length*0.5,...
    [1 1 1]*0.90);
hold on
plot(simlog_Px, simlog_Py, 'LineWidth', 1);

patch(...
    [0 -1 -1 0]*SCL_Par.Cart.Platform.Length/100,...
    [1 1 -1 -1]*SCL_Par.Cart.Platform.Width*0.5/100,...
    SCL_Par.Base_Block.Color);

hold off
box on

title('Lift Path')
ylabel('Position (m)');
axis equal
xlabel('Position (m)')

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_R1i simlog_C1v temp_colororder

