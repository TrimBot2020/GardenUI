%% generate trimbot custom msgs

addpath(genpath('/home/radim/Documents/MATLAB/SupportPackages/R2016b/toolbox/robotics/supportpackages/roscustommsg'));
%% 
% package.xml cannot be format v2 !!!!
rosgenmsg('/home/radim/TrimBot/ros_matlab');

%%
% To use the custom messages, follow these steps:
%  
% 1. Edit javaclasspath.txt, add the following file locations as new lines, and save the file:
%  
% /home/radim/Documents/proj/TrimBot/GardenUI/trimbot_msgs/jar/trimbot_msgs-1.0.0.jar
%  
% 2. Add the custom message folder to the MATLAB path by executing:
%  
% addpath('/home/radim/Documents/proj/TrimBot/GardenUI/trimbot_msgs/msggen')
% savepath
%  
% 3. Restart MATLAB and verify that you can use the custom messages. 
%    Type "rosmsg list" and ensure that the output contains the generated
%    custom message types.