% written by professor Jay McClelland
function [] = initParams(epoch)
% This program initialize and preallocate the parameters needed for the
% model. This should be executed before the simulations. 
global p a

%% modeling parameters 
p.wf = .1;         % noise magnitude
p.lrate = .001;       % learning rate
p.runs = epoch;     % trainming upper lim 
p.gamma = .9;       % discount factor 
p.smirate = .001;   % soft max rate
p.smi_upperLim = 10; % the upper limit of the smi rate
p.maxIter = 100;    % terminate if cannot finish in 100 iter

%% teaching mode
% controls the redo mode 4
p.teachingModeOn = 0;
p.maxTeachTrial = 100;

% flag for the teacher forcing mode 
p.teacherForcingOn = 0;


%% counting specific
% size of the state space and percetual span
p.spRad = 40;
p.spRange = p.spRad * 2 + 1;
% the max unit that the model can move
p.mvRad = 7; 
p.mvRange = p.mvRad * 2 + 1;
p.eyeRad = 15; 
p.eyeRange = p.eyeRad * 2 + 1;

% number of items in the environment
p.maxItems = 7;         % max number of items
p.maxSpacing = 5;       % max spacing between neighbouring items
p.minSpacing = 2;       % min spacing between neighbouring items

%% reward values
p.r.smallNeg = - 0.05;
p.r.midNeg = - 1;
p.r.bigNeg = - 5;
p.r.midPos = 5;
p.r.bigPos = 10;
% less feed back mode
% p.r.smallNeg = 0;
% p.r.midNeg = 0;
% p.r.bigNeg = 0;
% p.r.midPos = 0;
% p.r.bigPos = 1;

%% actively stop the task
% if the model doesn't move for 5 steps, terminate the task
p.stopCounter = 3;

%% network specific
p.nHidden = 20; 
a.bias = .1;     % bias toward not moving (action 0)
a.smgain = 1;
% initialize with small small random values 
a.wts1 = randSmallWeights(p.nHidden, p.eyeRange); 
a.wts2 = randSmallWeights(p.mvRange, p.nHidden); 
% a.identity = eye(p.nHidden, p.eyeRange); 

%% insert testing questions during the training
p.testInterval = 100; 
p.testBatchSize = 10; 
end

