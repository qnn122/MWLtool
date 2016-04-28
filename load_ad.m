function [ info, ad_data] = load_ad( link )
%info
info.ad_ch_max = 14;
info.ts = 0.055;
info.rest = 45;
info.task = 45;
info.pre = 10;
info.post = 45;

%ad_data
load(link);
ad_data.raw = testdata(:,8:8+4*info.ad_ch_max-1);
ad_data.title1 = '780';
ad_data.title2 = '805';
ad_data.title3 = '830';

%info
info.mark = find(testdata(:,5)==16);
info.base_st = info.mark(1)-round(info.rest/info.ts);
info.base_ed = info.mark(end)+round(info.task/info.ts);
info.mark = info.mark - info.base_st;
info.adnmpn = [0:info.ad_ch_max-1];
end

