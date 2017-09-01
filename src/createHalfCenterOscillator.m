function experiment = createHalfCenterOscillator
duration = 10;
name = 'Half-Center Oscillator';
N1 = Neuron.createTonic('N1', [0 -1], [1.1 0], -1, 2);
N2 = Neuron.createTonic('N2', [-1 0], [0 1], -1, 2);

neurons = {N1, N2};

T1 = Transmitter('A');
T2 = Transmitter('B');
transmitters = {T1, T2};
experiment = Experiment(name, duration, neurons, transmitters);