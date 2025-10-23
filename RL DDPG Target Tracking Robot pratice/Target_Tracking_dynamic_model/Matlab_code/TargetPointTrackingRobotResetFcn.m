function in = TargetPointTrackingRobotResetFcn(in)

% Randomize the position of the sliding robot around a circle of radius R
% and the initial orientation of the robot.

R = 10;
t0 = 2*pi*rand();
t1 = 2*pi*rand();
x0 = cos(t1)*R;
y0 = sin(t1)*R;

in = setVariable(in,'theta0',t0);
in = setVariable(in,'x0',x0);
in = setVariable(in,'y0',y0);
end
