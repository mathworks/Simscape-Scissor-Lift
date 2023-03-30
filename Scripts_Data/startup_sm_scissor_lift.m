% Copyright 2012-2023 The MathWorks, Inc.

% Set up path
ScissLift_HomeDir = pwd;

% Load default parameters
SCL_Par = sm_scissor_lift_param;

lift_extra_mass = 0; % kg Run-time parameter

open_start_content = 1;

% If running in a parallel pool
% do not open model or demo script
if(~isempty(ver('parallel')))
    if(~isempty(getCurrentTask()))
        open_start_content = 0;
    end
end

if(open_start_content)
    web('sm_scissor_lift_Demo_Script.html');
end