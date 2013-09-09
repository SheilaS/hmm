function testpmfs
%pmf = [0.28 0.51 0.21];
pmf = [0.21 0.51 0.28];
%pmf = [0.28 0.51 0.21];

x = [];

for index=1:10,
    outcome = generateRandomOutcome(pmf)
    x(index)=outcome;
end

hist(x)
xlabel('values of RV X')
ylabel('number of times that each index occurs')
%x values are along the x axis.  the range of values is sorted into 10
%bins, where the values of the bins are equally divided between the max and
%the minimum values that x can take.

%the y axis values represent the frequency (# of times) that each of the
%index values occurs.
end