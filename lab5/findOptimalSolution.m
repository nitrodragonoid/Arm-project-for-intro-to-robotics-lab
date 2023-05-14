function optimal_solution = findOptimalSolution(x, y, z, phi)

arb = Arbotix('port', 'COM8', 'nservos', 5);
position = arb.getpos(); % get the current joint angles
position = position(1,1:4); % removing the gripper setting
position(1) = position(1) + pi/2;
position(2) = position(2) + pi/2;
position = position(:,1:4);

s1 = findJointAngles(x, y, z, phi); % get all possible solutions
s = real(s1);

for i=1:4
    position(i) = mod(position(i) + pi, 2*pi) - pi;
    s(1,i) = mod(s(1,i) + pi, 2*pi) - pi;
    s(2,i) = mod(s(2,i) + pi, 2*pi) - pi;
    s(3,i) = mod(s(3,i) + pi, 2*pi) - pi;
    s(4,i) = mod(s(4,i) + pi, 2*pi) - pi;
    % no<3
end

t1 = sum(abs((s(1, :) - position) + pi));
t2 = sum(abs(s(2, :) - position) + pi);
t3 = sum(abs(s(3, :) - position) + pi);
t4 = sum(abs(s(4, :) - position) + pi);



t = min([t1, t2, t3, t4]);
  if t == t1
        optimal_solution = s(1, :);
    elseif t == t2
        optimal_solution = s(2, :);
    elseif t == t3
        optimal_solution = s(3, :);
    elseif t == t4
        optimal_solution = s(4, :);
  end
end