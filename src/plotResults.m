function hFigure = plotResults(neuronActivity, concentrations, experiment)
plotOptions = preparePlotOptions(experiment);

hFigure = plotNeurons(experiment, neuronActivity, plotOptions);
plotTransmitters(experiment, concentrations, plotOptions);
xlabel('time', 'FontSize', 12);

end

function n = getNumOfPlots(experiment)
n = experiment.getNumOfNeurons + experiment.getNumOfTransmitters;
end

function plotOptions = preparePlotOptions(experiment)

numPlots = getNumOfPlots(experiment);
%*** Figure size and position ***
ONE_BURST_WIDTH = 50;
ONE_GRAPH_HEIGHT = 80;

height = numPlots*ONE_GRAPH_HEIGHT;
width = experiment.duration*ONE_BURST_WIDTH;
screenSize = get(groot,'ScreenSize');
left = screenSize(3)/2 - width/2;
bottom = screenSize(4)/2 - height/2;

plotOptions = struct( ...
    'width', width, ...
    'height', height, ...
    'left', left, ...
    'bottom', bottom);

%*** Plot colors ***
COLOR_NEURON = [0 0 0];
plotOptions.neuronColors = {};
for i=1:experiment.getNumOfNeurons
    plotOptions.neuronColors{i} = COLOR_NEURON;
end
%COLORS_TRANS = {'red', 'green', 'blue'};%, 'magenta', 'yellow', 'cyan'};
COLORS_TRANS = {[1 0 0], [0 1 0], [0 0 1]};%, 'magenta', 'yellow', 'cyan'};
plotOptions.transmitterColors = {};
for j=1:experiment.getNumOfTransmitters
    plotOptions.transmitterColors{j} = COLORS_TRANS{mod(j, length(COLORS_TRANS)+1) + 1*(j==length(COLORS_TRANS)+1)};
end
end

function hFigure = plotNeurons(experiment, neuronActivity, plotOptions)
numPlots = getNumOfPlots(experiment);
hFigure = figure('Position', [plotOptions.left plotOptions.bottom plotOptions.width plotOptions.height]);

for i=1:experiment.getNumOfNeurons
    subplot(numPlots, 1, i);
    bar_handle = bar(1:experiment.duration, neuronActivity(i,:));
    set(bar_handle, 'FaceColor', plotOptions.neuronColors{i});
    neuronTitle = experiment.neurons{i}.name;
    if (i==1)
        title(experiment.name, 'FontSize', 12 , 'Position', [experiment.duration/5*3 1.3]);
    end
    set(gca, 'XTick', 1:experiment.duration);
    set(gca, 'YTick', [0 1]);
    ylim([0, 1.2]);
    ylabel(neuronTitle, 'Rotation', 0, 'Position', [-0.8 0.5], 'FontWeight', 'bold');
end
end


function plotTransmitters(experiment, concentrations, plotOptions)
numPlots = getNumOfPlots(experiment);
for j=1:experiment.getNumOfTransmitters
    subplot(numPlots, 1, experiment.getNumOfNeurons+j);
    if isprop(experiment, 'injection') && ...
            sum(experiment.injection(j,:))>0
        y = [experiment.injection(j,:)' concentrations(j,:)'-experiment.injection(j,:)']; 
        bar_handle = bar((1:experiment.duration), y, 'stacked');
        %injection color:
        bar_handle(1).FaceColor = plotOptions.transmitterColors{j}/3;
        %neurons' output color
        bar_handle(2).FaceColor = plotOptions.transmitterColors{j};        
    else
        y = concentrations(j,:);
        bar_handle = bar((1:experiment.duration), y);
        set(bar_handle,'FaceColor', plotOptions.transmitterColors{j});
    end
    
    transTitle = experiment.transmitters{j}.name;%strcat('Transmitter ',num2str(j));
    %title(transTitle, 'FontSize', 12);
    set(gca, 'XTick', 1:experiment.duration);
    %set(gca, 'YTick', [0 ]);
    YMAXLIM = max(max(concentrations))*1.1; 
    ylim([0, YMAXLIM]);
    ylabel(transTitle, 'Rotation', 0, 'Position', [-1.1 0.5*YMAXLIM], 'FontWeight', 'bold');
end
end