% Copyright 2012-2018 The MathWorks, Inc.

% Set up path
ScissLift_HomeDir = pwd;
addpath([pwd]);
addpath([pwd filesep 'Libraries']);
addpath([pwd filesep 'Libraries' filesep 'Images']);
addpath([pwd filesep 'Libraries' filesep 'Pace']);
addpath([pwd filesep 'Scripts_Data']);
addpath([pwd filesep 'Submodels' filesep '01_Defining_Bodies']);
addpath([pwd filesep 'Submodels' filesep '02_Hydraulic_Act']);
addpath([pwd filesep 'Submodels' filesep '02_Hydraulic_Act' filesep 'html' filesep 'html']);
addpath([pwd filesep 'Param' filesep 'Act_AttPt']);
addpath([pwd filesep 'html' filesep 'html']);

% Create S-Function to control simulation speed
cd(['Libraries' filesep 'Pace']);
if((exist('sfun_time.c')) && ~exist('sfun_time.mexw64'))
    mex sfun_time.c
end
cd(ScissLift_HomeDir)

% Load Simscape Multibody Contact Force Library
addpath([ScissLift_HomeDir filesep 'Libraries' filesep 'CFL_Libs']);
cd([ScissLift_HomeDir filesep 'Libraries' filesep 'CFL_Libs']);
startup_Contact_Forces
cd(ScissLift_HomeDir)

% Load default parameters
SCL_Par = sm_scissor_lift_param;

lift_extra_mass = 0; % kg Run-time parameter

% Open web demo script
web('sm_scissor_lift_Demo_Script.html');
