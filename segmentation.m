hbdata_seg.frontal.raw = segment(hb_data.frontal.raw, info);
hbdata_seg.visual.raw = segment(hb_data.visual.raw, info);
hbdata_seg.all.raw = segment(hb_data.all.raw, info);

hbdata_seg.frontal.fil = segment(hb_data.frontal.fil, info);
hbdata_seg.visual.fil = segment(hb_data.visual.fil, info);
hbdata_seg.all.fil = segment(hb_data.all.fil, info);

hbdata_seg.frontal.CBSI = segment(hb_data.frontal.CBSI, info);
hbdata_seg.visual.CBSI = segment(hb_data.visual.CBSI, info);
%hbdata_seg.all.CBSI = segment(hb_data.all.CBSI, info, level);

% hbdata_seg.frontal.const_xcui = segment(hb_data.frontal.const_xcui, info, level);
% hbdata_seg.visual.const_xcui = segment(hb_data.visual.const_xcui, info, level);
% hbdata_seg.all.const_xcui = segment(hb_data.all.const_xcui, info, level);
% 
% hbdata_seg.frontal.const_nm = segment(hb_data.frontal.const_nm, info, level);
% hbdata_seg.visual.const_nm = segment(hb_data.visual.const_nm, info, level);
% hbdata_seg.all.const_nm = segment(hb_data.all.const_nm, info, level);

diffdata_seg.frontal = segment(diff_data.frontal,info);
%diffdata_seg.visual = segment(diff_data.visual,info);