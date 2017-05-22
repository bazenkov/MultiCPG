function output = printResults(experiment, hFigure, printFolder, format)
if ~exist(printFolder, 'dir')
    mkdir(printFolder);
end

fileName = formFilename(experiment);
fullPath = fullfile(printFolder, fileName);
switch(format)
    case 'JPEG'
         print(hFigure, '-painters','-djpeg90', '-r600', fullPath);     
         ext = '.jpg';
    case 'EPS'
        print(hFigure, '-depsc', fullPath);
        ext = '.eps';
    case 'PNG'
        print(hFigure, '-dpng', fullPath);
        ext = '.png';
    otherwise
        error('printResults:InvalidInput', 'Unknown file format: %s', format);
end
fileNameWithExt = strcat(fileName, ext);
fullPathWithExt = fullfile(printFolder, fileNameWithExt);
output = struct('PrintFolder', printFolder, 'PrintFile', fileNameWithExt, 'Path', fullPathWithExt);

end

function fileName = formFilename(experiment)
 fileName = strcat(experiment.name, ...
     '-d', num2str(experiment.duration), ...
     '-n', num2str(experiment.getNumOfNeurons), ...
     '-t', num2str(experiment.getNumOfTransmitters));
end