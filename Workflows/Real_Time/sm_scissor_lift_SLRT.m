%% Open model, save copy
orig_mdl = 'sm_scissor_lift_testenv';
%sm_scissor_lift_testenv_PARAM
open_system(orig_mdl);
mdl = [orig_mdl '_rttest_temp'];
sm_scissor_lift_testenv_config_actuator(orig_mdl,'hydraulic')
save_system(orig_mdl,mdl);
lift_extra_mass = 0; % kg Run-time parameter
sm_scissor_lift_testenv_configRTParams(mdl);
set_param(mdl,'SimscapeLogType','none');
set_param(mdl,'SaveFormat','StructureWithTime');
set_param(mdl,'StopTime','15');
set_param('sm_scissor_lift_testenv_rttest_temp/SLRT Scope','Commented','off');
signalbuilder([mdl '/Input/Input/Signal Builder'], 'activegroup', 3);

%% Get reference results
sm_scissor_lift_testenv_setsolver(mdl,'desktop');
sim(mdl)
t_ref = Ext_Vel_Frc.time;
y_ref = Ext_Vel_Frc.signals(1).values(:,1);
clear tout yout

%% Create plot
figure(1)
temp_colororder = get(gca,'DefaultAxesColorOrder');
set(gcf,'Position',[552    50   472   301]);
plot(t_ref,y_ref,'k','LineWidth',3)
title('Comparing Simulation Results','FontSize',14,'FontWeight','Bold');
xlabel('Time (s)','FontSize',12);ylabel('Results');
legend({'Reference'},'Location','NorthWest')
%set(gca,'YLim',[-25 25]);

%% Get results with real-time solver settings
sv_p = sm_scissor_lift_testenv_setsolver(mdl,'realtime');
open_system(get_param(sv_p(1),'Parent'),'force')
set_param(char(sv_p(1)),'Selected','on');
sim(mdl)
t_fs = Ext_Vel_Frc.time;
y_fs = Ext_Vel_Frc.signals(1).values(:,1);

%% Compare desktop and real-time results
figure(1)
hold on
h2=stairs(t_fs,y_fs,'Color',temp_colororder(2,:),'LineWidth',2.5);
hold off
legend({'Reference','Fixed-Step'},'Location','NorthWest')

%% Select run-time parameter
tune_bpth = [mdl '/Scissor Lift/Platform/Extension/Platform Extra Mass'];
% Highlight block
open_system(get_param(tune_bpth,'Parent'),'force')
set_param(tune_bpth,'Selected','on');

%% Build and download to real-time target
% Set codegen target to slrt.tlc
set_param(mdl,'SimMechanicsOpenEditorOnUpdate','off');
slbuild(mdl);

%% Set simulation mode to External
set_param(mdl,'SimulationMode','External');

%% Connect to target and run
set_param(mdl, 'SimulationCommand', 'connect')
set_param(mdl, 'SimulationCommand', 'start')

open_system(mdl);
disp('Waiting for SLRT to finish...');
pause(1);
disp(get_param(bdroot,'SimulationStatus'));
while(~strcmp(get_param(bdroot,'SimulationStatus'),'stopped'))
    pause(2);
    disp(get_param(bdroot,'SimulationStatus'));
end
pause(2);

t_slrt1 = tg.TimeLog; y_slrt1 = tg.OutputLog;

%% Plot reference and real-time results
figure(1)
hold on
h3=stairs(t_slrt1,y_slrt1,'c:','LineWidth',2.5);
hold off
legend({'Reference','Fixed-Step','Real-Time'},'Location','NorthWest');

%% Modify mass on platform
liftExtraMass_id = getparamid(tg, '','lift_extra_mass');
disp(['Platform Extra Mass (current) = ' num2str(getparam(tg,liftExtraMass_id))]);
setparam(tg,liftExtraMass_id,50);
disp(['Platform Extra Mass (new)     = ' num2str(getparam(tg,liftExtraMass_id))]);

%% Run simulation with new parameter value
start(tg);

disp('Waiting for Simulink Real-Time to finish...');
pause(1);
disp(tg.Status);
while(~strcmp(tg.Status,'stopped'))
    pause(2);
    disp(tg.Status);
end
pause(2);

t_slrt2 = tg.TimeLog; y_slrt2 = tg.OutputLog;

%% Plot results of altered extra mass test
figure(1)
hold on
stairs(t_slrt2,y_slrt2,'Color',temp_colororder(4,:),'LineWidth',2);
hold off
legend({'Reference','Fixed-Step','Real-Time','Modified'},'Location','NorthWest');
%}

save(['sm_scissor_lift_testenv_slrt_res_' datestr(now,'yyddmm_HHMM')],'t_slrt1','y_slrt1','t_slrt2','y_slrt2','t_ref','y_ref','t_fs','y_fs');

%% CLEAN UP DIRECTORY
cleanup_rt_test

% Reset runtime parameter
clear lift_extra_mass
lift_extra_mass = 0;
% Copyright 2013-2019 The MathWorks(TM), Inc.

%warning('off','MATLAB:subscripting:noSubscriptsSpecified')