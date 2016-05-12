clear;
m = 2;
M = 1;
p = 3;
A = [10,50,90];
V = [30,50,70];
Vad = [60,40,50];


% Genetic Algorithm works
a = 0.5;
b = 0.5;
fun = @(x)(-a*AI(x,m,V,A)-b*AS(x,m,p,V,Vad));
nvars = 5;
A = [];
b = [];
Aeq = [];
Beq = [];
lb = [0,0,0,0,0];
ub = [1,1,1,1,1];
nonlcon = @constraint;
IntCon = [1,2,3,4,5];
x = ga(fun,nvars,A,b,Aeq,Beq,lb,ub,nonlcon,IntCon);
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