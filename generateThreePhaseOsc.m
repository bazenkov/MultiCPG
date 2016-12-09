function [neurons M W output num_output periods start_active] = generateThreePhaseOsc
global BURSTING;
global FREQ_ADAPT;
neurons = [BURSTING FREQ_ADAPT BURSTING];
M = 2;
N = length(neurons);

output = zeros(N,1);
TRANS_A = 1;
TRANS_B = 2;
output(1) = TRANS_A;
output(2) = TRANS_B;
output(3) = TRANS_B;
num_output = ones(N,1);
num_output(2) = 1;
W = zeros(N,M);
W(1,TRANS_B) = -1;
W(2,TRANS_A) = 1;
W(2,TRANS_B) = -1;
W(3,TRANS_A) = -1;
W(3,TRANS_B) = -1;
periods = [3 0 2];
start_active = [1 0 0]';