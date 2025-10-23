function [Q, policy, k] = SARSA(Q, policy, R, gamma, epsilon, alpha)
    % SARSA Policy Iteration (Basic)
    % Inputs:
    %   numStates  - Number of states in the environment
    %   numActions - Number of possible actions
    %   R          - Reward function (numStates x 1)
    %   gamma      - Discount factor (0 < gamma <= 1)
    % Outputs:
    %   Q          - Estimated action values
    %   policy     - Optimal policy
    %  k           - numbers of step to reach the goal
    
    % Initialize policy randomly

    is_goal = false;  % Track if goal is reached
    is_goal_second = false;  % Track if goal is reached second time
    numActions = size(Q, 2);


    s = 1;% strat at left-top cell

    for k = 1:10000  % Maximum iterations
        
        % Policy Evaluation (Estimate Q-values)
        for a = 1:numActions
            [reward, next_s] = GetNextState(s, a, R);
            next_a = policy(next_s);
            Q(s, a) = Q(s, a) + alpha * (reward + gamma * Q(next_s, next_a) - Q(s, a));
        end
     
        % Policy Improvement

        % Find the action(s) with the highest Q-value
        [~, best_action] = max(Q(s, :)); 

        % Compute action probabilities using ε-soft policy
        action_probs = ones(1, numActions) * (epsilon / numActions); % Initialize with uniform probability
        action_probs(best_action) = 1 - epsilon * ((numActions - 1) / numActions); % Assign higher probability to the best action

        % Select action based on probability distribution
        new_action = randsample(1:numActions, 1, true, action_probs);
            
        policy(s) = new_action;  % Update policy

        [~, s] = GetNextState(s, new_action, R);% move to next state

        if R(s) == 1 % Mark  goal is reached
            if is_goal 
                is_goal_second = true; 
            end
            is_goal = true;
        else
            is_goal = false;
        end
        
        
        % Stop if goal is 
        if is_goal_second
            break;
        end
    end

end
