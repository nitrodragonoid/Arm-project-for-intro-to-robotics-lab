b = Arbotix('port', 'COM9', 'nservos', 5);
g = 0;

if (g == 0) % if gripper is open
    b.setpos([0,pi/3,1.27409,pi/3,0], [65, 65, 65, 65, 65]); % go to pick position
else
    b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]); % open gripper
    b.setpos([0,pi/3,1.27409,pi/3,0], [65, 65, 65, 65, 65]); % go to pick position
end

b.setpos([0,pi/3,1.27409,pi/3,1.2], [65, 65, 65, 65, 65]); % close gripper. 1.2 is the value found using dimensions of the cube
b.setpos([pi/2,pi/3,1.27409,0,1.2], [65, 65, 65, 65, 65]); % go to place coordinates
b.setpos([pi/2,pi/3,1.27409,0,0], [65, 65, 65, 65, 65]); % open gripper
b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]); % go back to idle state