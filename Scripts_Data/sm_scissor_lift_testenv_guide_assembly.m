function sm_scissor_lift_testenv_guide_assembly(modelname,target_config)
%sm_scissor_lift_testenv_guide_assembly  Enable joint targets in scissor lift model
%   sm_scissor_lift_testenv_guide_assembly(modelname,target_config)
%   This function enables specific sets of variable targets in the scissor
%   lift model.  Not all combinations result in realistic initial
%   configurations.  These options are provided so that the user can
%   explore what targets must be specified to get a realistic initial
%   configuration.
%
%   'height'        Specifies height of platform above cart only
%   'height_angle'  Specifies height of platform above cart and one stage angle
%                   This almost always results in a valid initial configuration.
%   'none'          Disables height and stage joint targets
%
% Copyright 2017-2022 The MathWorks, Inc.

% Find blocks where targets can be enabled/disabled
height_target_h = char(find_system(modelname,'FollowLinks','on','LookUnderMasks','all','Name','Joint Platform Height'));
stage_1_h = char(find_system(modelname,'FollowLinks','on','LookUnderMasks','all','Name','Stage 1'));
angle_target_h = char(find_system(stage_1_h,'FollowLinks','on','LookUnderMasks','all','Name','Rev LfOut'));

% Enable/disable desired targets
switch lower(target_config)
    case 'height'
        set_param(height_target_h,'PzPositionTargetSpecify','on');
        set_param(angle_target_h,'PositionTargetSpecify','off');
    case 'height_angle'
        set_param(height_target_h,'PzPositionTargetSpecify','on');
        set_param(angle_target_h,'PositionTargetSpecify','on');
    case 'none'
        set_param(height_target_h,'PzPositionTargetSpecify','off');
        set_param(angle_target_h,'PositionTargetSpecify','off');
end

