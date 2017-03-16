function [neurons M W output num_output periods start_active] = generateOscTon
global BURSTING;
global TONIC;
neurons = [BURSTING TONIC];
M = 2;
N = length(neurons);
output = zeros(N,1);
output(1) = 1;
output(2) = 2;
num_output = ones(N,1);
W = zeros(N,M);
%W(1,output(2)) = -1;
W(2,output(1)) = -1;

periods = [3 0];
start_active = [1 0]';