function [neuronActivity, concentrations, output] = simulate(varargin)
%Usage
%simulate(experiment) - generates rhythms for the specified experiment and
%show results in plots. If 'PrintFolder' additional argument is present the
%program will save the plots in the specified folder.
%
%simulate('File', file) - the file contains experiment description
%
%simulation(..., Name, Value) - generates rhythms and does additional
%actions as specified in name-value pairs
%
%Additional arguments:
%'PrintFolder' - a path to the folder where the program should put the
%printed plots and experiment description
%
% *** NOT IMPLEMENTED YET:
%'ModelType' - the type of neuronal dynamics model. Possible values are 'simple' (default) and 'competitive'. Currently the only possible value is simle.

[experiment, printFolder, printFormat] = parseInput(varargin{:});

[neuronActivity, concentrations] = generateRhythms(experiment);

hFigure = plotResults(neuronActivity, concentrations, experiment);

if ~isempty(printFolder)
    output = printResults(experiment, hFigure, printFolder, printFormat);
else
    output = struct([]);
end

end

function [experiment, printFolder, printFormat] = parseInput(varargin)
p = createInputParser;
parse(p, varargin{:});
%Either experiment or 'File' must be specified
if isempty(p.Results.experiment)
    if isempty(p.Results.File)
        error('simulate:parseInput','Invalid input: experiment or File is not set');
    end
    experiment = readExperiment(p.Results.File);
else
    if ~isobject(p.Results.experiment)
        error('Invalid input: experiment must be object');
    end
    experiment = p.Results.experiment;
end
printFolder = p.Results.PrintFolder;
printFormat = p.Results.PrintFormat;
end

function p = createInputParser
p = inputParser;
p.addOptional('experiment', []);
p.addParameter('File', '', @ischar);
p.addParameter('PrintFolder', '', @ischar);
p.addParameter('PrintFormat', 'JPEG', @ischar);

end