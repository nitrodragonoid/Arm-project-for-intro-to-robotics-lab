% task 4.3:

syms('theta_1')
syms('theta_2')
syms('theta_3')
syms('theta_4')

T01 = [cos(theta_1), 0, sin(theta_1), 0;
        sin(theta_1), 0, -cos(theta_1), 0;
        0, 1, 0, 130;
        0, 0, 0, 1];

T12 = [cos(theta_2), -sin(theta_2), 0, 110*cos(theta_2);
        sin(theta_2), cos(theta_2), 0, 110*sin(theta_2);
        0, 0, 1, 0;
        0, 0, 0, 1];

T23 = [cos(theta_3), -sin(theta_3), 0, 110*cos(theta_3);
        sin(theta_3), cos(theta_3), 0, 110*sin(theta_3);
        0, 0, 1, 0;
        0, 0, 0, 1];

T34 = [cos(theta_4), -sin(theta_4), 0, 110*cos(theta_4);
        sin(theta_4), cos(theta_4), 0, 110*sin(theta_4);
        0, 0, 1, 0;
        0, 0, 0,1];

T04 = T01*T12*T23*T34
