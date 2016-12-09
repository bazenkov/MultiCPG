function y = activation(neuron_type, input, activity, ICS, period)
global BURSTING;
global FREQ_ADAPT;
global TONIC;
switch neuron_type
    case FREQ_ADAPT
        y = activation_silent(input, ICS);
    case BURSTING
        y = activation_burst(input, activity, period, ICS);
    case TONIC
        y = activation_tonic(input, ICS);
end