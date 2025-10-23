function [V, policy] = PolicyIteration(T, R, gamma, theta)
    numStates = size(T, 1);
    numActions = size(T, 3);
    
    % Initialize policy randomly
    policy = randi(numActions, numStates, 1);
    V = zeros(numStates, 1); % Initialize value function

    while true
        % Policy Evaluation
        while true
            V_old = V;
            for s = 1:numStates
                a = policy(s);
                V(s) = R(s) + gamma * T(s,:,a) * V_old;
            end
            if max(abs(V - V_old)) < theta
                break;
            end
        end
        
        % Policy Improvement
        policy_stable = true;
        for s = 1:numStates
            old_action = policy(s);
            Q = zeros(1, numActions);
            for a = 1:numActions
                Q(a) = R(s) + gamma * T(s,:,a) * V;
            end
            [~, best_action] = max(Q);
            policy(s) = best_action;
            
            if old_action ~= best_action
                policy_stable = false;
            end
        end
        
        % If policy is stable, stop
        if policy_stable
            break;
        end
    end
end
