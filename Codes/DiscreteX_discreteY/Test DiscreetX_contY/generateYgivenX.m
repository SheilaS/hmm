function Yvalue = generateYgivenX(x, R)
%UNTITLED7 Summary of this function goes here
%   Y=a*Z+b
%when "Z" is a normal Gaussian, the stats are mean=0, variance=1
%so, the new mean for Y=b, because a*0=0

%our current x can only take on two discrete states: x=1, or x=2; so these
%values tell our function which mean/variance should be considered from the
%R matrix (or here the R.mean and R.variance vectors)

%the variance for Y is a^2 * variance of Z(which here equals 1), so a=sqrt
%of variance

a=sqrt(R.variance(x));
b=R.mean(x);
Z=randn;
Y=a*Z+b; 
Yvalue=Y;
% if x==1   
% a=sqrt(R.var(x))
%     b=R.mean(x)
% else if x==2
%         a=sqrt(R.var(x))
%         b=R.mean(x)
%             end
%    Y   


end

