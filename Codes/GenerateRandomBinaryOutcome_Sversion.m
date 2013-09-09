%%Nonlinear Filter

%play god and generate a random state that we are starting in, given pi
%(see below)
function f=generateRandomBinaryOutcome(pmf)


%the matrices are given:
%pi= initial probability of being in a given state

%here lets say there are two states: state 1 and state 2
%choose an arbitrary pi
pi= [0.3 0.7];

%play god and generate a random number on the 0,1 line to establish the
%initial state at t=0

z= rand;

pmf=pi;
if (z<pmf(1))
    f=1;
else f=2;
end

end

%play god and generate X values, where X represents the hidden state variable.
%accomplish this goal using a given Q matrix (this matrix provides the
%probability of transitioning between states.

%Here we will select an arbitrary Q matrix.  We will define it as follows:
%Row 1: represents the probability at time step t+1 of transitioning to state 1(row 1,column
%1) or state 2(row 1,column 2) given that we are currently in state 1 at
%time t

%Row 2:represents the probability at time step t+1 of transitioning to state 2(row 2,column
%1) or state 2(row 2,column 2)
%given that we started in state 2 at time t





    