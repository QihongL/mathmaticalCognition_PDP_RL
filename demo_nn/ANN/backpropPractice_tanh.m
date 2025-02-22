%% back prop
clear all; clf
%% set up
% XOR data
X = [1 1; 1 0; 0 1; 0 0];
Y = [1; 0; 0; 1];

% model parameters
hidden_neurons = 2;
epochs = 5000;

% read num patterns
m = size(X,1);
%add a bias as an input
bias = ones(m,1);
X = [X bias];

%read num inputs
n = size(X,2);

%set initial random weights
wts_ih = randsmall(hidden_neurons,n);
wts_ho = randsmall(1,hidden_neurons);

lr = .2;

%% learning

change.wts_ho = nan(epochs,1);
change.wts_ih = nan(epochs,1);
record.wts_ho = nan(epochs,1);
record.wts_ih = nan(epochs,1);

for iter = 1:epochs    
    temp.change_wts_ho = zeros(m,1);
    temp.change_wts_ih = zeros(m,1);
    
    % loop through all patterns
    for j = 1:m
        % get a random pattern
        patnum = randsample(m,1);
        x = X(patnum,:);
        target = Y(patnum,1);
        
        % forward prop
        hact = tanh(wts_ih * x');
        pred = wts_ho * hact;
        
        % compute delta
        delta_o = pred - target;
        delta_h = delta_o.* wts_ho'.*(1-(hact.^2));
        % adjust the weights
        wts_ho = wts_ho - (delta_o .* hact)' * lr;
        wts_ih = wts_ih - delta_h * x * lr;
        
        % record change
        temp.change_wts_ho(j) = mean(abs(delta_o * lr));
        temp.change_wts_ih(j) = mean(mean(abs(delta_h * lr)));
        
    end
    
    % record the weight change 
    change.wts_ho(iter) = mean(temp.change_wts_ho);
    change.wts_ih(iter) = mean(temp.change_wts_ih);
    record.wts_ho(iter) = mean(abs(wts_ho(:)));
    record.wts_ih(iter) = mean(abs(wts_ih(:)));
    % compute current error 
    pred = wts_ho*tanh(wts_ih*X');
    error = pred' - Y;
    err(iter) = sum(error.^2);
    
    %stop if error is small
    if err(iter) < 0.001
        fprintf('converged at epoch: %d\n',iter);
        break
    end
    
end


%% plot the performance 
figure(1);
p.FS = 14;
p.LW = 2;

% 
subplot(1,3,1)
plot(err, 'linewidth', p.LW)
xlim([0 iter])

ylabel('Squared error', 'fontsize', p.FS)
xlabel('Training epoch', 'fontsize', p.FS)
title1_text = sprintf('back prop XOR \n conv. after %d epochs\n',iter);
title(title1_text, 'fontsize', p.FS);

% 
subplot(1,3,2)
hold on 
plot(change.wts_ho, 'linewidth', p.LW)
plot(change.wts_ih, 'linewidth', p.LW)
hold off 
xlim([0 iter])

xlabel('Training epoch', 'fontsize', p.FS)
title('the magnitude of weight change', 'fontsize', p.FS);
legend({'hidden to output','input to hidden'}, 'fontsize', p.FS)

% 
subplot(1,3,3)
hold on 
plot(record.wts_ho, 'linewidth', p.LW)
plot(record.wts_ih, 'linewidth', p.LW)
hold off 
xlim([0 iter])

xlabel('Training epoch', 'fontsize', p.FS)
title('the magnitude of the weights ', 'fontsize', p.FS);
legend({'hidden to output','input to hidden'}, 'fontsize', p.FS, 'location', 'SE')


%% display actual,predicted & error
wts_ih
wts_ho
target_prediction_difference = [Y pred' Y-pred']

