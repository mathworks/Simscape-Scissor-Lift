% Copyright 2012-2019 The MathWorks, Inc.

% Set up path
ScissLift_HomeDir = pwd;

% Create S-Function to control simulation speed
cd(['Libraries' filesep 'Pace']);
if((exist('sfun_time.c')) && ~exist('sfun_time.mexw64'))
    mex sfun_time.c
end
cd(ScissLift_HomeDir)


% Load default parameters
SCL_Par = sm_scissor_lift_param;

lift_extra_mass = 0; % kg Run-time parameter

% Open web demo script
web('sm_scissor_lift_Demo_Script.html');
