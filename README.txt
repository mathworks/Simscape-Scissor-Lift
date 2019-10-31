Scissor Lift Model in SimMechanics

scissor lift model built using SimMechanics and Simscape. 
The scissor lift model is assembled from a set of parameterized 
component models, which are included in a separate library.  
A number of intermediate models are also included to show you 
the incremental steps of modeling this system.  
A MATLAB GUI is also included that allows you to interactively change 
the dimensions of the scissor lift.

Key parts of this submission:

1. Run startup_Scissor_Lift.m to begin
   This sets up the path and opens the completed scissor lift with an 
   ideal actuator and controller.

2. The parameterized components used to build the scissor lift
   are in the file Scissor_Parts_Lib.mdl in subdirectory "Libraries".

3. Subdirectory 01_Scissor_Jack contains incremental steps for
   building the scissor lift, including a "X" assembly that uses only
   blocks from the standard SimMechanics libraries.

4. Subdirectory 02_Defining_Bodies contains incremental steps for
   defining and parameterizing bodies, including a MATLAB GUI that
   allows you to modify the dimensions of the lift.

5. Subdirectory 03_Scissor_Lift contains incremental steps for
   adding an actuator to the scissor lift.

6. MATLAB scripts for defining extrusions are in subddirectory Scripts_Data.


Copyright 2012 The MathWorks, Inc.

