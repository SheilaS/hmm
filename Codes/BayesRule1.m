function posterior=BayesRule1(prior,likelihood,k)
prior=[0.5 0.5]
likelihood=[0.25 0.75; 0.75 0.25]
k=2
d=length(prior)
for index=1:d
    numerator(index)=prior(index)*likelihood(index,k)
end
denominator=sum(numerator)
posterior=numerator/denominator
sum(posterior)
stem(posterior)
title('Belief about X')
xlabel('State that X takes')
ylabel('Probability')
end
