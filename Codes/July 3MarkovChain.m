% Then this means that IF  x at time t (call it the state variable "xprevious") was zero 
%then assign x at time t to be 1 (call it the state variable "xnext") with probability 3/4 and assign it to be 0 with probability 1/4.  
%That is easy to do. Draw a z to be uniform [0,1] using the Matlab command rand.  If z is between 0 and 3/4 then assign xnext to 1; else assign xnext = 0.

%Now suppose xprevious  was 1.  And suppose that Q(1|1) = 1/8 and Q(0|1) = 7/8.  Then u know the analogy.

%So your pseudo code should be of the form


%- assign x(1) to be drawn from PMF "pi".  Do this by saying "z=rand; if z < pi(1) then x(1)=0; else x(1)=1;"

%- assign state variable: xprevious=x(1).
%- assign n= 30 (let us say)


%%simulate a hidden markov model with known transition probabilities

%Step 1: Simulate X

%X= {0,1}

%Given "pi" and "Q" matrix (probability of transitioning from a given state to
%another as you move forward one step in time)
%simulate a Markov chain of length "n" time points

%define the prior "pi" (the probability of being in each of the initial
%states at time zero)

pi(1)=3/4
pi(0)=1/4
Q= [1/8 7/8; 1/4 3/4]

% transitioning from one state to the next
%xprevious is defined as x at time t
%xnext is defined as x at time t+1
%z is defined as the "?" 

%x1 is the state in at time 1 (draw this randomly from pi)

%assign x(1) to be drawn from PMF "pi".  Do this by saying "z=rand; if z < pi(1) then x(1)=0; else x(1)=1;"

%- assign state variable: xprevious=x(1).
%- assign n= 30 (let us say)


%function xnext= PMFxgivenxprevious(z)
x(1)=PMF(pi)
z=rand;
if z<pi(1) %but check the 1/4 to 3/4
    then x(1)=0;
else x(1)=1;
end
xprevious=x(1)
%end

%if (0 <z< 3/4)
 %   xnext=1
%else 
  %  xnext=0
    
   % z=rand; if z < pi(1) 
    %    x(1)=0; 
    %else x(1)=1
