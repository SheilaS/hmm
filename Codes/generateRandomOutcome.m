function f=generateRandomOutcome(pmf)
    % outcome is either 1 or 2 or ... up to M
    % where M =length(pmf)
    % pmf is a vector of length 2 where pmf(1) is prob(X=1) and pmf(2) =
    % prob(X=2)
    % note that output = 1 if and only if z < pmf(1);
    % for example, suppose pmf = (1/4,3/4).  so pmf(1)=1/4.
    % note that {output = 1} if andonlyif {0 < z < 1/4}.
    % the probability of that event is the probabilty that (0 < z < 1/4).
    % so this means that P(output = 1) = P(0 < z < 1/4) but we know that is
    % 1/4 because Z is uniform (0,1).
    M = length(pmf);
    z = rand % Z is a unif[0,1] random variable.
    
    leftBoundary=0;
    for index=1:M,
       rightBoundary = leftBoundary + pmf(index);
       if ((z >= leftBoundary) && (z < rightBoundary))
           f = index;
       end
       leftBoundary = rightBoundary;    
    end
    %f
end