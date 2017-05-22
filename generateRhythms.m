function [neuronActivity, concentrations] = generateRhythms(experiment)
neuronActivity = zeros(experiment.getNumOfNeurons, experiment.duration);
concentrations = zeros(experiment.getNumOfTransmitters, experiment.duration);
for t = 1:experiment.duration
    activeNeurons = findActiveNeurons(experiment,t);
    neuronActivity(:,t) = activeNeurons;
    concentrations(:,t) = updateECS(experiment, activeNeurons, t);
    updateNeuronsStates(experiment, concentrations(:,t));
end
end

%neuronActivity = round(rand(experiment.getNumOfNeurons, experiment.duration));
%concentrations = round(rand(experiment.getNumOfTransmitters, experiment.duration));

function conc = updateECS(experiment, activeNeurons, t)
conc = experiment.injection(:,t);
for i = 1:experiment.getNumOfNeurons
    conc = conc + experiment.neurons{i}.getOutput'*activeNeurons(i);
end
end

function activeNeurons = findActiveNeurons(experiment,t)
N = experiment.getNumOfNeurons;
M = experiment.getNumOfTransmitters;
activeNeurons = zeros(N,1);
%1. Initialization of ECS
ecs = experiment.injection(:,t);
%2. Initialization of neurons
for i=1:N
    neuron = experiment.neurons{i};
    activeNeurons(i) = neuron.willBeActive(ecs);
end

stop = false;
inhibition = false(N,1);
delta = zeros(N,1);
count = 1;
while ~stop && count<=N
    %3. Update ECS
    ecs = updateECS(experiment, activeNeurons, t );
    %4. Conflict resolution
    for i=1:N
        [inhibition(i), delta(i)] = experiment.neurons{i}.isInhibited(ecs);
    end
    if ~all(~(inhibition.*activeNeurons))
        delta(~activeNeurons) = inf;
        [~, loser] = min(delta);
        activeNeurons(loser) = 0;
    else
        %5. Finish
        stop = true;
    end
    count = count + 1;
end
end

function updateNeuronsStates(experiment, ECS)
for i = 1:experiment.getNumOfNeurons
    experiment.neurons{i}.nextState(ECS);
end
end