function posterior= BayesRule(prior,likelihood,k)
prior= [0.5 0.5]
likelihood= [0.25 0.75; 0.75 0.25]
k=2
d=length(prior)
for index=1:d
    numerator(j)=prior(j)*likelihood(j,k)
end
end