function posterior=BayesRule3_cont(prior, R, y)
% prior= [0.3 0.7];
d=length(prior);
% coefficient=1/sqrt(2*3.14*R.variance(index)
% likelihood = [0.1 0.9; 0.95 0.05];
% likelihood_cont=
% fy(y)=1/sqrt2*3.14*R.variance(index)*exp(-1/2*(y-R.mean(index)/R.variance(index)
% y=2;
for index=1:d
    expectation = R.mean(index);
    variance = R.variance(index);
    C = 1/ sqrt(2*3.14*variance);
    
    %coefficient=1/sqrt(2*3.14*R.variance(index));
    s = y-expectation;
    D = 2*variance;
    likelihood = C*exp(-s^2/D);
    numerator(index) = prior(index)*likelihood;
%     numerator(index)=prior(index)*likelihood_cont(index,y);
end
denominator=sum(numerator);
posterior=numerator/denominator;
sumOfPosterior=sum(posterior)
end


%[prior(index)=P(X=a1)]*[likelihood=P(Y=b|X=a1)]=[value1     ]
%[prior(index)=P(X=a1)]*[likelihood=P(Y=b|X=a1)]=[     value2]

%denominator=sum of numerator= value1+value2
%posterior=numerator/denominator=[pmf1 pmf2]
%sum(posterior)=pmf1+pmf2=1