function errorCode = setPosition(jointAngles) % the function takes vector of joint angle values in radians

% using the given equation to map the angles recieved to motor angles in
% range [-150, 150]
angle_1 = mod(jointAngles(1)+pi,2*pi)-pi;
angle_2 = mod(jointAngles(2)+pi,2*pi)-pi;
angle_3 = mod(jointAngles(3)+pi,2*pi)-pi;
angle_4 = mod(jointAngles(4)+pi,2*pi)-pi;

% getting the mapping function for all 4 angles according to table 4.2
a1 = angle_1 - pi/2;
a2 = angle_2 - pi/2;
a3 = angle_3;
a4 = angle_4;

% setting condition that arm only moves in the given range of [-150,150]
if (((a1 > (-5*pi)/6) && (a2 > (-5*pi)/6) && (a3 > (-5*pi)/6) && (a4 > (-5*pi)/6)) && ((a1 < (5*pi)/6) && (a2 < (5*pi)/6) && (a3 < (5*pi)/6) && (a4 < (5*pi)/6)))
    b = Arbotix('port', 'COM5', 'nservos', 5);
    b.setpos([a1, a2, a3, a4, 0], [55, 55, 55, 55, 55]); % getting the position of arm when angles are given at speed of 55 (in the range [0, 1023]) 
end