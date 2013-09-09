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

x(1)= generateRandomBinaryOutcome_S(pi)


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
% and generate Y values.
% We assume that Y is a noisy version of X, and we can use the R matrix to
% predict Y at time t based on the value of X at time t.

% we are given a predefined R matrix.  Lets say that Y can take on two
% values.  For example, lets pretend that state 1 and state 2 represent
% either being in Colorado (state 1) or in San Diego (state 2).  And the Y values represent the
% weather.  The weather can either be cool and cloudy (which we will assign a value
% of Y=1), or hot and sunny (which we will assign a value of Y=2).
% In the R matrix we use here, we will assign the rows to represent X state
% values (i.e. either being in Colorado(row 1) or San Diego (row 2)) and columns to
% represent Y values (the current weather). 
%Column 1 represents Y=1 (cool and cloudy), Column 2 represents Y=2 (hot and sunny)

R=[0.3 0.7; 0.4 0.5];

%now we want to play god and generate Y values at each time point.

for t=1:n;
    xcurrent=x(t);
    currentPMFy=R(xcurrent,:);
    y(t)=generateRandomBinaryOutcome_S(currentPMFy);
end
x
y

%great! now we have played god and generated a sequence of X and Y values
%at n time points! 