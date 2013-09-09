%play with a pi vector where X can take on more than 2 values
pi= [0.2 0.3 0.5]
%call the generateRandomOutcome function.
x=generateRandomOutcome(pi)


%generateRandomOutcome will call on a z=rand, and compare it to a left and
%right boundary.

%This is done in a "for" loop, where the index numbers are the values that
%can be taken by X.

%We feed X values to the function, starting with 1.  
% Initially the left boundary is equal to zero, and the right boundary is
% equal to the pmf(index). In this case, index=1.
%So, the function will evaluate whether the "z" value falls between 0 and
%for example, 0.2 (pi(1).

%If "z" does fall within the boundaries for index=1, then the output of the
%function=1. So x will equal 1.

%If "z" does not fall within the boundaries for index=1, then the for loop
%will continue to the next index value, index=1.  

%Now the leftboundary=the previous right boundary (in this example, 0.2).  

%%%HERE AGAIN IT FEELS LIKE THE CODE IS LIMITED BECAUSE THE PROBABILITY
%%%VALUES THAT THE INDEXS TAKE MUST INCREASE IN VALUE IN PARALLEL WITH AN
%%%INCREASE IN THE INDEX NUMBER.  IN OTHER WORDS, WHAT IF PI WAS [0.7,
%%%0.25, 0.05]. THIS DOES NOT WORK WITH THE WAY WE HAVE DEFINED THE
%%%BOUNDARIES.  RETURN TO THIS ISSUE%%%

%But in the meantime for the current code, the leftboundary=previous right
%boundary.  

%new rightboundary=leftboundary+pmf(index)-in this case index=2. 
%so in this example, for index=2, leftboundary=0.2, right
%boundary=0.2+0.3=0.5
%so if "z" falls between 0.2 and 0.5, x=2. else the for loop will repeat
%for index=3.
%in this example, the boundaries for index=3 are leftboundary=0.5 (old
%right boundary) and rightboundary=1 (sum of leftboundary+pmf(index=3).