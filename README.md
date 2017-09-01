# MultiCPG - Multi-transmitter central pattern generator simulator
A Matlab implementation of the model described in the paper:

N. Bazenkov, V. Dyakonova, O. Kuznetsov, D. Sakharov, D. Vorontsov, L. Zhilyakova 
Discrete Modeling of Multi-Transmitter Neural Networks with Neuron Competition
[ArXiv](https://arxiv.org/abs/1705.02176)

## Main features
The software allows to create models of neuronal ensembles where neurons share the same extracellular space, simulate the discrete neuronal activity, plot the activity diagrams and print them as 'jpg' or 'eps' files.

## Paper abstract
We propose a novel discrete model of central pattern generators (CPG), neuronal ensembles generating rhythmic activity. The model emphasizes the role of nonsynaptic interactions and the diversity of electrical properties in nervous systems. Neurons in the model release different neurotransmitters into the shared extracellular space (ECS) so each neuron with the appropriate set of receptors can receive signals from other neurons. We consider neurons, differing in their electrical activity, represented as finite-state machines functioning in discrete time steps. Discrete modeling is aimed to provide a computationally tractable and compact explanation of rhythmic pattern generation in nervous systems. The important feature of the model is the introduced mechanism of neuronal competition which is shown to be responsible for the generation of proper rhythms. The model is illustrated with two examples: a half-center oscillator considered to be a basic mechanism of emerging rhythmic activity and the well-studied feeding network of a pond snail. Future research will focus on the neuromodulatory effects ubiquitous in CPG networks and the whole nervous systems.

## Usage
First, you need to create your experiment, specified by Experiment class (Experiment.m source file).
The example CPG can be created by createFeedingCPG.m function

Then you should run simulate.m function.

'''
experiment = createFeedingCPG;
simulate(experiment);
'''

Usage example can be found in run_cpg.m script

## Project structure
Source files are located in 'src' directory. The 'test' directory contains test classes which can be used as usage exmples.

There are three basic classes: 'Experiment', 'Neuron' and 'Transmitter'.
An Experiment object includes a set of neurons and a set of neurotransmitters. The neurons can be of three different types which represents different activity patterns:
oscillator, tonic and follower. A detailed description is provided in the paper.

When you create a new Experiment object, you should provide neurons, transmitters, the duration of the experiment and the array of external injections of neurotransmitters.

Function 'simulate' is the main input point which simulates the neuronal activity, plots the results and optionally print the figures to the specified directory.

Function 'generateRhythms' is used to compute the neuronal activity and concentrations of the neurotransmitters given the input provided by the experiment object

Functions 'plotResults' and 'printResults' are used to plot the neuronal activity graphs and print them to specified folders.

