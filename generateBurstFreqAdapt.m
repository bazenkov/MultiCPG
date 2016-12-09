function [neurons M W output period start_active] = generateBurstFreqAdapt
global FREQ_ADAPT;
global BURSTING;
neurons = [BURSTING FREQ_ADAPT];
M = 2;
N = length(neurons);
output = zeros(N,1);
output(1) = 1;
output(2) = 2;
W = zeros(N,M);
%W(1,output(2)) = -1;
W(2,output(1)) = 1;
period = [1 0];
start_active = [1 0]';