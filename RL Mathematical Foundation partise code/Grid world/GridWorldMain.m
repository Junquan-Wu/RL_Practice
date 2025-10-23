clc; clear; close all;

% Grid size
rows = 5; cols = 5;
numStates = rows * cols;
numActions = 5; % 1=Left, 2=Right, 3=Up, 4=Down, 5=Stay

gamma = 0.5; % Discount factor
theta = 1e-4; % Convergence threshold

% Create a reward map (0 for normal cells, +1 for goal, -1 for fobbiden)
reward = zeros(rows, cols); % Default reward
reward(1,4) = 1;  % Goal cell 
reward(1,2) = -1; % fobbiden
reward(2,2) = -1; % fobbiden

% Define the state transition function (Deterministic)
T = zeros(numStates, numStates, numActions);
R = reshape(reward, numStates, 1); % Convert reward matrix to vector

for row = 1:rows
    for col = 1:cols
        state = sub2ind([rows, cols], row, col);
        
        % Define next states deterministically
        nextStates = [ row, col;            % Stay (1)
                      row, max(col-1,1);     % Left (2)
                      row, min(col+1,cols);  % Right (3)
                      max(row-1,1), col;     % Up (4)
                      min(row+1,rows), col];  % Down (5)

        % Convert to linear indices
        nextStatesIdx = sub2ind([rows, cols], nextStates(:,1), nextStates(:,2));

        % Assign 100% probability to the chosen move
        for a = 1:numActions
            if (a == 2 && col == 1) || (a == 3 && col == cols) || ...
               (a == 4 && row == 1) || (a == 5 && row == rows)  % If action exceeds boundary
                T(state, state, a) = 1; % Stay in place
            else
                T(state, nextStatesIdx(a), a) = 1;
            end
        end
    end
end

% Run Value Iteration function

[V1, policy1] = ValueIteration(T, R, gamma, theta);

PlotPolicy(reward, policy1, 'Optimal Policy by ValueIteration');

[V2, policy2] = PolicyIteration(T, R, gamma, theta);

PlotPolicy(reward, policy2, 'Optimal Policy by PolicyIteration');
