% Laten (hidden) variables X : Sleep Stages (a = 1 (WAKE), 2(REM), 3(LIGHT), 4(DEEP))
% Observation variables Y    : Frequency Band containing the highest power
%                               (b = 1 (WAKE:35 Hz ~), 2 (REM:20~30 Hz), 3 (LIGHT:10.25~15.75), 4 (DEEP:1~3hz)), 
%                                which can be calculated using Julie's code

clear; close all;

% Initial Probabiliies [WAKE, REM, LIGHT, DEEP], assuming sleep stage starts from WAKE
pi = [1 0 0 0];     


% Transition Matrix of Sleep Stages : Q(i,j) = P(X_{t+1} = j| X_t = i)

% Transition Matrix of Sleep Stages for healthy group (C. Lo et al.
% Europhysics Letters 2013)
% ~~~~ Should we get this from PTSD patients? ~~~~~
Q = [.75 .01 .24 0;
     .05 .88 .07 0;
     .18 .11 .55 .16;
     .02 0 .14 .84];

% R : likelihood, P(Y_t|X_t)
% R{i}(j) = P( Y_t = i | X_t = j )
% X : WAKE    REM    LIGHT    DEEP
% These are arbitrary number. We can get these from public data
% ~~~~ Should we get this from PTSD patients? ~~~~~
% And also we can model these using statistical model like Gaussian (mean(R{:}(1)),var(R{:}(1))). 
% X :   WAKE  REM  LIGHT   DEEP
R{1} = [ .7     .15      .05       0 ];     % [35 Hz ~ ]
R{2} = [ .2     .8        .1       .03];     % [20 ~ 30 Hz]
R{3} = [ .1     .03      .7       .07];     % [10.25 ~ 15.75 Hz]
R{4} = [ 0      .02      .15      .9 ];     % [1 ~ 3 Hz]

% possible y values are 1, 2, 3, 4

% the number of sleep stages (latent variables)
nLatentStates = 4;

% b is the data we observed.
% These are just arbitrary number. 
% We can get these from test set.
b = [1 2 2 1 2 3 3 3 4 3 4 4 3 2 2 2 1 1 1 1]; 

% B_1|0 : same as pi
B10 = pi;
% initial time point
t = 1;
% B_t|t-1
B_t_given_tprev = pi;

% B(i,j,a) = P(X_i = a | Y_j = b(j) ) 
for i = 1:length(b)
    y = b(i);
    
    if i == 1
        normalizationConstant = sum(B10.*R{y});
        for a = 1:nLatentStates
            % Bayes rule: prior * likelihood / normalizationConstant;
            prior = B10(a);
            likelihood = R{y}(a);
            B(i,i,a) = prior*likelihood/normalizationConstant;
        end
    else
        % Step 1 : B_i|i-1
        % one-step prediction update.
        % law of total probability
        % P(X_t = a | Y_{t-1} = b(t-1) )  = 
          % sum_{a'} P(X_{t-1} = a' | Y_{t-1} = b(t-1) ) x P(X_t = a | X_{t-1}=a')
        for a = 1:nLatentStates            
            B(i,i-1,a) = sum(squeeze(B(i-1,i-1,:)).*Q(:,a));            
        end
        
        % Step 2 : Bi|i
        % P(X_t = a | Y_t = b(t) )
        normalizationConstant = sum(squeeze(B(i,i-1,:))'.*R{y});
        for a = 1:nLatentStates
            prior = B(i,i-1,a);
            likelihood = R{y}(a);
            B(i,i,a) = prior*likelihood/normalizationConstant;
        end
    end
    
end

k = 1;
for i = 1:size(B,1)
    subplot(ceil(size(B,1)/5),5,i);
    stem(squeeze(B(i,i,:)));
    title(['time = ',num2str(k)]);
    k = k+1;
end

sleepstage = {'WAKE','REM','LIGHT','DEEP'};
figure
for i = 1:size(B,3)
    subplot(size(B,3),1,i);
    plot(diag(squeeze(B(:,:,i))));
    title(sleepstage{i},'fontsize',14);
    xlabel('time index');
    ylabel('Probability');
end