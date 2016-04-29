function [ oxy,deoxy, total ] = conv( data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

k1=-1.4887;
k2=0.5970;
k3=1.4847;
k4=1.8545;
k5=-0.2394;
k6=-1.0947;

oxy=[];
deoxy=[];
D=data(:,1);
L1=data(:,2);
L2=data(:,3);
L3=data(:,4);

L1=double(L1);
L2=double(L2);
L3=double(L3);
D=double(D);
v780=10.0*(L1/32768.0);
v805=10.0*(L2/32768.0);
v830=10.0*(L3/32768.0);
dark=10.0*(D/32768.0);

ohb_temp = -k1 * v780 - k2 * v805 - k3 * v830;
dehb_temp =- k4 * v780 - k5 * v805 - k6 * v830;

oxy=[oxy,ohb_temp];
deoxy=[deoxy,dehb_temp];
total = oxy + deoxy;
end

