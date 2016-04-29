%*******************************************************
%*         Make Continuous Hb Data Function            *
%*******************************************************

function [ hb_data ] = calc_cont( info, hb_data, para )

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

