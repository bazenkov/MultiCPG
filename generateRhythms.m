function [neuronActivity, concentrations] = generateRhythms(experiment)
neuronActivity = round(rand(experiment.getNumOfNeurons, experiment.duration));
concentrations = round(rand(experiment.getNumOfTransmitters, experiment.duration));