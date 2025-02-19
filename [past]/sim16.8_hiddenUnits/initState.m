% written by professor Jay McClelland
function [ ] = initState( )

global a w h p mode;

%% specify the parameters
% a.act = zeros(p.mvRange+1,1);
a.dfRwd = 0;
a.Rwd = 0;
w.rS.time = 0;
w.rS.td = 0;
w.stateNum = -1;

% preallocation for activations
% a.old.hIn = zeros(p.nHidden,1);
% a.old.hAct = zeros(p.nHidden,1);
% a.old.aIn = zeros(p.mvRange+1,1);
% a.old.aAct = zeros(p.mvRange+1,1);
a.hIn = zeros(p.nHidden,1);
a.hAct = zeros(p.nHidden,1);
a.aIn = zeros(p.mvRange+1,1);
a.aAct = zeros(p.mvRange+1,1);

% record errors
w.errors = 0; 
w.numSkips = 0;
w.numDoubleTouch = 0; 
w.stopEarly = false; 

% generate items in space
if isfield(mode, 'fixNumItems') && mode.fixNumItems
    w.nItems = mode.nItem;              % fix the number of items
else
    w.nItems = generateNum(p.maxItems);     % sample the number from prob 
end
w.rS.targPos = itemGen(w.nItems);       % generate items
w.rS.targRemain = true(w.nItems, 1);    % set up flag 
w.done = false;

% initialize the location of hand and eye
w.rS.eyePos  = min(w.rS.targPos) - (randi(p.maxSpacing-p.minSpacing)+ p.minSpacing);
w.rS.handPos = min(w.rS.targPos) - (randi(p.maxSpacing-p.minSpacing)+ p.minSpacing);

% view state or the perceived state
w.vS.oldInput = zeros(1, p.eyeRange);
w.vS.visInput = zeros(1, p.eyeRange);
w.out.handStep = 0;
w.out.eyeStep = 0;

% teaching specific
mode.teach = true; 
if p.teacherForcingOn
    w.teacherForcing = mode.teacherForcing; 
else 
    w.teacherForcing = false; 
end
% save
h = struct('w',w);
end

