function [neurons M W output num_output period start_active] = generateBurstFreqAdapt
global TONIC;

neurons = [TONIC TONIC];
M = 2;
N = length(neurons);
output = zeros(N,1);
output(1) = 1;
output(2) = 2;
num_output = ones(N,1);
W = zeros(N,M);
W(1,output(2)) = -1;
W(2,output(1)) = -1;
period = [1 0];
start_active = [1 1]';