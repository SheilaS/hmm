function output=generateRandomBinaryOutcome(pmf)

pmf= [0.4 0.6]
    % outcome is either 1 or 2
    % pmf is a vector of length 2 where pmf(1) is prob(X=1) and pmf(2) =
    % prob(X=2)
    z = rand; % Z is a unif[0,1] random variable.
    % note that output = 1 if and only if z < pmf(1);
    % for example, suppose pmf = (1/4,3/4).  so pmf(1)=1/4.
    % note that output = 1 if andonlyif 0 < z < 1/4.
    % the probability of that event is the probabilty that (0 < z < 1/4).
    % so this means that P(output = 1) = P(0 < z < 1/4) but we know that is
    % 1/4 because Z is uniform (0,1).
    if (z < pmf(1))
        output = 1;
    else
        output= 2;
        
    end
    z
end