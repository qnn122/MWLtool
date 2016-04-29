function [ data_seg ] = segment( data, info )
pre = round(info.pre/info.ts);
post = round(info.post/info.ts);
task = round(info.task/info.ts);

if size(data,1)==3
hbo = data(1,:,:);
hb = data(2,:,:);
%hbt = data(3,:,:);

%%

%hbo
for i=1:info.ad_ch_max/2
    for j=1:length(info.mark)-1
        seg(j,:,i) = hbo(:,info.mark(j)-pre:info.mark(j)+task+post-1,i);
    end
end
data_seg.hbo = seg;
%%
%hb
for i=1:info.ad_ch_max/2
    for j=1:length(info.mark)-1
        seg(j,:,i) = hb(:,info.mark(j)-pre:info.mark(j)+task+post-1,i);
    end
end
data_seg.hb = seg;
else
    for i=1:info.ad_ch_max/2
        for j=1:length(info.mark)-1
            seg(j,:,i) = data(:,info.mark(j)-pre:info.mark(j)+task+post-1,i);
        end
    end
    data_seg = seg;
end
%%
%hbt
% for i=1:info.ad_ch_max/2
%     for j=1:length(info.mark)-1
%         seg(j,:,i) = hbt(:,info.mark(j)-pre:info.mark(j)+task+post-1,i);
%     end
% end
% data_seg.hbt = seg;
end

