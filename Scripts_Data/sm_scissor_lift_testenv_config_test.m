function sm_scissor_lift_testenv_config_test(modelname,testname)
%sm_scissor_lift_testenv_config_test  Configure test for scissor lift model
%   sm_scissor_lift_testenv_config_test(modelname,testname)
%   This function configures the model for the desired test.
%
% Copyright 2017-2018 The MathWorks, Inc.

% Find Signal Builder block
sig_h = find_system([modelname '/Input'],'Variants','AllVariants','FollowLinks','on','LookUnderMasks','all','MaskType','Sigbuilder block');

% Get settings based on requested test
switch lower(testname)
    case 'drive_to_lamp'
        sigActGroup = 1;
        simStopTime = '50';
        inputVariant = 'Test_Input';
    case 'raise_lower'
        sigActGroup = 2;
        simStopTime = '25';
        inputVariant = 'Test_Input';
    case 'user_input'
        sigActGroup = 1;
        simStopTime = '200';
        inputVariant = 'Dashboard';
end

% Adjust model
signalbuilder(char(sig_h),'activegroup',sigActGroup);
set_param(modelname,'StopTime',simStopTime);
set_param([modelname '/Input'],'OverrideUsingVariant',inputVariant);

if(strcmpi(testname,'user_input'))
    open_system([modelname '/Input/Dashboard'],'tab');
end
