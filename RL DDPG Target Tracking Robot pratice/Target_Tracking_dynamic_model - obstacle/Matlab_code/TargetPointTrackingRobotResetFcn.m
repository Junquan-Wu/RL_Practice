function in = TargetPointTrackingRobotResetFcn(in)

% Randomize the position of the sliding robot around a circle of radius R
% and ensure it does NOT spawn inside/too close to the obstacle.

R = 10;
obstacle_center = [-4, 0];
obstacle_radius = 1.5;
safe_margin = 1;
min_safe_distance = obstacle_radius + safe_margin;

isSafe = false;

while ~isSafe
    % Generate random position on circle of radius R
    t1 = 2*pi*rand();
    x0 = cos(t1)*R;
    y0 = sin(t1)*R;

    % Check distance from obstacle center
    dist_to_obstacle = sqrt((x0 - obstacle_center(1))^2 + (y0 - obstacle_center(2))^2);

    % If far enough from obstacle, accept the position
    if dist_to_obstacle > min_safe_distance
        isSafe = true;
    end
end

% Randomize initial orientation
t0 = 2*pi*rand();

% Set variables in Simulink model
in = setVariable(in,'theta0',t0);
in = setVariable(in,'x0',x0);
in = setVariable(in,'y0',y0);

end