%%Nonlinear Filter

%%Step 1: Playing God and Generating Data
%play god and generate a random state that we are starting in, given pi
%(see below)

%the matrices are given:
%pi= initial probability of being in a given state

%here lets say there are two states: state 1 and state 2
%choose an arbitrary pi
close; clear all
pi= [0.3 0.7];

x(1)= generateRandomBinaryOutcome_S(pi);


%play god and generate X values, where X represents the hidden state variable at each time point.
%accomplish this goal using a given Q matrix (this matrix provides the
%probability of transitioning between states.

%Here we will select an arbitrary Q matrix.  We will define it as follows:
%the labels on the rows represent the state we are in at time t (either
%state 1(row 1), or state 2(row 2)
%the labels on the columns represent the state we transition to at time
%t+1.  column 1 represents state 1 and column 2 represents state 2.
% The values in each box of the matrix represent the probability of
% transitioning between states as we move from time t to time t+1
%Row 1: represents the probability at time step t+1 of transitioning to state 1(row 1,column
%1) or state 2(row 1,column 2) given that we are currently in state 1 at
%time t.  

%Row 2:represents the probability at time step t+1 of transitioning to state 1(row 2,column
%1) or state 2(row 2,column 2)
%given that we started in state 2 at time t

Q= [0.2 0.8; 0.4 0.6];
%Note: based on the Q defined here, we would expect that running the for
%loop below will likely generate a series of state variables with a large
%number of 2's

%for my binary outcome code- I think I always have to list my smaller
%probability to the left, or it won't work- RETURN TO THIS ISSUE_i.e. if
%z<pmf 1, else issue!!!!! 7/11/13: probably need to add in boundary points
%like when there are more than two states-this should solve the problem

%generate n time points
n=15;

for t=2:n;
    xprevious= x(t-1);
    currentPMFx=Q(xprevious,:);
    %The two steps above tell the GenerateRandomOutcome function which row of the Q
    %matrix to consider when evaluating how z is mapped to X (the state).  
    %So the function:GenerateRandomBinaryOutcome_SCode_July18 is like the S(z) function, 
    %which is taking z values and mapping them to X values based on the PMF
    %of the appropriate row of the Q matrix.
    %in this way we generate a x(t+1) value
    x(t)=generateRandomBinaryOutcome_S(currentPMFx);
    xcurrent=x(t);
    %we can now use our xcurrent to generate a subsequent x value (x_next).
    %i.e. we started by taking x(1) which was randomly generated using the
    %pi matrix.
    %then we used x(1) to tell the GenerateRandomBinaryOutcome_Sversion
    %function which row of the Q matrix to consider when randomly
    %generating a value of X at time point 2.  
    %The X value generated at time point 2 then becomes our new xprevious,
    %which we will use to tell the GenerateRandomBinaryOutcome function
    %which row of the Q matrix to consider when randomly generating a value
    %of X at time point 3.
    %This sequence of events will repeate for the length of our time series
    %that we have defined (n).  
    
end
    
% now that we have a series of X values, we want to play god one more time
% and generate continuous Y values-in other words generate a distribution of values that Y can take on.
% We assume that Y is a noisy version of X, and we can use the R matrix to
% predict Y at time t based on the value of X at time t.  

%This R matrix for continuous values will have three parameters: the x
%value, the mu for that observed x and the variance for that observed x.

% so we want to end up with an R that looks like: [1 0 1; 2 10 3]


% R=[0.3 0.7; 0.4 0.5];

%now we want to play god and generate Y values at each time point.

% for t=1:n;
%     xcurrent=x(t);
%     if xcurrent<=1
%         mu=0;
%         sigma= sqrt(1);
%         y(t)=normpdf(x(t), mu, sigma);
%     else if xcurrent>=1
%             mu=10;
%             sigma=sqrt(3);
%             y(t) = normpdf(x(t), mu, sigma);
%         end
%     end  
% %     plot(x,y)
% end
% x
% y

% for t=1:n;
%     xcurrent=x(t);
%     currentPMFy=R(xcurrent,:);
%     y(t)=generateRandomBinaryOutcome_S(currentPMFy);
% end
% x
% y
global R
R.mean=[0,10];
R.variance=[2,4];

% x=2

for t=1:n
    xcurrent=x(t);
    Y(t)=generateYgivenX(xcurrent, R);
end
    
    
    
%     Z=randn
% %         a=2;
% %     b=4;
%     xcurrent=x(t);
%     if xcurrent<=1;
%         a=2;
%         b=4;
%         Y(t)=a*Z+b;
% %         Y(t)=Z;
%     else
%             xcurrent=2;
%             a=2;
%             b=20;
%             Y(t)=a*Z+b;
%         end
%     end
    x
%         Z
       Y
%        plot(Y)
       
      

% a=2
% b=4
% 
% Z=randn %this will generate random values pulled from a gaussian of mean 0, 
% % variance 1: i.e. the standard normal distribution
% % Y=a*Z+b % Y is a Gaussian with a new mean (a*(mu)+b) and variance (a^2*(var z)^2
% %since our original mu is equal to 0, our new mean equals b
% %since our original (Z) variance equals 1, our new variance=a^2
% 
% %We want to identify Y values according to the state of X.  If X=1, Y
% %values are drawn from gaussian(mu=0, var=1)
% 
% %If X=2, Y values are drawn from gaussian (mu=b, var=a^2)
% X=rand
% 
% if X<0.5
%     Y=Z
% else if X>=0.5
%         Y=a*Z+b
%     end
% end

    
%great! now we have played god and generated a sequence of X and Y values
%at n time points! 