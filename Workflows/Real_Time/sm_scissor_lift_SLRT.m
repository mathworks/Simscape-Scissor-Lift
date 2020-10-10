%% Open model, save copy
orig_mdl = 'sm_scissor_lift_testenv';
open_system(orig_mdl);
mdl = [orig_mdl '_rttest_temp'];

sm_scissor_lift_testenv_config_actuator(orig_mdl,'hydraulic')
save_system(orig_mdl,mdl);
lift_extra_mass = 0; % kg Run-time parameter
sm_scissor_lift_testenv_configRTParams(mdl);
set_param(mdl,'SimscapeLogType','none');
set_param(mdl,'SaveFormat','StructureWithTime');
set_param(mdl,'StopTime','15');
signalbuilder([mdl '/Input/Input/Signal Builder'], 'activegroup', 3);

%% Get reference results
sm_scissor_lift_testenv_setsolver(mdl,'desktop');
sim(mdl)
t_ref = Ext_Vel_Frc.time;
y_ref = Ext_Vel_Frc.signals(1).values(:,1);

%% Create plot
figure(1)
temp_colororder = get(gca,'DefaultAxesColorOrder');
set(gcf,'Position',[552    50   472   301]);
plot(t_ref,y_ref,'k','LineWidth',3)
title('Comparing Simulation Results','FontSize',14,'FontWeight','Bold');
xlabel('Time (s)','FontSize',12);ylabel('Results');
legend({'Reference'},'Location','NorthWest')

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

%% Build application
% Choose target
cs = getActiveConfigSet(mdl);
cs.switchTarget('slrealtime.tlc',[]);

set_param(mdl,'SimMechanicsOpenEditorOnUpdate','off');
slbuild(mdl);

%% Download to real-time target
tg = slrealtime;
tg.connect;

%% Run application
tg.load(mdl)
tg.start('ReloadOnStop',true,'ExportToBaseWorkspace',true)

open_system(mdl);
disp('Waiting for SLRT to finish...');
pause(1);
while(strcmp(tg.status,'running'))
    pause(2);
    disp(tg.status);
end
pause(2);

%% Extract results from logged data in Simulink Data Inspector
y_slrt1 = logsout_sm_scissor_lift_testenv.LiveStreamSignals.get('Actuator.Actuator.Extension');

%% Plot reference and real-time results
figure(1)
hold on
h3=stairs(y_slrt1.Values.Time,y_slrt1.Values.Data(:,1),'c:','LineWidth',2.5);
hold off
legend({'Reference','Fixed-Step','Real-Time'},'Location','NorthWest');

%% Modify mass on platform
disp(['Platform Extra Mass (current) = ' num2str(getparam(tg,'','lift_extra_mass'))]);
setparam(tg,'','lift_extra_mass',50)
disp(['Platform Extra Mass (new) = ' num2str(getparam(tg,'','lift_extra_mass'))]);

%% Run simulation with new parameter value
tg.start('ReloadOnStop',true,'ExportToBaseWorkspace',true);

disp('Waiting for Simulink Real-Time to finish...');
pause(1);
while(strcmp(tg.status,'running'))
    pause(2);
    disp(tg.status);
end
pause(2);

%% Extract results from logged data in Simulink Data Inspector
y_slrt2 = logsout_sm_scissor_lift_testenv.LiveStreamSignals.get('Actuator.Actuator.Extension');

%% Plot results of altered extra mass test
figure(1)
hold on
stairs(y_slrt2.Values.Time,y_slrt2.Values.Data(:,1),'Color',temp_colororder(4,:),'LineWidth',2);
hold off
legend({'Reference','Fixed-Step','Real-Time','Modified'},'Location','NorthWest');

%save(['sm_scissor_lift_testenv_slrt_res_' datestr(now,'yyddmm_HHMM')],'t_slrt1','y_slrt1','t_slrt2','y_slrt2','t_ref','y_ref','t_fs','y_fs');
% Copyright 2013-2020 The MathWorks(TM), Inc.

%% CLEAN UP DIRECTORY
%cleanup_rt_test

% Reset runtime parameter
clear lift_extra_mass
lift_extra_mass = 0;

