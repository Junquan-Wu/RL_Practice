function [V, policy] = MCBasicIteration(numStates, numActions, R, gamma)
    % Monte Carlo Policy Iteration (Basic)
    % Inputs:
    %   numStates  - Number of states in the environment
    %   numActions - Number of possible actions
    %   R          - Reward function (numStates x 1)
    %   gamma      - Discount factor (0 < gamma <= 1)
    % Outputs:
    %   V          - Estimated state values
    %   policy     - Optimal policy
    
    % Initialize policy randomly
    policy = randi(numActions, numStates, 1);
    V = zeros(numStates, 1); % Initialize value function
    %R = reshape(R, numStates, 1); % Convert reward matrix to vector

    for k = 1:1000  % Maximum iterations
        policy_stable = true;  % Track if policy changes
        
        % Policy Evaluation (Estimate Q-values)
        Q = zeros(numStates, numActions);
        for s = 1:numStates
            for a = 1:numActions
                Q(s, a) = AverageReturn(s, a, R, policy, gamma);
            end
        end
        
        % Policy Improvement
        for s = 1:numStates
            old_action = policy(s);
            [~, new_action] = max(Q(s, :)); % Get the best action
            
            policy(s) = new_action;  % Update policy
            if old_action ~= new_action
                policy_stable = false; % Mark policy as changed
            end
        end
        
        % Convergence Check: Stop if policy did not change
        if policy_stable
            fprintf('It takes %d iterations to be stable\n', k);
            break;
        end
    end
    
    % Compute final value function using the optimal policy
    for s = 1:numStates
        V(s) = AverageReturn(s, policy(s), R, policy, gamma);
    end
end
