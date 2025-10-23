clc; clear; close all;

% Grid size
rows = 5; cols = 5;
numStates = rows * cols;
numActions = 5; % 1=Left, 2=Right, 3=Up, 4=Down, 5=Stay

gamma = 0.5; % Discount factor
epsilon = 0.1;% Exploration rate
alpha = 0.1; %learning rate
policy = randi(numActions, numStates, 1);    % Initialize policy randomly
Q = zeros(numStates, numActions); % Initialize action values

% Create a reward map (0 for normal cells, +1 for goal, -1 for fobbiden)
R = zeros(rows, cols); % Default reward
R(1,4) = 1;  % Goal cell 
R(1,2) = -1; % fobbiden
R(2,2) = -1; % fobbiden

PlotPolicy(R, policy, 'Orignal Policy');

[Q1, policy1, k0] = SARSA(Q, policy, R, gamma, epsilon, alpha);
PlotPolicy(R, policy1, 'Optimal Policy by SARSA');

n =100;

Q2 = Q;
policy2 = policy;
k2 = [];
for i = 1:n
    [Q2, policy2, k2(end+1)] = SARSA(Q2, policy2, R, gamma, epsilon, alpha);
end
PlotPolicy(R, policy2, 'Optimal Policy by n-STEPS SARSA');


Q3 = Q;
policy3 = policy;
k3 = [];
for i = 1:n
    [Q3, policy3, k3(end+1)] = OnPolicyQLearning(Q3, policy3, R, gamma, epsilon, alpha);
end
PlotPolicy(R, policy3, 'Optimal Policy by OnPolicyQLearning');

Q4 = Q;
k4 = [];
for i = 1:n
    [Q4, policy4, k4(end+1)] = OnPolicyQLearning(Q4, policy, R, gamma, epsilon, alpha);
end
PlotPolicy(R, policy4, 'Optimal Policy by OffPolicyQLearning');

% Plot n vs k2, k3, k4
figure;
hold on;
plot(1:n, k2, '-o', 'DisplayName', 'SARSA', 'LineWidth', 1.5);
plot(1:n, k3, '-s', 'DisplayName', 'On-Policy Q-Learning', 'LineWidth', 1.5);
plot(1:n, k4, '-d', 'DisplayName', 'Off-Policy Q-Learning', 'LineWidth', 1.5);
hold off;

xlabel('Iteration (n)');
ylabel('Steps (k)');
title('Comparison of Reinforcement Learning Algorithms');
legend;
grid on;