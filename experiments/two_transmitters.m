addpath ..
addpath ../src
printFolder = '../output/feeding/2 nt';
printFormat = 'EPS';
experiment = createFeedingCPG_TwoNT;
experiment.name = 'Feeding CPG - Glu injection';
experiment.duration = 10;

%%create injection of XXX transmitter
%riseLimit = ceil(experiment.duration/2);
injection = zeros(experiment.getNumOfTransmitters, experiment.duration);
GLU_IND = 2;
indInjection = 1:experiment.duration;%floor(experiment.duration/2):experiment.duration;
%injection(GLU_IND, indInjection) = 0.05*indInjection;
%injection(GLU_IND, indInjection) = 1;
%experiment.injection = injection;

%simulate(experiment, 'PrintFolder', printFolder, 'PrintFormat', printFormat);
simulate(experiment);

%figure;
%plot(1:experiment.duration, injection);