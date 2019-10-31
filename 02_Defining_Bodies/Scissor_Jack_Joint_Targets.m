% Copyright 2012-2016 The MathWorks, Inc.

rev_joint_h = find_system(bdroot,'ReferenceBlock','sm_lib/Joints/Revolute Joint');

for i=1:length(rev_joint_h)
    joint_tgt_info{i,1} = get_param(rev_joint_h(i),'PositionTargetSpecify');
    joint_tgt_info{i,2} = get_param(rev_joint_h(i),'PositionTargetValue');
    joint_tgt_info{i,3} = get_param(rev_joint_h(i),'PositionTargetValueUnits');
    joint_tgt_info{i,4} = get_param(rev_joint_h(i),'PositionTargetPriority');
end

base_angle = 14.8048;
target_set_1.Specify  = {'on' 'off' 'off' 'off'};
target_set_1.Value    = {'base_angle' '0' '0' '0'};
target_set_1.Units    = {'deg' 'deg' 'deg' 'deg'};
target_set_1.Priority = {'Low' 'Low' 'Low' 'Low'};

disp(['Set 1: One Low Priority per stage'])
    stage_i = 0;
for i=1:length(rev_joint_h)
    stage_i=stage_i+1;
    set_param(rev_joint_h{i},'PositionTargetSpecify',target_set_1.Specify{stage_i});
    if(i<4)
        set_param(rev_joint_h{i},'PositionTargetValue',[target_set_1.Value{stage_i} '/2']);
    else
        set_param(rev_joint_h{i},'PositionTargetValue',target_set_1.Value{stage_i});
    end
    set_param(rev_joint_h{i},'PositionTargetValueUnits',target_set_1.Units{stage_i});
    set_param(rev_joint_h{i},'PositionTargetPriority',target_set_1.Priority{stage_i});
    if(stage_i == 4),stage_i = 0;end
end
tic
set_param(bdroot,'SimulationCommand','Update')
toc

disp(['Set 2: 2 High Priority per stage'])
target_set_1.Specify  = {'on' 'on' 'off' 'off'};
target_set_1.Value    = {'base_angle' 'base_angle' 'base_angle' 'base_angle'};
target_set_1.Units    = {'deg' 'deg' 'deg' 'deg'};
target_set_1.Priority = {'High' 'Low' 'High' 'High'};

stage_i = 0;
for i=1:length(rev_joint_h)
    stage_i=stage_i+1;
    set_param(rev_joint_h{i},'PositionTargetSpecify',target_set_1.Specify{stage_i});
    if(i<4)
        set_param(rev_joint_h{i},'PositionTargetValue',[target_set_1.Value{stage_i} '/2']);
    else
        set_param(rev_joint_h{i},'PositionTargetValue',target_set_1.Value{stage_i});
    end
    set_param(rev_joint_h{i},'PositionTargetValueUnits',target_set_1.Units{stage_i});
    set_param(rev_joint_h{i},'PositionTargetPriority',target_set_1.Priority{stage_i});
    if(stage_i == 4),stage_i = 0;end
end
tic
set_param(bdroot,'SimulationCommand','Update')
toc

disp(['Set 3: 1 High, 1 Low Priority per stage'])
target_set_1.Specify  = {'on' 'off' 'off' 'on'};
target_set_1.Value    = {'base_angle' 'base_angle' 'base_angle' 'base_angle'};
target_set_1.Units    = {'deg' 'deg' 'deg' 'deg'};
target_set_1.Priority = {'High' 'Low' 'Low' 'Low'};

stage_i = 0;
for i=1:length(rev_joint_h)
    stage_i=stage_i+1;
    set_param(rev_joint_h{i},'PositionTargetSpecify',target_set_1.Specify{stage_i});
    if(i<4)
        set_param(rev_joint_h{i},'PositionTargetValue',[target_set_1.Value{stage_i} '/2']);
    else
        set_param(rev_joint_h{i},'PositionTargetValue',target_set_1.Value{stage_i});
    end
    set_param(rev_joint_h{i},'PositionTargetValueUnits',target_set_1.Units{stage_i});
    set_param(rev_joint_h{i},'PositionTargetPriority',target_set_1.Priority{stage_i});
    if(stage_i == 4),stage_i = 0;end
end
tic
set_param(bdroot,'SimulationCommand','Update')
toc

disp(['Set 4: 1 High, 1 Low Priority per stage (Inconsistent)'])
target_set_1.Specify  = {'on' 'off' 'off' 'on'};
target_set_1.Value    = {'base_angle' 'base_angle' 'base_angle' 'base_angle'};
target_set_1.Units    = {'deg' 'deg' 'deg' 'deg'};
target_set_1.Priority = {'High' 'Low' 'Low' 'Low'};

stage_i = 0;
for i=1:length(rev_joint_h)
    stage_i=stage_i+1;
    set_param(rev_joint_h{i},'PositionTargetSpecify',target_set_1.Specify{stage_i});
    if(i<4)
        set_param(rev_joint_h{i},'PositionTargetValue',[target_set_1.Value{stage_i} '/2+' num2str(i)]);
    else
        set_param(rev_joint_h{i},'PositionTargetValue',[target_set_1.Value{stage_i} '+' num2str(i)]);
    end
    set_param(rev_joint_h{i},'PositionTargetValueUnits',target_set_1.Units{stage_i});
    set_param(rev_joint_h{i},'PositionTargetPriority',target_set_1.Priority{stage_i});
    if(stage_i == 4),stage_i = 0;end
end
tic
set_param(bdroot,'SimulationCommand','Update')
toc

set_param(bdroot,'SaveFinalState','on');
sim(bdroot,'StopTime','0.01');
set_param(bdroot,'LoadInitialState','on');
set_param(bdroot,'InitialState','xFinal')

disp(['Set 5: From Pre-Saved Initial State'])
tic
set_param(bdroot,'SimulationCommand','Update')
toc
set_param(bdroot,'LoadInitialState','off');

