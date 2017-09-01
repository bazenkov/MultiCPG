function experiment = createFeedingCPG
duration = 40;
name = 'Feeding CPG';
N1 = Neuron.createOscillator('N1', [0 -1 -1], [1 0 0], 1, -1, 1, 1, 3);
N2 = Neuron.createFollower('N2', [1 0 0], [0 2 0], 1, -1);
N3 = Neuron.createTonic('N3', [-1 -1 0], [0 0 0.5], -1, 3);

neurons = {N1, N2, N3};

T1 = Transmitter('ACH');
T2 = Transmitter('GLU');
T3 = Transmitter('XXX');
transmitters = {T1, T2, T3};

experiment = Experiment(name, duration, neurons, transmitters);