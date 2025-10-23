clc; clear; close all;

% Grid size
rows = 5; cols = 5;
numStates = rows * cols;
numActions = 5; % 1=Left, 2=Right, 3=Up, 4=Down, 5=Stay

gamma = 0.5; % Discount factor
epsilon = 0.01;% Exploration rate

% Create a reward map (0 for normal cells, +1 for goal, -1 for fobbiden)
R = zeros(rows, cols); % Default reward
R(1,4) = 1;  % Goal cell 
R(1,2) = -1; % fobbiden
R(2,2) = -1; % fobbiden

[V1, policy1] = MCBasicIteration(numStates,numActions, R, gamma);

PlotPolicy(R, policy1, 'Optimal Policy by MCBasicIteration');

[V2, policy2] = MCEpsilonGreedy(numStates,numActions, R, gamma, epsilon);

PlotPolicy(R, policy2, 'Optimal Policy by MCEpsilonGreedy');