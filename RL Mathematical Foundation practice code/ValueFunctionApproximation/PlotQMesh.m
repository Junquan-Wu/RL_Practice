function PlotQMesh(Q, titleText)
    % Get size of Q-matrix
    [numStates, numActions] = size(Q);

    % Generate grid for states and actions
    [S, A] = meshgrid(1:numStates, 1:numActions);

    % Transpose Q so dimensions match (MATLAB stores matrices column-wise)
    figure;
    mesh(S, A, Q');

    % Label axes
    xlabel('State (s)');
    ylabel('Action (a)');
    zlabel('Q-value');
    title(titleText);
    
    % Improve visualization
    colormap jet;
    colorbar;
    view(120, 30); % Adjust view angle
end
