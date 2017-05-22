function experiment = createTestExperiment
defaultDuration = 5;
defaultName = 'Test Experiment';
NUM_TRANSM = 3;
N1 = Neuron.createOscillator('N1', rand(1,NUM_TRANSM)-0.5, rand(1,NUM_TRANSM), 1, -1, 2, 1, 3);
N2 = Neuron.createOscillator('N2', rand(1,NUM_TRANSM)-0.5, rand(1,NUM_TRANSM), 1, -1, 2, 1, 2);
N3 = Neuron.createTonic('N3', rand(1,NUM_TRANSM)-0.5, rand(1,NUM_TRANSM), -1, 2);
N4 = Neuron.createFollower('N4', rand(1,NUM_TRANSM)-0.5, rand(1,NUM_TRANSM), 1, -1);
correctNeurons = {N1, N2, N3, N4};

T1 = Transmitter('T1');
T2 = Transmitter('T2');
T3 = Transmitter('T3');
correctTransmitters = {T1, T2, T3};
experiment = Experiment(defaultName, defaultDuration, correctNeurons, correctTransmitters);