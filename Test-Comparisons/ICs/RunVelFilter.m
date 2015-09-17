clear t X t2 X2
clear all;
load('crash_11.mat');

vicon_time = v_vicon__pose___time;
vicon_pos_x = v_vicon__pose_pose_position_x;
vicon_pos_y = v_vicon__pose_pose_position_y;
vicon_pos_z = v_vicon__pose_pose_position_z;

pos = vicon_pos_z;

start_time = 7.7; %5.1; %3.3; %0;
start_idx = vlookup(vicon_time,start_time);
start_vel = (pos(start_idx+10) - pos(start_idx))/(vicon_time(start_idx+10) - vicon_time(start_idx));
start_pos = pos(start_idx);

a = 5;
b = 50;
x0 = [start_pos/(a*b) start_vel/(a*b)];

[t,X] = ode45(@(t, X) VelFilter(t,X,a,b,vicon_time,pos),[start_time vicon_time(end)],x0);

v_filter = a*b*X(:,2);

figure()
plot(vicon_time,pos,'r.',t,v_filter,'b-');
hold on;

% a = 5;
% b = 50;
% [t2,X2] = ode45(@(t2, X2) VelFilter(t2,X2,a,b,vicon_time,pos),[start_time vicon_time(end)],x0);
% 
% v_filter2 = a*b*X2(:,2);
% plot(t2,v_filter2,'m-');

% title('Crash 11');
xlabel('Time (s)');
% legend('Vicon X Position (m)','X Velocity, a = 10, b = 50','X Velocity, a = 5, b = 50','Location','southeast');
% legend('Vicon Position (m)','Velocity');