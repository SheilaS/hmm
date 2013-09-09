function beliefOut= OneStepPredictionUpdate(beliefIn,Q)
% each row of Q adds up to 1.  this means that
% Q(i,j) = P(X_{t+1}=j | X_t = i)
%beliefIn(i)=P(X_t=i)
numStates=length(beliefIn);
%numStates is the number of States X can take. We start with a belief (pmf) on
%X at time t(beliefIn) and we generate a belief (pmf) on X at time t+1|X at
%time t.  
%So the num of States tells us how many states to consider for our
%beliefout pmf
for indexOut=1:numStates,
    sumOfProbs=0;
    for indexIn=1:numStates,
        sumOfProbs = sumOfProbs + beliefIn(indexIn)*Q(indexIn,indexOut);
    end
    beliefOut(indexOut)=sumOfProbs;
end


%How this code works:
%We start by considering where we can end up.  I.e. in our beliefOut-we
%will have a pmf on the states x can take.  
%First assume x can take on 2 states: X=1 and X=2
%So we want to calculate a belief on X at time t+1

%So lets start with state X=1:
%There are two paths that X can take to get to X=1 at time t

%Path 1: X_t-1=1, X_t=1
%Path 2: X_t-1=2, X_t=1
%Both paths are possible routes to X_t=1. So we need to use total
%probability theorem and sum all of the paths to X_t=1 in order to
%calculate the probability that X=1 at time t-1. 
%This will be our belief on X=1:  [belief on x=1 at time t    ....]

%We repeat this same process for every state that X can take. We calculate
%all of the possible paths x can take to get to X=state(n), and add them
%together.  

%then we end up with a belief (pmf) on the probability of all the values
%that X can take on at time t.

%After this, we will again do Bayes Rule to incorporate our observation of
%Y at time t, so that we can improve the accuracy of our prediction on X at
%time t based on X at time t-1
