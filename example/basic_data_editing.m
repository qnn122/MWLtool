%% Script file: basic_data_editing.m
% Purpose:
%   Perform some basic data manipulation processes and plot the results.
% 
% Dependencies:
%   load_ad.m
%   conv.m
%   Input_para.m
%   calc_cont.m
%   CBSI.m

close all; clear all; clc;
% Let user pick the subject being analyzed
sub = input('sub = ');

%% Load and add more information
link=strcat('..\data\Thao_rubic\Subject',num2str(sub), '\data\data1.mat');
[info, ad_data] = load_ad(link);

%% Preparing marker vectors (for ploting)
mark = [];
for i=1:9
    mark = [mark; info.mark(i)];
    temp = info.mark(i+1:end);
    mark = [mark; round((temp(1)+mark(end))/2)];    
end
mark = [mark;info.mark(end)];
mark = round(mark.*info.ts);

w = round(info.task/info.ts);

%% ==== PROCESSING ====
i=0;
for ii=1:4:info.ad_ch_max/2*4-1
    i=i+1;
        mesData = ad_data.raw(:,ii:ii+3);
        [hbo, hb, hbt] = conv(mesData);
        hb_data.frontal.raw(1,:,i)=hbo(info.base_st:info.base_ed);
        hb_data.frontal.raw(2,:,i)=hb(info.base_st:info.base_ed);
        hb_data.frontal.raw(3,:,i)=hbt(info.base_st:info.base_ed);            
end
i=0;
for ii=info.ad_ch_max/2*4+1:4:info.ad_ch_max*4-1
    i=i+1;
        mesData = ad_data.raw(:,ii:ii+3);
        [hbo, hb, hbt] = conv(mesData);
        hb_data.visual.raw(1,:,i)=hbo(info.base_st:info.base_ed);
        hb_data.visual.raw(2,:,i)=hb(info.base_st:info.base_ed);
        hb_data.visual.raw(3,:,i)=hbt(info.base_st:info.base_ed);            
end

hb_data.all.raw = cat(3,hb_data.frontal.raw, hb_data.visual.raw);
info.size = size(hb_data.frontal.raw);   

% Load para
disp('Start loading parameters...');
Input_para;
disp('Done');

% Create time series
time = 0:info.ts:round(size(hb_data.frontal.raw,2)*info.ts)+info.ts;

% Process continuous data
hb_data = calc_cont( info, hb_data, para ); % included bp filter and moving average
    
% Smoothing
span = 155;
ch_num = info.ad_ch_max/2;
for ch = 1:ch_num
    hb_frontal(:,ch) = smooth(hb_data.frontal.fil(2,:,ch),span);
    hbo_frontal(:,ch)=smooth(hb_data.frontal.fil(1,:,ch),span);
    hb_visual(:,ch)=smooth(hb_data.visual.fil(2,:,ch),span);
    hbo_visual(:,ch)=smooth(hb_data.visual.fil(1,:,ch),span);
end

% Apply Correlation Based Signal Improvement (CSBI) method
for ch=1:ch_num
    [CBSI_hbo_frontal(:,ch),CBSI_hb_frontal(:,ch)]=CBSI(hbo_frontal(:,ch),hb_frontal(:,ch));
    [CBSI_hbo_visual(:,ch),CBSI_hb_visual(:,ch)]=CBSI(hbo_visual(:,ch),hb_visual(:,ch));
end

%% =========================== COLOR ====================================
fprintf('\n\n*** Loading COLOR \n\n');
link=strcat('..\data\Thao_rubic\Subject',num2str(sub));
myFolder=strcat(link,'\','color');

% Just to check if we're loading correct files
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
T = level';


%% ======== PLOTING ============
figure('Name', 'Signal after some processing and corresponding events', ...
        'Units', 'normalized', ...
        'Position', [0.1 0.1 0.8 0.8]);
    
subplot(2,2,1),
plot(time,CBSI_hbo_frontal,'color','r');
title('Frontal Oxygenated Hemoglobin', 'FontSize', 13, 'FontWeight', 'bold')
ylimit = get(gca,'ylim'); set_mark; set(gca,'XTick',45:90:855);
ylabel('oxy-Hb conc (mmol/l*cm)');xlabel('Time(s)');

subplot(2,2,2),
plot(time,CBSI_hb_frontal,'color','b');
title('Frontal Deoxygenated Hemoglobin', 'FontSize', 13, 'FontWeight', 'bold')
ylimit = get(gca,'ylim'); set_mark; set(gca,'XTick',45:90:855);
ylabel('oxy-Hb concentration (mmol/l*cm)');xlabel('Time(s)');

subplot(2,2,3),
plot(time,CBSI_hbo_visual,'color','r');
title('Visual Oxygenated Hemoglobin', 'FontSize', 13, 'FontWeight', 'bold')
ylimit = get(gca,'ylim'); set_mark; set(gca,'XTick',45:90:855);
ylabel('oxy-Hb concentration (mmol/l*cm)');xlabel('Time(s)');

subplot(2,2,4),
plot(time,CBSI_hb_visual,'color','b');
title('Visual Deoxygenated Hemoglobin', 'FontSize', 13, 'FontWeight', 'bold')
ylimit = get(gca,'ylim'); set_mark; set(gca,'XTick',45:90:855);
ylabel('oxy-Hb concentration (mmol/l*cm)');xlabel('Time(s)');