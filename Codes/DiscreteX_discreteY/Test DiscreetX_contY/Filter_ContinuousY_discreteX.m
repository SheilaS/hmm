%Run the Nonlinear Filter On Data I Generate

%Step 1: Define pi, Q, R matrices
pi = [0.3 0.7];
Q= [0.2 0.8; 0.4 0.6];
% R=[0.3 0.7; 0.4 0.5];
R = [1 0 1; 2 10 3];

%Step 2:Generate Data

x(1)= generateRandomBinaryOutcome_S(pi);
n=15;

%This for loop will generate a sequence of "n" X values
%This loop uses the Q matrix to calculate X at time t, given X at time t-1
for t=2:n;
    xprevious= x(t-1);
    currentPMFx=Q(xprevious,:);  
 x(t)=generateRandomBinaryOutcome_S(currentPMFx);
    xcurrent=x(t);
end

%This for loop will generate a sequence of "n" Y values
%This for loop uses the R matrix to calculate Y at time t, given X at time
%t-1
% for t=1:n;
%     xcurrent=x(t);
%     currentPMFy=R(xcurrent,:);
%     y(t)=generateRandomBinaryOutcome_S(currentPMFy);
% end
% x
% y

for t=1:n;
    xcurrent=x(t);
    if xcurrent<=1
        mu=0;
        sigma= sqrt(1);
        y(t)=normpdf(x(t), mu, sigma);
    else if xcurrent>=1
            mu=10;
            sigma=sqrt(3);
            y(t) = normpdf(x(t), mu, sigma);
        end
    end  
end
x
y

yvector  = y;
dimX = length(pi);
dimY = size(R,1); % or size(R,2); %I think this tells us that Y will be 2 rows, 1 column

T = length(yvector);
% filterCurrentPMF(t,j) = P(X_t = j | Y_1...Y_t)
% filterNextPMF(t,j) = P(X_{t} = j | Y_1...Y_{t-1})


nextbelief=pi;


for t=1:T,

    % now do Bayes Rule
    y = yvector(t);
    % prior = filterNextPMF(t,:);
    prior = nextbelief;
    %Our nextbelief is where we predict X is going to be at the next time
    %step- i.e. P(X) at time t|X at time t-1
    
    %Because Y is a noisy version of X, we want to combine our
    %prior(prediction of X at the next time step) with our observation of Y
    %at the next time step. (this should strengthen our confidence in our
    %belief on X at the next time step. I.e. more info is better)
    
    posterior = BayesRule3_cont(prior)
    
    %The posterior above tells us our belief on X at time t|Y=b at time t.
    %So now we have our updated belief on X at time t, based on X at the previous time
    %point (t-1) and Y at time t.
    
    %Now we want to repeat this. i.e. we start by predicting where X will be at time t+1, based
    %on where we know x is at time t.
    
   subplot(T/5,5,t), stem(posterior);
%    subplot(ceil(size(B,1)/5),5,i);
%     stem(squeeze(B(i,i,:)));
    titlestring = sprintf('b_{%d|%d}(j)',t,t);
    title(titlestring)
    xlabel('State j that X takes')
    
    %    ylabel(ystring);

    % update the filter PMF
    for j = 1:dimX,
        filterCurrentPMF(t,j) = posterior(j);
    end
    
    % at this point we do the one step prediction update
    % currentPMF = filterCurrentPMF(t,:);
    for j = 1:dimX,
        currentPMF(j) =filterCurrentPMF(t,j);
    end 
    nextbelief = OneStepPredictionUpdate(currentPMF,Q)  
    
%     pause;

end

