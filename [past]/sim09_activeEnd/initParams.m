% written by professor Jay McClelland
function [] = initParams(epoch)
% This program initialize and preallocate the parameters needed for the
% model. This should be executed before the simulations. 
global p a

%% modeling parameters 
p.wf = .05;         % noise magnitude
p.lrate = .1;       % learning rate
p.runs = epoch;     % training upper lim 
p.dtimes = epoch;   
p.gamma = 1;       % discount factor 
p.smirate = .001;   % soft max rate
p.maxIter = 100;    % terminate if cannot finish in 100 iter

%% teaching mode
p.teachingModeOn = 0;
p.teach = 1;
p.maxTeachTrial = 100;

%% counting specific
% size of the state space and percetual span
p.spRad = 35;
p.spRange = p.spRad * 2 + 1;
% the max unit that the model can move
p.mvRad = 10; 
p.mvRange = p.mvRad * 2 + 1;

% number of items in the environment
% when randItems == 1, nItems is the MAX number of items
p.nItems = 7;           % max number of items
p.randItems = 1;        % flag for generating random number of items
p.maxSpacing = 6;       % max spacing between neighbouring items
p.minSpacing = 2;       % min spacing between neighbouring items

%% reward values
p.r.smallNeg = - 0.05;
p.r.midNeg = - 1;
p.r.bigNeg = -10;
p.r.touch = 5;
p.r.finish = 10;

%% network specific
% initialize with small small random values 
a.wts = randsmall(p.mvRange + 1,p.spRange);
a.bias = .5;     % bias toward not moving (action 0)
a.smgain = 1;
end

