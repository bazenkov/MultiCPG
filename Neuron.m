classdef Neuron < matlab.mixin.Copyable
    
    properties
        name
        input %(M,1) row
        output %(M,1) row
        excThreshold
        inhThreshold
        burstDuration
        rechargePeriod
        PIR
        type
    end
    
    properties (Access=private)
        state = 1 %counts from previous activation
        wasExcited = false %true if the neuron was excited at the previous step
        wasInhibited = false %
        active = false %true if the neuron is active at the current step
    end
    
    methods
        function obj = Neuron(type, name, input, output, excThreshold, inhThreshold, PIR, burstDuration, rechargePeriod)
            obj.name = name;
            obj.type = type;
            assert(size(input,1) == 1);
            assert(size(output,1) == 1);
            assert(size(input,2) == size(output,2));
            
            obj.output = output;
            obj.input = input;
            obj.excThreshold = excThreshold;
            obj.inhThreshold = inhThreshold;
            obj.PIR = PIR;
            obj.burstDuration = burstDuration;
            obj.rechargePeriod = rechargePeriod;
        end
        
        function d = getOutput(obj)
            if (obj.wasInhibited)
                d = obj.output*obj.PIR;
            else
                d = obj.output;
            end
        end
        
        function act = isActive(obj)
            act = obj.active;
        end
        
        function act = nextState(obj, ECS)
            switch (obj.type)
                case NeuronType.OSCILLATOR
                    obj.nextStateOscillator(ECS);
                case NeuronType.FOLLOWER
                    obj.nextStateFollower(ECS);
                case NeuronType.TONIC
                    obj.nextStateTonic(ECS);
            end
            obj.wasExcited = obj.isExcited(ECS);
            obj.wasInhibited = obj.isInhibited(ECS);
            act = obj.isActive;
        end
        
        function act = willBeActive(obj, ECS)
            tmpObj = copy(obj);
            act = tmpObj.nextState(ECS);
        end
        
        function [inh, delta] = isInhibited(obj, ECS)
            delta = impact(obj.input, ECS) - obj.inhThreshold;
            if delta <= 0
                inh = true;
            else
                inh = false;
            end
        end
        
        function [exc, delta] = isExcited(obj, ECS)
            delta = impact(obj.input, ECS) - obj.excThreshold;
            if delta >= 0
                exc = true;
            else
                exc = false;
            end
        end
    end
    
    
    methods (Static)
        function obj = createTonic(name, input, output, inhThreshold, PIR)
            type = NeuronType.TONIC;
            excThreshold = inf;
            rechargePeriod = 0;
            burstDuration = inf;
            obj = Neuron(type, name, input, output, excThreshold, inhThreshold, PIR, burstDuration, rechargePeriod);
        end
        
        function obj = createFollower(name, input, output, excThreshold, inhThreshold)
            type = NeuronType.FOLLOWER;
            rechargePeriod = inf;
            burstDuration = 1;
            PIR = 1;
            obj = Neuron(type, name, input, output, excThreshold, inhThreshold, PIR, burstDuration, rechargePeriod);
        end
        
        function obj = createOscillator(name, input, output, excThreshold, inhThreshold, PIR, burstDuration, rechargePeriod)
            type = NeuronType.OSCILLATOR;
            obj = Neuron(type, name, input, output, excThreshold, inhThreshold, PIR, burstDuration, rechargePeriod);
        end
    end
    
    methods (Access = private)
        function obj = nextStateOscillator(obj, ECS)
            if obj.state == obj.rechargePeriod
                if obj.isInhibited(ECS)
                    obj.active = false;
                else
                    obj.active = true;
                    obj.state = 1;
                end
            else
                if obj.wasExcited && ~obj.isInhibited(ECS)
                    obj.state = 1;
                    obj.active = true;
                else
                    obj.state = obj.state + 1;
                    obj.active = false;
                end
            end
        end
        
        function act = nextStateFollower(obj, ECS)
            obj.active = obj.wasExcited && ~obj.isInhibited(ECS);
            act = obj.active;
        end
        
        function act = nextStateTonic(obj, ECS)
            obj.active = ~obj.isInhibited(ECS);
            act = obj.active;
        end
    end
end

%ECS is a column, input is a row
function w = impact(input, ECS)
w = sum(input*ECS);
end