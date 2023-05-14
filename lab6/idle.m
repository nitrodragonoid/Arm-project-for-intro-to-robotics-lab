b = Arbotix('port', 'COM9', 'nservos', 5);
b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]);
f = input('arm is in idle state. enter 1 if you want to pick an object and 0 key if you want to remain in idle state: ');
    if (f == 1)
        disp('enter pick coordinates: ');
        a1 = input('enter first joint angle = ');
        a2 = input('enter second joint angle = ');
        a3 = input('enter third joint angle = ');
        a4 = input('enter fourth joint angle = ');
        if (((a1 > (-5*pi)/6) && (a2 > (-5*pi)/6) && (a3 > (-5*pi)/6) && (a4 > (-5*pi)/6)) && ((a1 < (5*pi)/6) && (a2 < (5*pi)/6) && (a3 < (5*pi)/6) && (a4 < (5*pi)/6)))
            b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]);
            pause(2)
            b.setpos([a1,a2,a3,a4,0], [65, 65, 65, 65, 65]); 
            pause(2)
            b.setpos([a1,a2,a3,a4,1.2], [65, 65, 65, 65, 65]);
            pause(2)
            b.setpos([0,pi/3,0,pi/3,1.2], [65, 65, 65, 65, 65]);
            pause(2)
            disp('enter place coordinates: ')
            a5 = input('enter fifth joint angle = ');
            a6 = input('enter sixth joint angle = ');
            a7 = input('enter seventh joint angle = ');
            a8 = input('enter eighth joint angle = ');
            if (((a5 > (-5*pi)/6) && (a6 > (-5*pi)/6) && (a7 > (-5*pi)/6) && (a8 > (-5*pi)/6)) && ((a5 < (5*pi)/6) && (a6 < (5*pi)/6) && (a7 < (5*pi)/6) && (a8 < (5*pi)/6)))
                b.setpos([a5,a6,pi/3,a8,1.2], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,a7,a8,1.2], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,a7,a8,0], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,pi/3,a8,0], [65, 65, 65, 65, 65])
                pause(2)
                b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]);
            else
                a5 = input('enter fifth joint angle = ');
                a6 = input('enter sixth joint angle = ');
                a7 = input('enter seventh joint angle = ');
                a8 = input('enter eighth joint angle = ');
                b.setpos([a5,a6,pi/3,a8,1.2], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,a7,a8,1.2], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,a7,a8,0], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,pi/3,a8,0], [65, 65, 65, 65, 65])
                pause(2)
                b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]);
            end
        else
            a1 = input('enter first joint angle = ');
            a2 = input('enter second joint angle = ');
            a3 = input('enter third joint angle = ');
            a4 = input('enter fourth joint angle = ');
            b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]);
            pause(2)
            b.setpos([a1,a2,a3,a4,0], [65, 65, 65, 65, 65]);
            pause(2)
            b.setpos([a1,a2,a3,a4,1.2], [65, 65, 65, 65, 65]);
            pause(2)
            b.setpos([0,pi/3,0,pi/3,1.2], [65, 65, 65, 65, 65]);
            pause(2)
            disp('enter place coordinates: ')
            a5 = input('enter fifth joint angle = ');
            a6 = input('enter sixth joint angle = ');
            a7 = input('enter seventh joint angle = ');
            a8 = input('enter eighth joint angle = ');
            if (((a5 > (-5*pi)/6) && (a6 > (-5*pi)/6) && (a7 > (-5*pi)/6) && (a8 > (-5*pi)/6)) && ((a5 < (5*pi)/6) && (a6 < (5*pi)/6) && (a7 < (5*pi)/6) && (a8 < (5*pi)/6)))
                b.setpos([a5,a6,pi/3,a8,1.2], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,a7,a8,1.2], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,a7,a8,0], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,pi/3,a8,0], [65, 65, 65, 65, 65])
                pause(2)
                b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]);
            else
                a5 = input('enter fifth joint angle = ');
                a6 = input('enter sixth joint angle = ');
                a7 = input('enter seventh joint angle = ');
                a8 = input('enter eighth joint angle = ');
                b.setpos([a5,a6,pi/3,a8,1.2], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,a7,a8,1.2], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,a7,a8,0], [65, 65, 65, 65, 65]);
                pause(2)
                b.setpos([a5,a6,pi/3,a8,0], [65, 65, 65, 65, 65])
                pause(2)
                b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]);
            end
        end
    else
        b.setpos([0,pi/3,0,pi/3,0], [65, 65, 65, 65, 65]);
    end
% b.setpos([0,pi/3,1.27409,0,0], [65, 65, 65, 65, 65]); % pick
% b.setpos([pi/2,pi/3,1.27409,0,1.2], [65, 65, 65, 65, 65]); % place 