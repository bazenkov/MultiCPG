function y = activation_burst(input, activity, period, ics)
%activity - the activity of the neuron since 1 to t-1

%was inactive last 'period'
TLENGTH = length(activity);
was_inact = true;
for t=TLENGTH:-1:(TLENGTH-period+1)
    if (t==0)
        break;
    else
        if (activity(t))
            was_inact = false;
            break;
        end
    end
end
global INH_THRES;
inhibition = dot(input,ics)<=INH_THRES;
y = (~inhibition) && was_inact;