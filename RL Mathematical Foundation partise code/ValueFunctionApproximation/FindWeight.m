function [Q, w] = FindWeight(target_Q, alpha, order, numItr)
    % Function to learn weights using gradient descent
    % Input:
    %   target_Q - Target Q-values (matrix)
    %   alpha    - Learning rate
    %   order    - Polynomial order for feature vector
    %   numIter  - Maximum iterations
    %   k - number of iteration
    % Output:
    %   w - Optimized weight vector

    % Determine feature vector size
    numFeatures = (order + 1) * (order + 2) / 2;  
    w = zeros(numFeatures, 1);  % Initialize weights

    [states, actions] = size(target_Q);
    Q = zeros(states, actions);

    for k = 1:numItr  
        total_error = 0;  

        for s = 1:states
            for a = 1:actions
                s_norm = (s - 1) / (states - 1);
                a_norm = (a - 1) / (actions - 1);
                [Q(s,a), phi] = GetQValues(s_norm, a_norm, w, order);  
                
                % Compute the error
                error = target_Q(s, a) - Q(s,a);
                
                % Update weights using gradient descent
                w = w + alpha * error * phi;

                % Accumulate error for monitoring
                total_error = total_error + abs(error);
            end
        end

        average_error = total_error/(states*actions);
        

        % Early stopping if error is small
        if average_error < 0.5
            disp('Converged!');
            break;
        end
    end
end
