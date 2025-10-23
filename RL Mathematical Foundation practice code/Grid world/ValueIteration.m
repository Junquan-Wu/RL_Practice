function [V, policy] = ValueIteration(T, reward, gamma, theta)
    numStates = size(T, 1);
    numActions = size(T, 3);

    V = zeros(numStates,1); % Initialize value function
    R = reshape(reward, numStates, 1); % Convert reward to vector

    while true
        V_old = V;
        Q = zeros(numStates, numActions);
        
        % Compute Q-values
        for a = 1:numActions
            Q(:, a) = R + gamma * squeeze(T(:,:,a)) * V;
        end
        
        % Update Value Function
        V = max(Q, [], 2);
        
        % Check for convergence
        if max(abs(V - V_old)) < theta
            break;
        end
    end

    % Compute optimal policy
    [V, policy] = max(Q, [], 2);
end
