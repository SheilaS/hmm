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
R.mean=[0,10];
R.variance=[2,4];

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
