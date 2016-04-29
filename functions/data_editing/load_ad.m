function [ info, ad_data] = load_ad( link )
% LOAD_AD loads additional data into the raw one. Its also defines some
% important information and stores them into 'info'.
% 
% In:
%   link: the filepath to the raw data (.mat)
% Out:
%   info: a structure that contains information from the experiment
%       + ad_ch_max:    maximum number of channels being analyzed
%       + ts (s):       time distance
%       + task (s):     task duration
%       + rest (s):     rest duration
%       + pre (s):      pre-experiment duration
%       + post (s):     post-experiment duration
%       + bast_st <1x1>:base start ?
%       + base_ed <1x1>:base end ?
%       + mark <nx1>:   event markers
%       + adnmpn    :   not sure, seems to be the indexes of channels
%   ad_data: data with additional info
%       + raw <nxm> :   selected data where n is the number of sample
%       points and m is equal (number of selected channels x 4)
%       + title1, title2, title3 : wavelength values
% Exampe:
%   link = '.\data\Thao_rubic\Subject1\data\data1.mat';
%   [info, ad_data] = load_ad(link);


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
info.mark = find(testdata(:,5)==16); % TASK -> REST
info.base_st = info.mark(1)-round(info.rest/info.ts);   % Remove base line 
info.base_ed = info.mark(end)+round(info.task/info.ts);
info.mark = info.mark - info.base_st;
info.adnmpn = [0:info.ad_ch_max-1];
end

