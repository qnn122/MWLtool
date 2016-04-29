% Script file: basic_data_editing.m
% Purpose:
%   Perform some basic data manipulation processes and plot the results.
% 

close all; clear all; clc;
sub = input('sub = ');
%COLOR
fprintf('\n\n$$$load color data$$$\n\n');
link=strcat('D:\Google Drive\STUDY\Year4-2\Thesis\Code\MWL classification\workloadData\Subject',num2str(sub));
myFolder=strcat(link,'\','color');
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.mat');
Files = dir(filePattern);
level=[];
for k = 1:length(Files)
  baseFileName = Files(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  load(fullFileName);
  level=[level,color_data(1:end-1)];
end
level(level==2)=0;
level(level==1)=0;
level(level==4)=1;
level(level==3)=1;

%% Plot results
figure;
mark = [];

