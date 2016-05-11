function score = AS(x,y,m,p,V,Vad) % TODO Add relevance score
    score = 0;
    for i = 1:m
        for j = 1:p
            score = score + x(i)*y(j)*( 1 - abs((V(i) - Vad(i)) / (max(max(V),max(Vad)))) );
        end
    end
end