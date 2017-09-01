experiment = createFeedingCPG;
printFolder = 'output/feeding';
printFormat = 'EPS';

injection = zeros(experiment.getNumOfTransmitters, experiment.duration);


%injectionXXX(ceil(duration/2)+1:end) = ceil(duration/2):0
%injection(3,:) = 1;
riseLimit = ceil(experiment.duration/2);
injectionXXX = zeros(1,experiment.duration); 
injectionXXX(1:riseLimit) = (0:riseLimit-1)/20 + (rand-0.5)*0.5;
injectionXXX(riseLimit+1:end) = (riseLimit-1:-1:0)/20 + (rand-0.5)*0.5-0.2;


%experiment.injection(3,:) = 0.4 + rand(1,experiment.duration)*0.5;%injectionXXX;
experiment.name = 'Feeding CPG';
experiment.duration = 11;

simulate(experiment)%, 'PrintFolder', printFolder, 'PrintFormat', printFormat);