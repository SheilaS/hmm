function posterior=BayesRule3(prior,likelihood,y)
% prior= [0.3 0.7];
d=length(prior);
% 
% likelihood = [0.1 0.9; 0.95 0.05];
% y=2;
for index=1:d
    numerator(index)=prior(index)*likelihood(index,y);
end
denominator=sum(numerator);
posterior=numerator/denominator;
sum(posterior)
end


%[prior(index)=P(X=a1)]*[likelihood=P(Y=b|X=a1)]=[value1     ]
%[prior(index)=P(X=a1)]*[likelihood=P(Y=b|X=a1)]=[     value2]

%denominator=sum of numerator= value1+value2
%posterior=numerator/denominator=[pmf1 pmf2]
%sum(posterior)=pmf1+pmf2=1