function [x, R] = findPincher(theta_1, theta_2, theta_3, theta_4) % takes joint angles (in radians) as argument and returns the end-effector position and orientation 

% transformation from base frame ( frame 0) to frame 1:
T01 = [cos(theta_1), 0, sin(theta_1), 0;
        sin(theta_1), 0, -cos(theta_1), 0;
        0, 1, 0, 130;
        0, 0, 0, 1];

% transformation from frame 1 to frame 2:
T12 = [cos(theta_2), -sin(theta_2), 0, 100*cos(theta_2);
        sin(theta_2), cos(theta_2), 0, 100*sin(theta_2);
        0, 0, 1, 0;
        0, 0, 0, 1];

% transformation from frame 2 to frame 3:
T23 = [cos(theta_3), -sin(theta_3), 0, 100*cos(theta_3);
        sin(theta_3), cos(theta_3), 0, 100*sin(theta_3);
        0, 0, 1, 0;
        0, 0, 0, 1];

% transformation from frame 3 to frame 4:
T34 = [cos(theta_4), -sin(theta_4), 0, 100*cos(theta_4);
        sin(theta_4), cos(theta_4), 0, 100*sin(theta_4);
        0, 0, 1, 0;
        0, 0, 0,1];

% total transformation from base frame (frame 0) to frame 4:
T04 = T01*T12*T23*T34;

x = T04(1:3, 4); % position vector obtained from T04 through indexing is stored in variable x

R = T04(1:3, 1:3); % rotation matrix obtained from T04 through indexing is stored in variable R
end