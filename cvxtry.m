clear;
m = 2;
M = 1;
p = 3;
A = [50,50,50];
V = [50,50,50];
Vad = [50,50,50];

cvx_begin
    variable x(m) binary
    variable y(p) binary
    maximize(AI(x,m,V,A))%+AS(x,y,m,p,V,Vad))
    subject to
        sum(x) == M
        sum(y) == M
        %TODO Uniform Distribution of ads
cvx_end