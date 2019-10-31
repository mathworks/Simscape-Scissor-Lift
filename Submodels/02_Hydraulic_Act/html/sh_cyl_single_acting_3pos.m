%% Single-Acting Cylinder with 3-Position Valve Actuator
% 
% This example models a single-acting hydraulic cylinder controlled by a
% 3-way discrete valve. Varying the two inputs to the valve actuator
% enables the valve spool to assume three positions (neutral, connect ports
% P and A, connect ports A and T). This architecture is used for simple
% actuation systems such as those with with up-neutral-down control.
%
% Copyright 2017-2019 The MathWorks, Inc.



%% Model

open_system('sh_cyl_single_acting_3pos')

set_param(find_system('sh_cyl_single_acting_3pos','FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Simulation Results from Simscape Logging

%%
% The plot below shows the extension of the cylinder as the valve inputs
% are varied. The three valve states are shown in the plot of valve spool
% position.

sh_cyl_single_acting_3pos_plot1pos;

%%
% The plot below shows the pressure in the cylinder and the flow through
% the valve.  The periods of high pressure indicate that the actuator has
% reached the limits of travel.

sh_cyl_single_acting_3pos_plot2press;

%%

clear all
close all
bdclose all
