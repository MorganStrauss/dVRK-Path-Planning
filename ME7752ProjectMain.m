%% Set-up:
clc
clear
close all
%Create Start Position:
p_start = [0.004; 0; -0.0223];

%Define the starting position angles:
[t_start2] = analyticalIK(p_start');

%Create Goal Position:
p_end = [0; 0; -0.040];

%Define goal theta values
goalTheta = analyticalIK(p_end');

%Create Obstacle:

%%Potential Field Calculations:
n = 7;
%Calculate the goal potential field:
[goalP] = potentialField(p_end,n);

%Calculate the obstacle potential field:

%Find the Overall Potential Field:
totalP = goalP;
%% Path Planning:

%Calculate gradient for every potential in field:
gradient = getGradient(totalP,n);

%Remove boundary of potential field and gradient:
slimmedGradient = gradient((n+n^2+2):(n-2)*n^2+(n-2)*n+(n-1),:);
%Plot the gradient:
quiver3(gradient(:,1),gradient(:,2),gradient(:,3),gradient(:,5),gradient(:,6),gradient(:,7))
%Step through gradient:
trajectory = followGradient(p,gradient);

%Move the dVRK through the Trajectory:
%move_dvrk(q);