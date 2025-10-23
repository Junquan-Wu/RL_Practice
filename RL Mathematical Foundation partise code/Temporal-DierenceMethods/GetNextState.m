function [reward, nextStateIndex] = GetNextState(s, a, R)
    % Given current state `s` and action `a`, return the next state index and reward.
    
    [rows, cols] = size(R);
    [row, col] = ind2sub([rows, cols], s); % Convert linear index to (row, col)

    % Initialize reward
    reward = 0; 
    
    % Define a = 5 and hitting boundary agent stay in the same palce
    nextRow = row;
    nextCol = col;

    switch a
        case 1 % Left
            if col > 1
                nextCol = col - 1;
            else
                reward = -1; % Reward for invalid move (out of bounds)
            end
        case 2 % Right
            if col < cols
                nextCol = col + 1;
            else
                reward = -1; % Reward for invalid move (out of bounds)
            end
        case 3 % Up
            if row > 1
                nextRow = row - 1;
            else
                reward = -1; % Reward for invalid move (out of bounds)
            end
        case 4 % Down
            if row < rows
                nextRow = row + 1;
            else
                reward = -1; % Reward for invalid move (out of bounds)
            end
    end

    % If the action was valid, calculate the next state index
    if reward ~= -1
        nextStateIndex = sub2ind([rows, cols], nextRow, nextCol);
        reward = R(nextStateIndex);
    else
        nextStateIndex = s; % Stay in the same state if action was invalid
    end
end

