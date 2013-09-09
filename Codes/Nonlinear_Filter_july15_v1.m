%% Now become the observer
% So now I can only observe the Y values. You told me the weather and I am
% going to try and predict where you are located.

%first get the weather
%b=weather (y values)
clear, close all
generateDataWithGivenPiQR
b=y
%We are using Bayes rule to calculate the probability of X given Y.

%Need:
%prior
%likelihood
%posterior

% Bayes rule: prior * likelihood / normalizationConstant;

%Initially we have the weather at time 1. Now we need to work backwards and
%predict where you were located at time 1, given the weather.  In other
%words, P(X(1)=1 | Y(1).
%P(X |Y)=(P(X)*P(Y|X))/P(Y).
%At timepoint t=1, the probability of X is based on the pi matrix.  in our
%case P(X(1)=1)=0.3
%P(Y|X) should be determined by our R matrix.
%We make the assumption that Y is only a noisy version of X.
%P(Y)=all the paths we can take to get to Y.  So for calculating P(X=1|Y=1)
%we would calculate P(Y=1) in this way:
%add all paths together.  So path number 1 is: P(X=1)*P(Y=1|X=1).
%Path number 2 is: P(X=2)*P(Y=1|X=2). 
%So each path is a product of P(X)-which in this case is given by the pi matrix,
%multiplied by P(Y=1|X=j)-which are probability values generated using
%the R matrix.

%so in this case for time point 1, the number of states that X can take is 2
R(1,:)=[0.3 0.7]
R(2,:)=[0.4 0.5]
Xstates=2
prior=pi
%b_1=belief on X at time point t=1, given Y=1 at time t=1
b11numerator=(prior(1))*R(1,1)
b11denominator=(prior(1)*R(1,1))+(prior(2)*R(2,1))
b11=b11numerator/b11denominator
%b_1=((prior(1))*R(1,1))/(prior(1)*R(1,1))+(prior(2)*R(2,1))
%b1=(prior(1))*R(1,1)/(prior(1)*R(1,1))+(prior(2)*R(2,1))
%NOTE: figure out why the math is going weird when I try to code the
%equation as in b_1 and b1 (basically the same)
prior(1)
R(1,1)
prior(2)
R(2,1)
(prior(1))*R(1,1)
(prior(1)*R(1,1))+(prior(2)*R(2,1))
%b11=probability that X is in state 1 at t=1, given that Y=1 at time point t=1
%b21=probability that X is in state 2 at t=1, given that Y=1 at timepoint t=1
b21numerator=(prior(2))*R(2,1)
b21denominator=(prior(1)*R(1,1))+(prior(2)*R(2,1))
b21=b21numerator/b21denominator
b11
b11+b21
%plot(b11,b21)-figure out how to do this!!

%above we calculated P(X1=1|Y1=1) and P(X1=2|Y1=1)
%Now we want to do a one-step prediction update.  We want to calculate X at
%time t=2 (X2) given our belief on X at time t=1 (X1) AND our observation
%of Y at time t=2 (Y2)

%priorXpmf= bi
%b11_b21=

for t = 1:length(b)
    Y = b(t);
    
    if t == 1
        normalizationConstant =(pi*R(1,Y))+(pi*R(2,Y));
            % Bayes rule: prior * likelihood / normalizationConstant;
            prior = pi;
            likelihood = R(:,Y);
            Bnumerator=prior*likelihood
            B = Bnumerator/normalizationConstant;
    end
end
B
prior
likelihood
normalizationConstant
prior*likelihood

%for t=1
    %xprevious=pi
    %likelihood=R(:, Y(1))
   % x_1numerator=xprevious*likelihood
  %  x_1denominator=((xprevious(1)*R(1,Y(1))+xprevious(2)*R(2,Y(1))))
 %   x_t1=x_1numerator/x_1denominator
%end

%for t=2:length(y)
 %   xprevious= x(t-1)
  %  currentPMFx=Q(xprevious,:)
%end

