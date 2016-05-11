function score = AI(x,m,V,A)
    score = 0;
    for i=1:m
        score = score + x(i)*( (A(i+1)-A(i))*(max(A)-A(i))/max(A) + (V(i+1))/(max(V)) + (V(i+1))/(V(i)) );
    end
end