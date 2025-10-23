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

[Q1, policy1] = MCBasicIteration(numStates,numActions, R, gamma);

PlotPolicy(R, policy1, 'Optimal Policy by MCBasicIteration');

[Q2, policy2] = MCEpsilonGreedy(numStates,numActions, R, gamma, epsilon);

PlotPolicy(R, policy2, 'Optimal Policy by MCEpsilonGreedy');

[Q3 , w] = FindWeight(Q2, 0.1, 2, 10000);
[Q4 , w2] = FindWeight(Q2, 0.1, 1, 10000);
[Q5 , w3] = FindWeight(Q2, 0.1, 5, 10000);

PlotQMesh(Q2, 'Q mesh for target Q');
PlotQMesh(Q3, 'Q mesh for quadratic weight function');
PlotQMesh(Q4, 'Q mesh for linear weight function');
PlotQMesh(Q5, 'Q mesh for 10th order weight function');



