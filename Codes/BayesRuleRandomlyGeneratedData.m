clear, close all
generateDataWithGivenPiQR
b=y
n=length(b)
for t=2:n
prior=[0.2 0.8]
likelihood=[0.3 0.7; 0.4 0.5]
%how do I incorporate new prior,likelihood as compared to the ones in the
%BayesRule1 function?% Figure this out later
k=b(1)
d=length(prior)
x=BayesRule1(prior,likelihood,k)
end
x