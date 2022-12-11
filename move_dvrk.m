function [commanded_joints_all, measured_all] = move_dvrk(p)
%Function to zero Dvrk then move it through path
%Inputs: p, path of first three joints of dvrk (each joint is a row)
%Outputs: commanded and measured join positions throughout movement
r = dvrk.arm('PSM1');
t1 = p(1,:); %Joint three angles in degrees (converted to radians below)
t2 = p(2,:); %Joint two angles in degrees (converted to radians below)
d3 = p(3,:); % Joint three distances in meters
measured_all = zeros(4,4,size(t1,2));
commanded_joints_all = zeros(6,1,size(t1,2));
% general settings
rate = 200; % aiming for 200 Hz
ros_rate = rosrate(rate);

% move_jp
disp('---- Joint move');
% move to 0 position
joints_home = r.setpoint_js();
%joints_home = [0;0;0.05;0;0;0]
r.move_jp(joints_home).wait();

for j=1:size(k,2)
    
    goal = [deg2rad(t1(j));deg2rad(t2(j));d3(j);0;0;0];
%     goal = [deg2rad(m(j));deg2rad(k(j));0.07;0;0;0];
    r.move_jp(goal).wait();
    commanded_joints_all(:,:,j) = r.measured_js()
    measured_all(:,:,j) = r.measured_cp()
    
end
