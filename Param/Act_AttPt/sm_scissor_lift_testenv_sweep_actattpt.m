% Parameter sweep to test actuator attachement positions
% Copyright 2017-2018 MathWorks, Inc.

doParallel  = 0;
deleteFiles = 0;

%% Save model under new name
modelname = 'sm_scissor_lift_testenv';
open_system(modelname)
modelname_new = [modelname '_attptswp'];
save_system(modelname,modelname_new);

%% Configure model for test
sm_scissor_lift_testenv_config_actuator(modelname_new,'Platform');
signalbuilder([modelname_new '/Input/Input/Signal Builder'], 'activegroup', 2);
set_param(modelname_new,'StopTime','25');

%% Set up run time parameters
% Find bracket subsystems
bracket_h = find_system(bdroot,'LookUnderMasks','all','Name','Bracket');
for i=1:length(bracket_h)
    % Break links to library
    set_param(char(bracket_h(i)),'LinkStatus','none');
    % Set offset to MATLAB workspace variable
    frontRear_val = get_param(char(bracket_h(i)),'flfrontrear');
    if strcmp(frontRear_val,'Rear')
        param_string = '-AttPtOffset_MLwksp';
    else
        param_string = 'AttPtOffset_MLwksp';
    end
    set_param([char(bracket_h(i)) '/Transform FlangeR L'],...
        'TranslationStandardOffset',param_string,...
        'TranslationStandardOffset_conf','runtime');
end

% Disable warning
warning('off','physmod:common:gl:sli:rtp:InvalidNonValueReferenceMask');

%% Define conditions for simulations
% Offset values to test
flange_offset_set = [35:2:41];

clear simInput
for i=1:length(flange_offset_set)
    AttPtOffset_MLwksp = flange_offset_set(i);
    simInput(i) = Simulink.SimulationInput(modelname_new);
    simInput(i) = simInput(i).setVariable('AttPtOffset_MLwksp',flange_offset_set(i));
end

%% Run simulations
% Fastest results with visualization off, Fast Restart on
set_param(modelname_new,'SimMechanicsOpenEditorOnUpdate','off');

if(~doParallel)
    tic;
    simOut = sim(simInput,'UseFastRestart','on');
    toc
else
    save_system(modelname_new); % Necessary for parallel simulations only
    tic;
    simOut = parsim(simInput);
    %simOut = parsim(simInput,'UseFastRestart','on');
    toc
end

%% Plot results
% Create figure
if ~exist('h3_sm_scissor_lift_testenv', 'var') || ...
        ~isgraphics(h3_sm_scissor_lift_testenv, 'figure')
    h3_sm_scissor_lift_testenv = figure('Name', 'sm_scissor_lift_testenv');
end
figure(h3_sm_scissor_lift_testenv)
clf(h3_sm_scissor_lift_testenv)

simlog_handles(1) = subplot(2, 1, 1);
grid on
hold on
box on
simlog_handles(2) = subplot(2, 1, 2);
grid on
hold on
box on

% Plot results
for i=1:length(simOut)
    data = simOut(i).logsout_sm_scissor_lift_testenv.get('Actuator');
    subplot(211)
    plot(data.Values.Actuator.Force.Time,data.Values.Actuator.Force.Data,'LineWidth',1);
    subplot(212)
    plot(data.Values.Actuator.Extension.Time,data.Values.Actuator.Extension.Data-data.Values.Actuator.Extension.Data(1),'LineWidth',1);
end

subplot(211)
title('Actuator Force')
ylabel('Force (N)');
hold off

subplot(212)
title('Actuator Extension')
ylabel('Extension (m)');
xlabel('Time (s)');
for i=1:length(flange_offset_set)
    legendstr{i} = ['Offset = ' num2str(flange_offset_set(i)) ' cm'];
end
legend(legendstr,'Location','Best')
hold off

%% Close model and delete .slx file
if(deleteFiles)
    close_system(modelname_new,0)
    delete([modelname_new '.slx'])
end
