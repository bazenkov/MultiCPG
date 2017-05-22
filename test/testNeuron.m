addpath ..
n1 = Neuron.createOscillator('N1', [-1 1], [0 1], 1, -1, 2, 1, 3);
n2 = Neuron.createTonic('N2', [-1 1], [0 1], -1, 2);
n3 = Neuron.createFollower('N3', [-1 1], [0 1], 1, -1);

ECS = [1 0 0 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0 0 0];
for t=1:10
    activity(t) = n2.nextState(ECS(:,t));
    output(:,t) = n2.getOutput'*n2.isActive;
end
activity
output