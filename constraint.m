function [c,ceq] = constraint(x)
% c = (x(1)-1/3)^2 + (x(2)-1/3)^2 - (1/3)^2;
c = [sum(x(1:3)) - 1, -(sum(x(1:3)) - 1), sum(x(4:5)) - 1, -(sum(x(4:5)) - 1)];
ceq = [];