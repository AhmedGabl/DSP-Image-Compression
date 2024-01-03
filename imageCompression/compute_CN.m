function CN = compute_CN(N)
    if N>1
        CN = zeros(N,N);
        CN(1,:) = sqrt(1/N);
        for i=2:N
            for j=1:N
                CN(i,j) = sqrt(2/N) * cos(pi*(i-1)*(j-1+0.5)/N);
            end
        end
    elseif N == 1
        CN = (1);
    else
        error('unvaild size, size must be 1 or more');
    end
end