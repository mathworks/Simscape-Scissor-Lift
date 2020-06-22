function sm_scissor_lift_testenv_configRTParams(mdl)
% Add Simscape run-time parameters to Scissor Lift example
% Copyright 2018-2020 The MathWorks, Inc.

%% Define Simulink.Parameter objects
tval = evalin('base','lift_extra_mass');
evalin('base','lift_extra_mass = Simulink.Parameter;');
evalin('base','lift_extra_mass.CoderInfo.StorageClass = ''SimulinkGlobal'';');
evalin('base',['lift_extra_mass.Value = ' num2str(tval) ';']);
