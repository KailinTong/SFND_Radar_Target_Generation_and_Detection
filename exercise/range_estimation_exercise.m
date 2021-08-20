clear; clc;
radar_max_range = 300; %m
range_resolution = 1; % m
c = 3 * 10^8; %m/s
% TODO : Find the Bsweep of chirp for 1 m resolution
Bsweep = c / (2 * range_resolution);

% TODO : Calculate the chirp time based on the Radar's Max Range
Ts = 5.5 * 2 * radar_max_range / c;

% TODO : define the frequency shifts 
Fb = [0, 1.1 , 13 , 24 ] * 10^6; % MHz

% Display the calculated range
calculated_range = c * Fb * Ts / (2 * Bsweep);
disp(calculated_range);