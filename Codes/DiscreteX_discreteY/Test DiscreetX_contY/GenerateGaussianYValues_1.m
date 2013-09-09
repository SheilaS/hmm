a=2
b=4

Z=randn %this will generate random values pulled from a gaussian of mean 0, 
% variance 1: i.e. the standard normal distribution
% Y=a*Z+b % Y is a Gaussian with a new mean (a*(mu)+b) and variance (a^2*(var z)^2
%since our original mu is equal to 0, our new mean equals b
%since our original (Z) variance equals 1, our new variance=a^2

%We want to identify Y values according to the state of X.  If X=1, Y
%values are drawn from gaussian(mu=0, var=1)

%If X=2, Y values are drawn from gaussian (mu=b, var=a^2)
X=rand

if X<0.5
    Y=Z
else if X>=0.5
        Y=a*Z+b
    end
end

