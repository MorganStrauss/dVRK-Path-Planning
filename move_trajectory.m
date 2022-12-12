function [commanded_joints_all, measured_all,goal_all] = move_trajectory()
%Function to zero Dvrk then move it through path
%Inputs: p, path of first three joints of dvrk (each joint is a row)
%Outputs: commanded and measured join positions throughout movement
load Trajectory.mat trajectory
r = dvrk.arm('PSM1');
t1 = trajectory(:,1); %Joint three angles in degrees (converted to radians below)
t2 = trajectory(:,2); %Joint two angles in degrees (converted to radians below)
d3 = trajectory(:,3); % Joint three distances in meters
measured_all = zeros(4,4,size(t1,2));
commanded_joints_all = zeros(6,1,size(t1,2));
% general settings
rate = 200; % aiming for 200 Hz
ros_rate = rosrate(rate);

for j=1:length(t1)
    if abs(t1(j)) < deg2rad(51) && abs(t2(j)) < deg2rad(51) && abs(d3(j)) < 0.15
        goal = [t1(j);t2(j);d3(j);0;0;0];
    end
    goal_all(:,j) = goal;
%     goal = [deg2rad(m(j));deg2rad(k(j));0.07;0;0;0];
    r.move_jp(goal).wait();
    commanded_joints_all(:,:,j) = r.measured_js()
    measured_all(:,:,j) = r.measured_cp()
end
for j=length(t1):-1:1
    if abs(t1(j)) < deg2rad(51) && abs(t2(j)) < deg2rad(51) && abs(d3(j)) < 0.15
        goal = [t1(j);t2(j);d3(j);0;0;0];
    end
    goal_all(:,j) = goal;
%     goal = [deg2rad(m(j));deg2rad(k(j));0.07;0;0;0];
    r.move_jp(goal).wait();
    commanded_joints_all(:,:,j) = r.measured_js()
    measured_all(:,:,j) = r.measured_cp()
end

end