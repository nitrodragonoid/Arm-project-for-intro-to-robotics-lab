function p = pick()
if (((a1 > (-5*pi)/6) && (a2 > (-5*pi)/6) && (a3 > (-5*pi)/6) && (a4 > (-5*pi)/6)) && ((a1 < (5*pi)/6) && (a2 < (5*pi)/6) && (a3 < (5*pi)/6) && (a4 < (5*pi)/6)))
            b.setpos([a1,a2,a3,a4,0], [65, 65, 65, 65, 65]); % [0,pi/3,1.27409,0,0] -> pick/gripper open
            pause(2)
            b.setpos([a1,a2,a3,a4,1.2], [65, 65, 65, 65, 65]); % [0,pi/3,1.27409,0,1.2]  -> pick/gripper closed
end