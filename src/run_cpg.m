
printFolder = '../output/feeding';
printFormat = 'EPS';
experiment = createFeedingCPG;
experiment.name = 'Feeding CPG';
experiment.duration = 12;

%%create injection of XXX transmitter
%riseLimit = ceil(experiment.duration/2);
injection = zeros(experiment.getNumOfTransmitters, experiment.duration);
XXX_IND = 3;
indInjection = 1:experiment.duration;%floor(experiment.duration/2):experiment.duration;
injection(XXX_IND,indInjection) = 1 - 0.08*indInjection;
experiment.injection = injection;

simulate(experiment, 'PrintFolder', printFolder, 'PrintFormat', printFormat);