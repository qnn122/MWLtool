function [ hb_data ] = calc_cont( info, hb_data, para )
% CALC_CONT makes continuous Hb data function
% 
% In:
%   info <struct> : defines experiment information
%   hb_data <struct>: all hemoglobin data whose fiels are hemo values
%   across different cortex. Each field is a structure ifself that contains
%   HbO, Hb, and totalHb across all channels, raw and filtered as well. for
%   example:
%       hb_data.frontal.raw : raw data whose dimension is <3 x numsample x numchannel>/
%                             First row = HbO, second = Hb, third = total.
%       hb_data.frontal.fil : filtered data
%   para <struct> : defines filters' parameters
% Out:
%   hb_data <struct>: continuous Hb data


%Bandpass filter
Fs = 1/info.ts;
[b,a]=ellip(4,0.1,40,[para.high_val para.low_val]*2/Fs);
[H,w]=freqz(b,a,512);
    
    for i=1:info.ad_ch_max/2;
            hb_data.frontal.fil(1,:,i) = filtfilt(b,a,hb_data.frontal.raw(1,:,i));
            hb_data.frontal.fil(2,:,i) = filtfilt(b,a,hb_data.frontal.raw(2,:,i));
            hb_data.frontal.fil(3,:,i) = filtfilt(b,a,hb_data.frontal.raw(3,:,i));
            hb_data.visual.fil(1,:,i) = filtfilt(b,a,hb_data.visual.raw(1,:,i));
            hb_data.visual.fil(2,:,i) = filtfilt(b,a,hb_data.visual.raw(2,:,i));
            hb_data.visual.fil(3,:,i) = filtfilt(b,a,hb_data.visual.raw(3,:,i));
    end;  

%Moving average
a = 1;
b(1:ceil(Fs*para.mov_val))=1/(Fs*para.mov_val);
    for i=1:info.ad_ch_max/2;
            hb_data.frontal.fil(1,:,i) = filtfilt(b,a,hb_data.frontal.fil(1,:,i));
            hb_data.frontal.fil(2,:,i) = filtfilt(b,a,hb_data.frontal.fil(2,:,i));
            hb_data.frontal.fil(3,:,i) = filtfilt(b,a,hb_data.frontal.fil(3,:,i));
            hb_data.visual.fil(1,:,i) = filtfilt(b,a,hb_data.visual.fil(1,:,i));
            hb_data.visual.fil(2,:,i) = filtfilt(b,a,hb_data.visual.fil(2,:,i));
            hb_data.visual.fil(3,:,i) = filtfilt(b,a,hb_data.visual.fil(3,:,i));
    end;  

hb_data.all.fil = cat(3, hb_data.frontal.fil, hb_data.visual.fil);    
end

