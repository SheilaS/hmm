% pi represent the PMF on the initial state, X(1)
pi(1) = 0.1;
pi(2) = 0.9;

% assume the states of X are 1 or 2


%x1 is drawn from the PMF of pi (initial state probabilities)
x(1) = generateRandomBinaryOutcome(pi);
% pi(1)=3/4
% z=rand
% if z< pi(1)
%     x(1)=0
% else x(1)=1
% end

xprevious=x(1);

% here is an example 2 by 2 matrix just so you understand how to operate on
% them
% 
% Q = [0.1 0.2; 0.3 0.4]
% 
% Q =
%     0.1000    0.2000
%     0.3000    0.4000
% 
% Q(1,1)
% ans =
%     0.1000
% 
% Q(2,1)
% ans =
%     0.3000
% Q(i,j) represents the probability that X at time t+1 equals i GIVEN that X at time t is j
% note that Q(1,j) + Q(2,j) = 1 must hold for any j
% or in other words, Q(1,1) + Q(2,1) = 1.  AND Q(1,2) + Q(2,2) = 1.

Q = [0.25 0.9;
     0.75 0.1];

Q = [0.25 0.1;
     0.75 0.9];

 R = [0.2 0.4;
      0.1 0.3;
      0.7 0.3]
 xcurrent = x(1);
 currentPMFy = R(:,xcurrent);
 y(1) = generateRandomOutcome(currentPMFy);
 T = 10;
 for t=2:T,
    xprevious = x(t-1);
    currentPMFx = Q(:,xprevious);
    x(t) = generateRandomBinaryOutcome(currentPMFx);
    xcurrent = x(t);
    currentPMFy = R(:,xcurrent);
    y(t) = generateRandomOutcome(currentPMFy);
 end
 
 x
 y
% 
% z_1=rand
% %if z_1< 3/4
% %    xnext=0
% %else xnext=1
% %end
%     
% %Q(1|0)=3/4
% 
% if xprevious==1 && z_1<3/4
%     xnext=0
% else xnext=1
% end
% 
% if xprevious==0 && z_1>1/8
%     xnext=1
% else xnext=0
% end
%     
% how do I link xprevious to xnext?