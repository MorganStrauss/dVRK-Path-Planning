%% Set-up:

%Create Start Position:
p_start = [0.004; 0; -0.0223];

%Define the starting position angles:
[t_start2] = analyticalIK(p_start');

%Create Goal Position:
p_end = [0; 0; -0.040];

%Define goal theta values
[thetaSet] = analyticalIK(p_end');

%Create Obstacle:

%%Potential Field Calculations:

%Calculate the goal potential field:
[goalP] = potentialField(p_end);

%Calculate the obstacle potential field:

%Find the Overall Potential Field:

% %% Path Planning:
% i = 1;
% minimum = 0;
% q(:,i) = [t_start2(1),t_start2(2),t_start2(3)];
% while ~minimum
%     %Find next Step Through the Potential Field:
%     q(:,i+1) = q(:,i)+gradientStep(q(:,i),totalP,1); %gradient does q(:,i) + a step down the gradient
%     %disp(['New Position: ' num2str(q(1,i+1)) ', ' num2str(q(2,i+1))])
%     i=i+1; 
%     %Check if the position is a minima:
%     if ~any(gradient(q(:,i),total_pot,theta_1_test,0))
%         minimum =1;
%     end    
% end

%Move the dVRK through the Trajectory:
%move_dvrk(q);