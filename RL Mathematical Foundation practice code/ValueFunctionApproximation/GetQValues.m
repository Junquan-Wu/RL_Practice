function [Q, phi] = GetQValues(s, a, w, order)
    % Computes Q-value using polynomial function approximation
    % Inputs:
    %   s      - Current state
    %   a      - Action taken
    %   w      - Weight vector
    %   order  - Polynomial order for feature vector
    % Output:
    %   Q      - Approximated Q-value for (s, a)
    %   phi    - Feature vector

    % Generate feature vector dynamically
    idx = 1;
    phi = zeros((order + 1) * (order + 2) / 2, 1);

    for i = 0:order
        for j = 0:(order - i)
            phi(idx) = s^i * a^j;
            idx = idx + 1;
        end
    end

    % Compute Q-value using dot product
    Q = w' * phi;
end

