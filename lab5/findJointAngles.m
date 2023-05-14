function s = findJointAngles(x,y,z,phi)

a2 = 10;
a3 = 10;
a4 = 10;
d1 = 13;

x1 = sqrt(x^2 + y^2) - a4*sin(phi);
y1 = sqrt(x^2 + y^2) - a4*cos(phi);
z1 = z-d1-a4*sin(phi);

alpha = acos((a2^2 - a3^2 + x1^2 + z1^2)/(2*a2*(sqrt(x1^2 + z1^2))));
beta = acos((a2^2 + a3^2 - y1^2 - z1^2)/(2*a2*a3));
gamma = atan(z1/x1);

% first set:
theta_11 = atan2(y,x);
theta_31 = gamma - alpha;
theta_21 = pi - beta;
theta_41 = phi - theta_21 - theta_31;

% second set:
theta_12 = atan2(y,x);
theta_32 = gamma + alpha;
theta_22 = beta - pi;
theta_42 = phi - theta_22 - theta_32;

% third set:
theta_13 = pi + atan2(y,x);
theta_33 = pi - gamma + alpha;
theta_23 = beta - pi;
theta_43 = phi - theta_23 - theta_33;

% fourth set:
theta_14 = pi + atan2(y,x);
theta_34 = pi - gamma - alpha;
theta_24 = pi - beta;
theta_44 = phi - theta_24 - theta_34;

s = [theta_11, theta_21, theta_31, theta_41;
     theta_12, theta_22, theta_32, theta_42;
     theta_13, theta_23, theta_33, theta_43;
     theta_14, theta_24, theta_34, theta_44];
end