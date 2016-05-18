function [xfinal,yfinal] = optimize_ad_placement(m,p,M,A,V,Vad)
    % i,j : Scene index, Ad Index
    % n,m,p : #scenes, #Probable Insertion Points, # of ads, m = n - 1;
    % M : # of ads to be inserted
    % x(i), y(i) : Binary variables for insertion point/ ads
    % AI(x(i)) : Function to determine ad insertion point
    % AS(x(i),y(i)) : Function to select the appropriate ad
    % A(i), A(i+1), max(A): Arousal score of current, next scene, max val
    % V(i), V(i+i), max(V): Valence score of current, next scene, max val
    assert(length(Vad)==p);
    assert(length(A)==m+1);
    assert(length(V)==m+1);
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
    IntCon = 1:nvars;
    x = ga(fun,nvars,A,b,Aeq,Beq,lb,ub,@(x)constraint(x,m,p,M),IntCon);
    yfinal = x(m+1:m+p);
    xfinal = x(1:m);
%     cvx_begin
%         variable a
%         variable b
%         variable x(m) binary
%         variable y(p) binary
%         maximize(a*AI(x,m,V,A)+b*AS(x,y,m,p,V,Vad))
%         subject to
%             a + b == 1
%             sum(x) == M
%             sum(y) == M
%             %TODO Uniform Distribution of ads
%     cvx_end
end

% function score = AI(x,m,V,A)
%     score = 0;
%     for i=1:m
%         score = score + x(i)*( (A(i+1)-A(i))*(max(A)-A(i))/max(A) ... 
%             + (V(i+1))/(max(V)) + (V(i+1))/(V(i)) );
%     end
% end
% 
% function score = AS(x,y,m,p,V,Vad) % TODO Add relevance score
%     score = 0;
%     for i = 1:m
%         for j = 1:p
%             score = score + x(i)*y(j)*( 1 - abs((V(i) - Vad(i)) / ...
%                 (max(max(V),max(Vad)))) );
%         end
%     end
% end