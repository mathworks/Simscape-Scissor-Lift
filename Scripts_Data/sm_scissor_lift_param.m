function SCL_Par = sm_scissor_lift_param(varargin)
%sm_scissor_lift_param  Generate parameter values for scissor lift models
%   SCL_Par = sm_scissor_lift_param(<link length>, <link width>, <separation>, <initial lift>)
%   This function returns the parameter values for model Scissor_Lift.
%   The entire mechanical system is parameterized based on three dimensions
%   You can overwrite default values by specifying:
%       link length         SCL_Par.Link.Length (cm)           Default 240
%       link width          SCL_Par.Link.Width (cm)            Default 15
%       crossbar separation SCL_Par.Link_Sep.Outer_Outer (cm)  Default 80
%       initial lift        SCL_Par.Init.Platform_Height (cm)  Default 50
%             initial lift = platform-link attachment point height above
%                            cart-link attachment point
%   Leave the input argument empty to use the default value
%
%   For example to override the link length and platform initial lift:
%   >> SCL_Par = sm_scissor_lift_param(250,[],[],55);
%
% Copyright 2017-2024 The MathWorks, Inc.

% Default values
default_values = {...
    'SCL_Par.Link.Length', 240;
    'SCL_Par.Link.Width', 15;
    'SCL_Par.Link_Sep.Outer_Outer', 80; %cm
    'SCL_Par.Init.Platform_Height',50}; % cm

% Overwrite default if value specified
for i=1:length(default_values)
    eval([default_values{i,1} ' =  ' num2str(default_values{i,2}) ';']);
    if(nargin>=i && ~isempty(varargin{i}))
        eval([default_values{i,1} ' =  ' num2str(varargin{i}) ';']);
    end
end

% Colors
SCL_Par.Colors.Yellow = [0.8 0.8 0.0];
SCL_Par.Colors.Red = [0.8 0.2 0.0];
SCL_Par.Colors.Blue = [0.0 0.6 0.8];
SCL_Par.Colors.Dark_Gray = [0.5 0.5 0.5];
SCL_Par.Colors.Gray = [0.9 0.9 0.9];
SCL_Par.Colors.GrayBlue = [164 184 200]/255;

% Link dimensions
SCL_Par.Link.Thick = 4; % cm
SCL_Par.Link.HolRad = 5; % cm
SCL_Par.Link.Density = 10;
SCL_Par.Link.Color = SCL_Par.Colors.Yellow;
SCL_Par.Link.ColorI = SCL_Par.Colors.Gray;
SCL_Par.Link.ColorO = SCL_Par.Colors.GrayBlue;
SCL_Par.Link.Opacity = 1;

% Link separation along width of lift
SCL_Par.Link_Sep.Outer_Inner = 10; %cm

% Joint Targets
% Constants
SCL_Par.Init.Num_Stages = 3; % cm
SCL_Par.Init.Base_Angle_H0 = asind(SCL_Par.Link.Width/SCL_Par.Link.Length); % deg

% Calculated initial values
SCL_Par.Init.Base_Angle=asind(SCL_Par.Init.Platform_Height/(SCL_Par.Init.Num_Stages*SCL_Par.Link.Length));
SCL_Par.Init.Roller_Position = ...
    cosd(SCL_Par.Init.Base_Angle)*SCL_Par.Link.Length*-1;


% Alternate calculations for other inputs
%SCL_Par.Init.Platform_Height = SCL_Par.Init.Num_Stages*SCL_Par.Link.Length*sind(SCL_Par.Init.Base_Angle);
%SCL_Par.Roller.Init_Pos_Target = (SCL_Par.Link.Length-0.5); % cm
%SCL_Par.Roller.Init_Pos_Target = (SCL_Par.Link.Length-0.5)*-1; % cm
%SCL_Par.Crossbar.Init_Angle_Target = -(asin(SCL_Par.Roller.Init_Pos_Target/SCL_Par.Link.Length)*180/pi-90);
%SCL_Par.Init.Base_Angle = asind(...
%    SCL_Par.Init.Platform_Lift/(SCL_Par.Init.Num_Stages*SCL_Par.Link.Length)+sind(SCL_Par.Init.Base_Angle_H0)); % deg

% Shaft connecting sides
SCL_Par.Trans_Shaft.Radius = 5; % cm
SCL_Par.Trans_Shaft.Density = 1000;
SCL_Par.Trans_Shaft.Color = SCL_Par.Colors.GrayBlue;
SCL_Par.Trans_Shaft.Opacity = 1;

% Pin connecting links
SCL_Par.Link_Pin.Radius = 5; % cm
SCL_Par.Link_Pin.Density = 1000;
SCL_Par.Link_Pin.Color = SCL_Par.Colors.GrayBlue;
SCL_Par.Link_Pin.Opacity = 1;

% Rollers at top and bottom
SCL_Par.Roller.Roller_Radius = 8;
SCL_Par.Roller.Roller_Length = 6;
SCL_Par.Roller.Shaft_Radius = 5;
SCL_Par.Roller.Shaft_Length = SCL_Par.Link.Thick*1.1;
SCL_Par.Roller.Density = 1000;
SCL_Par.Roller.Color = [0.0 0.6 0.8];
SCL_Par.Roller.Opacity = 1;

% Hardstop at bottom
SCL_Par.Roller.Hardstop.UB = 0;
SCL_Par.Roller.Hardstop.LB = -cosd(SCL_Par.Init.Base_Angle_H0)*SCL_Par.Link.Length;
SCL_Par.Roller.Hardstop.Stiffness = 1e8;
SCL_Par.Roller.Hardstop.Damping = 1e7;

% Attachments for links at top and bottom
SCL_Par.Base_Block.Height = SCL_Par.Roller.Roller_Radius*2;
SCL_Par.Base_Block.Width = SCL_Par.Base_Block.Height;
SCL_Par.Base_Block.Length = SCL_Par.Roller.Roller_Length;
SCL_Par.Base_Block.Shaft_Radius = SCL_Par.Roller.Shaft_Radius;
SCL_Par.Base_Block.Shaft_Length = SCL_Par.Link.Thick*1.1;
SCL_Par.Base_Block.Density = 1000;
SCL_Par.Base_Block.Color = [0.0 0.6 0.8];
SCL_Par.Base_Block.Opacity = 1;

% Actuator bracket
SCL_Par.Act.Brkt.Shaft.Radius = SCL_Par.Trans_Shaft.Radius;
SCL_Par.Act.Brkt.Shaft.Density = 1000;
SCL_Par.Act.Brkt.Shaft.Color = SCL_Par.Colors.GrayBlue;
SCL_Par.Act.Brkt.Shaft.Opacity = 1;

SCL_Par.Act.Brkt.Flange.Width = 70; %cm
SCL_Par.Act.Brkt.Flange.Thickness = SCL_Par.Link.Thick; %cm
SCL_Par.Act.Brkt.Flange.Offset_H = 15; %cm
SCL_Par.Act.Brkt.Flange.Offset_L = 35; %cm - to be tuned
SCL_Par.Act.Brkt.Flange.Height = ...
    SCL_Par.Act.Brkt.Shaft.Radius + 1 +...
    SCL_Par.Act.Brkt.Flange.Offset_H-SCL_Par.Link.Width/2; %cm

%SCL_Par.Act.Brkt.Flange.xsec = [...
%    -shaft_radius-1 shaft_radius/2+0.5+W/2;...
%    -fl_w/2           (-fl_h+W)/2;...
%     fl_w/2           (-fl_h+W)/2;...
%     shaft_radius+1 shaft_radius/2+0.5+W/2]*flupdown;
 
SCL_Par.Act.Brkt.Flange.Density = 1000; %cm
SCL_Par.Act.Brkt.Flange.Color = SCL_Par.Colors.Gray;
SCL_Par.Act.Brkt.Flange.Opacity = 1;

% Actuator
SCL_Par.Act.Collar.Radius = SCL_Par.Trans_Shaft.Radius*1.1; %cm
SCL_Par.Act.Collar.Length = 30; %cm
SCL_Par.Act.Collar.Density = 1000; %cm
SCL_Par.Act.Collar.Color = [0.5 0.5 0.5]; %cm
SCL_Par.Act.Collar.Opacity = 1; %cm

SCL_Par.Act.Cylinder.Radius = SCL_Par.Trans_Shaft.Radius*1.1; %cm
SCL_Par.Act.Cylinder.Length = SCL_Par.Link.Length*0.675*0.8; %cm

SCL_Par.Act.Piston_Seat.Radius = SCL_Par.Trans_Shaft.Radius*1.1; %cm
SCL_Par.Act.Piston_Seat.Length = 20; %cm
SCL_Par.Act.Piston_Length = SCL_Par.Link.Length*0.675; %cm
SCL_Par.Act.Piston_Radius = SCL_Par.Act.Cylinder.Radius*0.9; %cm

SCL_Par.Act.Spring.Stiffness = 5e4; %cm
SCL_Par.Act.Spring.Damping = 9e3; %cm
SCL_Par.Act.Spring.Equilibrium_Position = SCL_Par.Link.Length; %cm

% Calculate initial extension
% Required for motion actuation in Ideal Actuator
SCL_Par.Act.InitExt = sqrt(...
    (SCL_Par.Act.Brkt.Flange.Offset_H*2+SCL_Par.Link.Length*sind(SCL_Par.Init.Base_Angle*2))^2 ...
    + (SCL_Par.Link.Length*cosd(SCL_Par.Init.Base_Angle*2)-SCL_Par.Act.Brkt.Flange.Offset_L*2)^2)/100;

% Cart
%SCL_Par.Cart.Axle.Radius = 4;  No longer used
SCL_Par.Cart.Axle.Wheel_Distance = SCL_Par.Link_Sep.Outer_Outer+10;
SCL_Par.Cart.Axle.Tire.Radius = 19;
SCL_Par.Cart.Axle.Rim.Radius = SCL_Par.Cart.Axle.Tire.Radius-5;
SCL_Par.Cart.Axle.Tire.Thickness = 15;
SCL_Par.Cart.Axle.Tire.Density = 100;
SCL_Par.Cart.Axle.Tire.Color = SCL_Par.Colors.Gray;
SCL_Par.Cart.Axle.Rim.Thickness = 10;
SCL_Par.Cart.Axle.Rim.Density = 1000;
SCL_Par.Cart.Axle.Rim.Color = [0.5 0.5 0.5];

SCL_Par.Cart.Axle.Tire.Stiffness = 1e5;
SCL_Par.Cart.Axle.Tire.Damping = 1e6;
SCL_Par.Cart.Axle.Tire.MuStatic = 0.8;
SCL_Par.Cart.Axle.Tire.MuKinetic = 0.5;
SCL_Par.Cart.Axle.Tire.MuVth = 0.005;

SCL_Par.Cart.Platform.Height = 10;
SCL_Par.Cart.Platform.Width = ...
    SCL_Par.Cart.Axle.Wheel_Distance+...
    SCL_Par.Cart.Axle.Tire.Thickness;
SCL_Par.Cart.Platform.Length = SCL_Par.Link.Length+40;

SCL_Par.Cart.Platform.Rim.Width = 2;
SCL_Par.Cart.Platform.Rim.Depth = SCL_Par.Base_Block.Height;
SCL_Par.Cart.Platform.Rim.Extrusion = Extr_Data_Box(...
    SCL_Par.Cart.Platform.Length,...
    SCL_Par.Cart.Platform.Length-SCL_Par.Cart.Platform.Rim.Width,...
    SCL_Par.Cart.Platform.Width,...
    SCL_Par.Cart.Platform.Width-SCL_Par.Cart.Platform.Rim.Width);

SCL_Par.Cart.Axle.Wheelbase = SCL_Par.Cart.Platform.Length-2*SCL_Par.Cart.Axle.Tire.Radius;

SCL_Par.Cart.Platform.Subhousing.FUD = 2;
SCL_Par.Cart.Platform.Subhousing.RUD = 5;
SCL_Par.Cart.Platform.Subhousing.FWHrad = 0.5*SCL_Par.Cart.Axle.Tire.Radius;
SCL_Par.Cart.Platform.Subhousing.RWHrad = SCL_Par.Cart.Axle.Tire.Radius;

SCL_Par.Cart.Platform.Subhousing.Extr = [...
    -SCL_Par.Cart.Platform.Length/2 SCL_Par.Cart.Platform.Subhousing.FUD;...
    -SCL_Par.Cart.Platform.Length/2 0;...
    -SCL_Par.Cart.Platform.Length/2+2*SCL_Par.Cart.Axle.Tire.Radius 0;...
    [-SCL_Par.Cart.Platform.Length/2+2*SCL_Par.Cart.Axle.Tire.Radius+sind(1:1:90)*SCL_Par.Cart.Platform.Subhousing.FWHrad; ...
    cosd(1:1:90)*SCL_Par.Cart.Platform.Subhousing.FWHrad-SCL_Par.Cart.Platform.Subhousing.FWHrad]';...
    -SCL_Par.Cart.Platform.Length/2+2*SCL_Par.Cart.Axle.Tire.Radius+SCL_Par.Cart.Platform.Subhousing.FWHrad ...
    -SCL_Par.Cart.Platform.Subhousing.FWHrad-SCL_Par.Cart.Axle.Tire.Radius*1.6;...
    SCL_Par.Cart.Platform.Length/2-SCL_Par.Cart.Axle.Tire.Radius*2.2...
    -SCL_Par.Cart.Platform.Subhousing.FWHrad-SCL_Par.Cart.Axle.Tire.Radius*1.6;
    SCL_Par.Cart.Platform.Length/2-SCL_Par.Cart.Axle.Tire.Radius*2.2...
    -SCL_Par.Cart.Platform.Subhousing.FWHrad-SCL_Par.Cart.Axle.Tire.Radius*0.8;
    [SCL_Par.Cart.Platform.Length/2+sind(-89:1:0)*SCL_Par.Cart.Axle.Tire.Radius*1.2-SCL_Par.Cart.Axle.Tire.Radius; ...
    cosd(-89:1:0)*SCL_Par.Cart.Axle.Tire.Radius*1.2-SCL_Par.Cart.Platform.Subhousing.FWHrad-SCL_Par.Cart.Axle.Tire.Radius*0.8]';...
    SCL_Par.Cart.Platform.Length/2 -SCL_Par.Cart.Axle.Tire.Radius*(0.1);...
    SCL_Par.Cart.Platform.Length/2 SCL_Par.Cart.Platform.Subhousing.FUD...
    ];
SCL_Par.Cart.Platform.Subhousing.Color = SCL_Par.Colors.Blue;

% Code for plotting subhousing cross section
% figure(1);
% plot(SCL_Par.Cart.Platform.Subhousing.Extr(:,1),SCL_Par.Cart.Platform.Subhousing.Extr(:,2));
% axis equal

% Environment
SCL_Par.Floor.Width = 10;
SCL_Par.Floor.Length = 10;
SCL_Par.Floor.Height = 0.05;

% Platform cage
SCL_Par.Cage.PipeWidth = 5; %cm
SCL_Par.Cage.Height  = 150; %cm
SCL_Par.Cage.RailRad = 20; %cm

% Platform extension
SCL_Par.Platform.Ext.Width = SCL_Par.Cart.Platform.Width-SCL_Par.Cage.PipeWidth*3; %cm
SCL_Par.Platform.Ext.Height  = SCL_Par.Cart.Platform.Height*0.5; %cm
SCL_Par.Platform.Ext.Length = SCL_Par.Cart.Platform.Length-SCL_Par.Cage.PipeWidth*3; %cm

% Platform extension cage
SCL_Par.Platform.Ext.Cage.Height = SCL_Par.Cage.Height-SCL_Par.Platform.Ext.Height;
SCL_Par.Platform.Ext.Cage.TrapRail.Curve1.H = SCL_Par.Platform.Ext.Cage.Height*0.4;
SCL_Par.Platform.Ext.Cage.TrapRail.Curve1.Rad = 20;
SCL_Par.Platform.Ext.Cage.TrapRail.Curve1.Ang = 30;
SCL_Par.Platform.Ext.Cage.TrapRail.Width = 90;

SCL_Par.Platform.Ext.Cage.TrapRail.Curve2.Rad = 20;
SCL_Par.Platform.Ext.Cage.TrapRail.Curve2.H = SCL_Par.Platform.Ext.Cage.Height-SCL_Par.Platform.Ext.Cage.TrapRail.Curve2.Rad;
SCL_Par.Platform.Ext.Cage.TrapRail.Curve2.Ang = 90-SCL_Par.Platform.Ext.Cage.TrapRail.Curve1.Ang;

% Joystick
SCL_Par.Joystick.Box = [40 20 20];
SCL_Par.Joystick.Stick.Rad = 3;
SCL_Par.Joystick.Stick.Len = 25;
SCL_Par.Joystick.Panel = [45 0.5 45];

% Behavior Specification
SCL_Par.Spec.Lift_Speed = 0.225;  % m/s

