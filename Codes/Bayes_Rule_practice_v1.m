clear all
prior= [0.5 0.5]
likelihood= [0.25 0.75; 0.75 0.25]
k=2
d=length(prior)
f= BayesRule(prior,likelihood,k)
for index=1:d
    numerator(index)=prior(index)*likelihood(index,k)
end
denominator=sum(numerator)
sum(f)=numerator(index)/denominator
likelihood(1,2)
likelihood(2,2)
