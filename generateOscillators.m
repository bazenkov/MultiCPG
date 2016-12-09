function [neurons M W output periods start_active] = generateOscillators
global BURSTING;
neurons = [BURSTING BURSTING];
M = 2;
N = length(neurons);

output = zeros(N,1);
output(1) = 1;
output(2) = 2;
W = zeros(N,M);
W(1,output(2)) = -1;
W(2,output(1)) = -1;
periods = [2 2];
start_active = [1 0]';