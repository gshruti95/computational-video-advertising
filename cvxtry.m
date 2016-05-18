clear;
% m = 2;
% M = 1;
% p = 3;
% A = [10,50,90];
% V = [30,50,70];
% Vad = [90,50,10];

m = 4;
M = 2;
p = 4;
A = [10,30,50,70,90];
V = [90,70,50,30,10];
Vad = [10,30,50,89];

assert(length(Vad)==p);
assert(length(A)==m+1);
assert(length(V)==m+1);

% Genetic Algorithm works
a = 0.5;
b = 0.5;
fun = @(x)(-a*AI(x,m,V,A)-b*AS(x,m,p,V,Vad));
nvars = m+p;
A = [];
b = [];
Aeq = [];
Beq = [];
lb = zeros(nvars,1)';
ub = ones(nvars,1)';
%nonlcon = @constraint;
IntCon = 1:nvars;
x = ga(fun,nvars,A,b,Aeq,Beq,lb,ub,@(x)constraint(x,m,p,M),IntCon);
yfinal = x(m+1:m+p);
xfinal = x(1:m);
x,xfinal,yfinal

% x_init = zeros(m,1);
% y_init = zeros(p,1);
% x0 = vertcat(x_init,y_init);
% fmincon does NOT work, binary variable problems
% fun = @(x)(-AI(x,m,V,A)-AS(x,m,p,V,Vad));
% A = [];
% b = [];
% Aeq = [];
% Beq = [];
% lb = [0,0,0,0,0];
% ub = [1,1,1,1,1];
% nonlcon = @constraint;
% 
% x = fmincon(fun,x0,A,b,Aeq,Beq,lb,ub,nonlcon);

% cvx does not directly work
% cvx_begin
%     variable x(m) binary
%     variable y(p) binary
%     maximize(AI(x,m,V,A))%+AS(x,y,m,p,V,Vad))
%     subject to
%         sum(x) == M
%         sum(y) == M
%         %TODO Uniform Distribution of ads
% cvx_end