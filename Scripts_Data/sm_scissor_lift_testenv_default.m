function SCL_Par = sm_scissor_lift_testenv_default(modelname)
%sm_scissor_lift_testenv_default  Return scissor lift model to default settings
%   SCL_Par = sm_scissor_lift_testenv_default(modelname)
%   This function returns the scissor lift model to its default settings.
%   The name of the return parameter must match the name used in the model.
%
% Copyright 2017-2020 The MathWorks, Inc.

SCL_Par = sm_scissor_lift_param;
sm_scissor_lift_testenv_config_test(modelname,'drive_to_lamp');
sm_scissor_lift_testenv_config_actuator(modelname,'Ideal');
sm_scissor_lift_testenv_guide_assembly(modelname,'height_angle');

