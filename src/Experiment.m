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
        %name - char array, the name of the experiment, for example 'Feeding CPG'    
        %expDuration - integer, the duration of the experiment
        %neurons - (N,1) cell array consisting of the neurons comprising
        %the extracellular space in the experiment
        %transmitters - (M,1) cell array consisting of neurotransmitters
        %involved
        %injection - (M,expDuration) double array contains external
        %injections of neurotransmitters at every time instance. 
        %   injection(i,t) is the amount of j-th neurotransmitter injected
        %   at time instance t
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
    
    methods (Static)
        function obj = loadFromFile(jsonFile)
            jsonText = fileread(jsonFile);
            jsonStruct = jsondecode(jsonText);
            obj = createFromJson(jsonStruct);
        end
    end
    
    methods (Static, Access = private)
        function obj = createFromJson(jsonStruct)
            error('The method is not implemented yet');
        end
    end
    
end