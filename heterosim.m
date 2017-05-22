%heterochemical generator model

%neuron types
global FREQ_ADAPT;
global BURSTING;
global TONIC;
global ACT_THRES;
global INH_THRES;
INH_THRES = -1;
ACT_THRES = 1;
BURSTING = 1;
FREQ_ADAPT = 2;
TONIC = 3;

%[neurons M W output num_output period start_active] = generateOscillators;
%[neurons M W output num_output period start_active] = generateBurstFreqAdapt;
%[neurons M W output num_output period start_active] = generateOscTon;
%[neurons M W output num_output period start_active] = generateThreePhaseThreeTrans;
%[neurons M W output num_output period start_active] = generateTonTon;

%[neurons M W output num_output period start_active] = generateThreePhaseOsc;
%[neurons M W output num_output period start_active] = generateThreePhaseOscStop;
%[neurons M W output num_output period start_active] = generateThreePhaseOscReverse;

N = length(neurons);

%neuromediators
ACH = 1;%red
GLU = 2;%green
%M = 2;

%Excitatory - ingibitory
EXC = 1;
ING = -1;
NEU = 0;

T = 17;
%intercellular space - ICS
ICS = zeros(M,T);
%neurons activation
active = zeros(N,T);
%starting neuron

for t=1:T
    %update neurons
    if (t==1)
        active(:,1) = start_active;
    else
        for i=1:N
            active(i,t) = activation(neurons(i), W(i,:), active(i,1:t-1), ICS(:,t-1), period(i));
        end
    end
    
    %update ICS
    for i=1:N
        if (active(i,t))
            ICS(output(i),t) = num_output(i);
        end
    end
    
end

% %plot results

NPLOTS = N + M;

ntitles = {'Neuron 1 - oscillator (T=1)', 'Neuron 2 - follower', 'Neuron 3 - oscillator (T=0)'};

colors = {'k','k', 'y', 'b', 'k'};
COLOR_NEURON = [0 0 0];
COLOR_T1 = [0.75 0.75 0.75];
COLOR_T2 = [0.25 0.25 0.25];

neuron_colors = {COLOR_NEURON, COLOR_NEURON, COLOR_NEURON};
trans_colors = {COLOR_T1, COLOR_T2};

for k=1:N
    subplot(NPLOTS, 1, k);
    bar_handle = bar(1:T, active(k,:));
    set(bar_handle,'FaceColor', neuron_colors{k});
    %title(strcat('N',num2str(k)));
    title(ntitles{k}, 'FontSize', 12);
%    set(gca, '')
    set(gca, 'XTick', 1:T);
    set(gca, 'YTick', [0 1]);
     ylim([0, 1.2]);
end

medtitles={'Transmitter 1', 'Transmitter 2', 'M3'};
for k=1:M
    subplot(NPLOTS, 1, N+k);
   bar_handle = bar((1:T), ICS(k,:));
    set(bar_handle,'FaceColor', trans_colors{k});
    title(medtitles{k}, 'FontSize', 12);
    set(gca, 'XTick', 1:T);
    set(gca, 'YTick', [0 1]);
    ylim([0, 1.2]);
end
xlabel('time', 'FontSize', 12);