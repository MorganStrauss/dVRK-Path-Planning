function [goalP] = potentialField(goalTheta,n)
%%Potential field calculation
% Tabulate potential field in a gridded joint space
theta_1_test = linspace(-50,50,n)*pi/180;
theta_2_test = linspace(-50,50,n)*pi/180;
theta_3_test = linspace(0.028,0.15,n);
%Assign Obstacle Potential Scale:
goalP = [];
% x = [];
% y=[];
% z=[];
% P =[];
% check for collisions along the length of the manipulator
for i = 1:length(theta_1_test)
    for j = 1:length(theta_2_test)
        for h = 1:length(theta_3_test)
        % goal field is the minimum squared distance to the nearest inverse
        % kinematics solution
        theta = [theta_1_test(i); theta_2_test(j); theta_3_test(h)];
        P = norm(theta-goalTheta')^2;
        %Put all output values together:
        rowP = [theta_1_test(i) theta_2_test(j) theta_3_test(h) P i j h];
        goalP = [goalP; rowP];
        %x = [x theta_1_test(i)];
        %y = [y theta_2_test(j)];
        %z = [z theta_3_test(h)];
        %P = [P goal_field(i,j,h)];
        end
    end
end
figure()
scatter3(goalP(:,1),goalP(:,2),goalP(:,3),[],goalP(:,4)./max(goalP(:,4)),'o','MarkerFaceAlpha',0.2);
xlabel('\Theta_1')
ylabel('\Theta_2')
zlabel('\Theta_3')
title('Goal Potential Field')
colorbar
end