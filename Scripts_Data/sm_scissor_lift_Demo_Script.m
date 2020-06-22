%% Scissor Lift Demo Script
%
% <html>
% <span style="font-family:Arial">
% <span style="font-size:10pt">
% <tr>   <img src="sm_scissor_lift_demoScript_IMAGE.png" alt="Scissor Lift Image"><br>
% <br>
% <tr><b><u>Model</u></b><br>
% <tr>1.  Scissor Lift Test Environment: <a href="matlab:cd(fileparts(which('sm_scissor_lift_testenv.slx')));open_system('sm_scissor_lift_testenv');">Open Model</a>, <a href="matlab:cd(ScissLift_HomeDir);web('sm_scissor_lift_testenv.html');">Documentation</a><br>
% <br>
% <tr><b><u>Library</u></b><br>
% <tr>2.  <a href="matlab:open_system('sm_scissor_lift_lib');">Open Scissor Lift Parts Library</a><br>
% <br>
% <tr><b><u>Modeling Process</u></b><br>
% <tr>3.  Link and Pivot Point, Standard Geometry: <a href="matlab:open_system('Bodies_1_Standard_Geometry');">Link and Base</a><br>
% <tr>4.  Defining Bodies, Custom Geometry: <a href="matlab:open_system('Bodies_2_Custom_Link_2Hole');">Two Hole Links</a>, <a href="matlab:open_system('Bodies_3_Custom_Link_3Hole');">Three Hole Links</a><br>
% <tr>5.  Parameterizing Bodies with Masks: <a href="matlab:open_system('Bodies_4_Parameterized_Link_3Hole');">Link with Basic Mask</a><br>
% <tr>6.  Component Reuse: <a href="matlab:open_system('Bodies_5_Parameterized_Mechanism');">Single Link Pair</a>, <a href="matlab:open_system('Bodies_6_Scissor_2_Stage');">Scissor Mechanism 2 Stages</a><br>
% <tr>7.  Guiding Assembly: <a href="matlab:open_system('Bodies_7_Scissor_3_Stage');">Scissor Mechanism 3 Stages</a><br>
% <tr>8.  Attachment Point Analysis: <a href="matlab:edit('sm_scissor_lift_testenv_sweep_actattpt');">Code for Parameter Sweep</a>, <a href="matlab:open('sm_scissor_lift_testenv_sweep_actattpt.fig');">Plot of Results</a><br>
% <br>
% <tr><b><u>Actuator Design</u></b><br>
% <tr>9.  Hydraulic Actuation: <a href="matlab:open_system('sh_cyl_single_acting_3pos');">Open Model</a>, <a href="matlab:web('sh_cyl_single_acting_3pos.html');">Documentation</a><br>
% <tr>10. <a href="matlab:open_system('Bodies_8_Lift_Actuation');">Scissor Lift Actuation</a><br>
% <br>
% </style>
% </style>
% </html>
% 
%
% Copyright 2016-2020 The MathWorks, Inc.

