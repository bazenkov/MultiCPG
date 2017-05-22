classdef Experiment
    
    properties
        name
        duration
        neurons
        transmitters
        injection
    end
    
    methods
        function obj = Experiment(name, expDuration, neurons, transmitters, injection)
            
            obj.duration = expDuration;
            obj.neurons = neurons;
            obj.transmitters = transmitters;
            obj.name = name;
            if nargin==4 %injection not provided
                obj.injection = zeros(length(transmitters), expDuration);
            else
                obj.injection = injection;
            end            
        end
        
        function obj = set.duration(obj, newValue)
            if (newValue<=0 || fix(newValue)~=newValue)
                error('Experiment:set:duration', 'Invalid input %4.2f - duration must be positive integer', newValue);
            end
            obj.duration = newValue;
        end
        
        function n = getNumOfNeurons(obj)
            n = length(obj.neurons);
        end
        
        function n = getNumOfTransmitters(obj)
            n = length(obj.transmitters);
        end
        
    end
    
end