function [c,ceq] = constraint(x,m,p,M)
c(1) = sum(x(1:p)) - M;
c(2) = -(sum(x(1:p)) - M);
c(3) = sum(x(p+1:p+m)) - M;
c(4) = -(sum(x(p+1:p+m)) - M);
% c = [sum(x(1:p)) - M, -(sum(x(1:p)) - M), sum(x(p+1:p+m)) - M, -(sum(x(p+1:p+m)) - M)];
% c = [sum(x(1:3)) - 1, -(sum(x(1:3)) - 1), sum(x(4:5)) - 1, -(sum(x(4:5)) - 1)];
ceq = [];