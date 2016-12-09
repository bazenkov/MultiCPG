function y = activation_tonic(input, ics)
global INH_THRES;
inhibition = dot(input,ics)<=INH_THRES;
y = ~inhibition;