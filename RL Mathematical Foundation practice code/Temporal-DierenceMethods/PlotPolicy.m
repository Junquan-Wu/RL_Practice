function PlotPolicy(R, policy, titleText)
    % Function to visualize the optimal policy on a grid world
    % reward - matrix representing the grid world rewards
    % policy - matrix of actions (1=Left, 2=Right, 3=Up, 4=Down, 5=Stay)
    % titleText - title of the plot
    
    [rows, cols] = size(R);
    
    % Reshape policy into grid format
    policy_grid = reshape(policy, rows, cols);

    % Display policy grid in the console
    disp('Optimal Policy (1=Left, 2=Right, 3=Up, 4=Down, 5=Stay):');
    disp(policy_grid);

    % Create figure
    figure;
    imagesc(R);  % Display the reward grid
    colormap([0 0 1; 1 1 1; 1 0 0]); % Blue: forbbiden, White: Free, Red: Goal
    hold on;

    % Define arrow symbols for actions
    arrows = ['←', '→', '↑', '↓', '⦿']; % ⦿ for Stay

    % Overlay policy arrows
    for r = 1:rows
        for c = 1:cols
        if r == 1 && c == 1
            % Show both '*' and the arrow at the starting position
            text(c, r, ['* ' arrows(policy_grid(r, c))], 'FontSize', 18, 'FontWeight', 'bold', ...
                'HorizontalAlignment', 'center', 'Color', 'k'); 
        else
            % Show only the arrow symbol for other positions
            text(c, r, arrows(policy_grid(r, c)), 'FontSize', 18, 'FontWeight', 'bold', ...
                'HorizontalAlignment', 'center', 'Color', 'k'); 
        end
        end
    end

    % Grid formatting
    grid on;
    xticks(1:cols);
    yticks(1:rows);
    axis equal;
    title(titleText);
    xlabel('Columns');
    ylabel('Rows');
end
