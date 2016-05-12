function score = AS(x,m,p,V,Vad) % TODO Add relevance score
    score = 0;
    for i = 1:m
        for j = m+1:m+p
            score = score + x(i)*x(j)*( 1 - abs((V(i) - Vad(i)) / (max(max(V),max(Vad)))) );
        end
    end
end