% *** Shared data section ***
%Input experiment
defaultDuration = 5;
defaultName = 'Test Experiment';
correctNeurons = {[],[],[]};
correctTransmitters = {[],[],[]};
correctExperiment = Experiment(defaultName, defaultDuration, correctNeurons, correctTransmitters);
incorrectExperiment = [];
%Output options
printFolder = 'output';
notExistPrintFolder = 'notExistFolder';
correctFormats = {'JPEG', 'EPS', 'PNG'};
incorrectFormats = {'BMP', 'jpeg'};

%clear output folder
delete(fullfile(printFolder,'*'));

%% test correct object input
[neuronActivity, concentrations] = simulate(correctExperiment);
assert(~isempty(neuronActivity));
assert(~isempty(concentrations));
assert(size(neuronActivity,2) == correctExperiment.duration)
close all;

%% test correct file input


%% test print folder exists format not specified
[a,c,output] = simulate(correctExperiment, 'PrintFolder', printFolder);
assert(strcmp(output.PrintFolder, printFolder));
checkFile = strcat(correctExperiment.name, ...
    '-d', num2str(correctExperiment.duration), ...
    '-n', num2str(correctExperiment.getNumOfNeurons), ...
    '-t', num2str(correctExperiment.getNumOfTransmitters),...
    '.jpg');
assert(strcmp(output.PrintFile, checkFile));
info = dir(output.Path);
assert(~isempty(info));
assert(strcmp(info.name, checkFile));
close all;

%% test print folder does not exist
DIRECTORY_CODE = 7;
if (exist(notExistPrintFolder, 'dir')==DIRECTORY_CODE)
    rmdir(notExistPrintFolder, 's');
end
assert(~exist(notExistPrintFolder, 'dir'));
[a,c,output] = simulate(correctExperiment, 'PrintFolder', notExistPrintFolder);
assert(exist(notExistPrintFolder, 'dir')==DIRECTORY_CODE);
info = dir(output.Path);
assert(~isempty(info));
rmdir(notExistPrintFolder, 's');
close all;

%% test incorrect print format



%% test specified format



%% test incorrect object input
try
    [neuronActivity, concentrations] = simulate(incorrectExperiment);
    assert(false, 'Error was not thrown on incorrect experiment');
catch ME
    assert(strcmp(ME.identifier, 'simulate:parseInput'));
end
close all;

%% test empty input
try
    [neuronActivity, concentrations] = simulate();
    assert(false, 'Error was not thrown on incorrect experiment');
catch ME
    assert(strcmp(ME.identifier, 'simulate:parseInput'));
end
close all;

%% test incorrect file input

%% test incorrect print folder