% *** Shared data section ***
%Input experiment
addpath ..
correctExperiment = createTestExperiment;
hcoExp = createHalfCenterOscillator;
feedingCPGExp = createFeedingCPG;

%% test output and concentration consistency
[neuronActivity, concentrations] = generateRhythms(correctExperiment);

%% test hco
[neuronActivity, concentrations] = generateRhythms(hcoExp);

%% test feeding cpg
[neuronActivity, concentrations] = generateRhythms(feedingCPGExp)