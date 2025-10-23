function q = AverageReturn(s, a, R, policy, gamma)
    % Computes the average return (expected future reward) for a given state-action pair
    %
    % Inputs:
    %   s      - Current state (index)
    %   a      - Action taken from state s
    %   R      - Reward matrix (numStates x 1)
    %   policy - Current policy mapping states to actions
    %   gamma  - Discount factor (0 < gamma <= 1)
    %
    % Output:
    %   q      - Estimated return of taking action 'a' in state 's'
    
    % Store the initial state before transition
    curr_s = s;
    
    % Get the immediate reward and next state after taking action 'a'
    [reward, s] = GetNextState(s, a, R);
    
    % Initialize return value with immediate reward and discounted future reward
    q = R(curr_s) + gamma * reward;
    
    % Simulate following the policy for a fixed number of steps (Monte Carlo estimation)
    for k = 1:10  % Fixed horizon (10 steps)
        [reward, s] = GetNextState(s, policy(s), R); % Follow the policy to get the next state and reward
        q = q + (gamma^k) * reward; % Add discounted future rewards
    end
end
