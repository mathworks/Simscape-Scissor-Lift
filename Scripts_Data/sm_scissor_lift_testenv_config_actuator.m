function sm_scissor_lift_testenv_config_actuator(modelname,actuator_config)
%sm_scissor_lift_testenv_config_actuator  Select actuator variant in scissor lift model
%   sm_scissor_lift_testenv_config_actuator(modelname,actuator_config)
%   This function selects the desired variant for the actuator in the
%   scissor lift model.  Abstract variants use inverse dynamics to
%   calculate actuator requirements based on performance specifications.
%
% Copyright 2016-2023 The MathWorks(TM), Inc.

% Find Actuator variant subsystem
actuator_h = char(find_system(modelname,'MatchFilter',@Simulink.match.allVariants,'FollowLinks','on','LookUnderMasks','all','Name','Actuator','Variant','on'));

% Select variant
switch lower(actuator_config)
    case 'platform'
        set_param(actuator_h,'OverrideUsingVariant','Platform');
    case 'ideal'
        set_param(actuator_h,'OverrideUsingVariant','Ideal');
    case 'hydraulic'
        set_param(actuator_h,'OverrideUsingVariant','Hydraulic');
end
