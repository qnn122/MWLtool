f = figure('Units','normalized','Position',[0 0 1 1]);

mark = [];
for i=1:9
    mark = [mark; info.mark(i)];
    temp = info.mark(i+1:end);
    mark = [mark; round((temp(1)+mark(end))/2)];    
end
mark = [mark;info.mark(end)];
mark = round(mark.*info.ts);

w = round(info.task/info.ts);

%%
%Plot signals
span =155;
ch_num = info.ad_ch_max/2;

%%
%Preprocessing
for ch = 1:ch_num
    hb_frontal(:,ch) = smooth(hb_data.frontal.fil(2,:,ch),span);
    hbo_frontal(:,ch)=smooth(hb_data.frontal.fil(1,:,ch),span);
    hb_visual(:,ch)=smooth(hb_data.visual.fil(2,:,ch),span);
    hbo_visual(:,ch)=smooth(hb_data.visual.fil(1,:,ch),span);
end

%%
%CBSI
for ch=1:ch_num
    [CBSI_hbo_frontal(:,ch),CBSI_hb_frontal(:,ch)]=CBSI(hbo_frontal(:,ch),hb_frontal(:,ch));
    [CBSI_hbo_visual(:,ch),CBSI_hb_visual(:,ch)]=CBSI(hbo_visual(:,ch),hb_visual(:,ch));
end

subplot(2,2,1),
plot(time,CBSI_hbo_frontal,'color','r');
ylimit = get(gca,'ylim'); set_mark; set(gca,'XTick',45:90:855);
ylabel('oxy-Hb conc (mmol/l*cm)');xlabel('Time(s)');

subplot(2,2,2),
plot(time,CBSI_hb_frontal,'color','b');
ylimit = get(gca,'ylim'); set_mark; set(gca,'XTick',45:90:855);
ylabel('oxy-Hb concentration (mmol/l*cm)');xlabel('Time(s)');

subplot(2,2,3),
plot(time,CBSI_hbo_visual,'color','r');
ylimit = get(gca,'ylim'); set_mark; set(gca,'XTick',45:90:855);
ylabel('oxy-Hb concentration (mmol/l*cm)');xlabel('Time(s)');

subplot(2,2,4),
plot(time,CBSI_hb_visual,'color','b');
ylimit = get(gca,'ylim'); set_mark; set(gca,'XTick',45:90:855);
ylabel('oxy-Hb concentration (mmol/l*cm)');xlabel('Time(s)');