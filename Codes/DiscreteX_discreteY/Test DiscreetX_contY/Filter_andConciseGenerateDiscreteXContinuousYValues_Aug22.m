% This script is used to "play god" and generate a series of discrete X (hidden
% state) values and continuous Y (observations) values

close; clear all
%The pi matrix tells us the probability of being either in state X=1 or X=2
%at our initial time point.  Here, pi is a PMF
pi= [0.3 0.7];


x(1)= generateRandomBinaryOutcome_S(pi);
%To generate our initial state, we use the generateRandomBinaryOutcome_S
%function which compares a randomly generated value (Z=rand) to the pi
%matrix.  if Z<=pi(1), we start in state X=1. else, we start in state X=2

Q= [0.2 0.8; 0.4 0.6];
%Q tells us the probability of transitioning from X=j or k at time t to X=j or k at
%time t+1. It is the transition matrix

n=15;
%n is the number of time points we will query

%now we generate a series of x values using the Q matrix
for t=2:n;
    xprevious= x(t-1);
    currentPMFx=Q(xprevious,:);
    %The two steps above tell the GenerateRandomOutcome function which row of the Q
    %matrix to consider when evaluating how z is mapped to X (the state).  
       x(t)=generateRandomBinaryOutcome_S(currentPMFx);
    xcurrent=x(t);
     
end

%now we generate a series of continuous Y values using the R matrix. For 
% discrete Y values, The R matrix tells us the probability of Y=k at time t, 
% given X=j at time t.

%Here we are generating continuous Y values.  In other words, when X=1, Y
%is drawn from one Gaussian distribution and when X=2, Y is drawn from
%another Gaussian distribution with a different mean and variance.

% We use the R.mean and R.variance vectors to define the mean and variance
% of the Gaussian distributions we sample from when X=1 or X=2.
global R
R.mean=[0,0.1];
R.variance=[4,4.1];

%The function generateYgivenX takes our current x value, and uses that to
%determine which Gaussian distribution to sample from.  The function then
%defines an a and b value for generating Y=a*Z+b, where Z is randn-a number
%drawn from a standard Gaussian distribution (mean=0, variance=1).
for t=1:n
    xcurrent=x(t);
    Y(t)=generateYgivenX(xcurrent, R);
end
x
Y

yvector  = Y;
dimX = length(pi);
dimY = size(R,1); % or size(R,2); %I think this tells us that Y will be 2 rows, 1 column

T = length(yvector);
% filterCurrentPMF(t,j) = P(X_t = j | Y_1...Y_t)
% filterNextPMF(t,j) = P(X_{t} = j | Y_1...Y_{t-1})


nextbelief=pi;


for t=1:T,

    % now do Bayes Rule
    y = yvector(t);
    % prior = filterNextPMF(t,:);
    prior = nextbelief;
    %Our nextbelief is where we predict X is going to be at the next time
    %step- i.e. P(X) at time t|X at time t-1
    
    %Because Y is a noisy version of X, we want to combine our
    %prior(prediction of X at the next time step) with our observation of Y
    %at the next time step. (this should strengthen our confidence in our
    %belief on X at the next time step. I.e. more info is better)
    
    posterior = BayesRule3_cont(prior, R, y);
    
    %The posterior above tells us our belief on X at time t|Y=b at time t.
    %So now we have our updated belief on X at time t, based on X at the previous time
    %point (t-1) and Y at time t.
    
    %Now we want to repeat this. i.e. we start by predicting where X will be at time t+1, based
    %on where we know x is at time t.
    
   subplot(T/5,5,t), stem(posterior);
%    subplot(ceil(size(B,1)/5),5,i);
%     stem(squeeze(B(i,i,:)));
    titlestring = sprintf('b_{%d|%d}(j)',t,t);
    title(titlestring)
    xlabel('State j that X takes')
%     
%     %    ylabel(ystring);
% 
%     % update the filter PMF
    for j = 1:dimX,
        filterCurrentPMF(t,j) = posterior(j);
    end
%     
%     % at this point we do the one step prediction update
    % currentPMF = filterCurrentPMF(t,:);
    for j = 1:dimX,
        currentPMF(j) =filterCurrentPMF(t,j);
    end 
    nextbelief = OneStepPredictionUpdate(currentPMF,Q);  
    
%     pause;

end

