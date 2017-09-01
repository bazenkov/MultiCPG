%Feeding example
actN1 = [1 0 0 1 0 0 1];
actN2 = [0 1 0 0 1 0 0];
actN3 = [0 0 1 0 0 1 0];
activity = [actN1; actN2; actN3];

concT1 = [1 0 0 1 0 0 1];
concT2 = [0 2 0 0 2 0 0];
concT3 = [0 0 1.5 0 0 1.5 0];

concentrations = [concT1; concT2; concT3];

experiment = createFeedingGPG;

plotResults(activity, concentrations, experiment);
