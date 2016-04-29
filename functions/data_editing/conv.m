function [oxy, deoxy, total] = conv(data)
% CONV converts raw data from ONE channel to hemoglobin data
% 
% In:
%   data <nx4>: 4 columns contains: dark, wavelength 780, 805, 830
%   respectively
% Out:
%   oxy <nx1>:  oxygenated hemoglobin data
%   deoxy <nx1>:deoxygenated hemoglobin
%   total <nx1>:total hemoglobin
%
% Example:
%   link = '..\..\data\Thao_rubic\Subject1\data\data1.mat';
%   [info, ad_data] = load_ad(link);        % Select recorded channels
%   [oxy, deoxy, total] = conv(ad_data.raw(:, 1:4));    % convert first channel
%
% Dependecies:
%   k_coeff.mat
%

% Check if dimensions of the input data are correct
[nrow, ncol] = size(data);
if ncol ~= 4
    error('The number of columns must be equal than 4');
elseif nrow < ncol
    error('The input data must be in form of <nx4> where n is the number of sample points');
end
    
% Load k coefficients
load('k_coeff');

% Converting
D = double(data(:,1));  % Dark values
L1= double(data(:,2));  % wavelength 1
L2= double(data(:,3));  % 2
L3= double(data(:,4));  % 3

v780=10.0*(L1/32768.0);
v805=10.0*(L2/32768.0);
v830=10.0*(L3/32768.0);
dark=10.0*(D/32768.0);

oxy = -k1 * v780 - k2 * v805 - k3 * v830;
deoxy =- k4 * v780 - k5 * v805 - k6 * v830;
total = oxy + deoxy;
end

