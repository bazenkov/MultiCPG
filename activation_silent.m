function y = activation_silent(input, ICS)
global ACT_THRES;
y = dot(input,ICS)>=ACT_THRES;