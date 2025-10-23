function [Q, policy] = MCEpsilonGreedy(numStates, numActions, R, gamma, epsilon)
    % Monte Carlo Policy Iteration (Basic)
    % Inputs:
    %   numStates  - Number of states in the environment
    %   numActions - Number of possible actions
    %   R          - Reward function (numStates x 1)
    %   gamma      - Discount factor (0 < gamma <= 1)
    % Outputs:
    %   Q          - Estimated actions values
    %   policy     - Optimal policy
    
    % Initialize policy randomly
    policy = randi(numActions, numStates, 1);
    V = zeros(numStates, 1); % Initialize value function

    for k = 1:10000  % Maximum iterations
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
            % Find the action(s) with the highest Q-value
            [~, best_action] = max(Q(s, :)); 

            % Compute action probabilities using ε-soft policy
            action_probs = ones(1, numActions) * (epsilon / numActions); % Initialize with uniform probability
            action_probs(best_action) = 1 - epsilon * (numActions - 1 / numActions); % Assign higher probability to the best action

            % Select action based on probability distribution
            new_action = randsample(1:numActions, 1, true, action_probs);
            
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
