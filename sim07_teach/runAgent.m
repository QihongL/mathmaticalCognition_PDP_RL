% written by professor Jay McClelland
function [ results ] = runAgent(seed)
global a w h p;
rng(seed)
w.seed = seed;

% initialize the state
initState();
updateState();
% showState();

i = 0;
while ~(w.done) && i < 100
    % alternate action and state update
    selectAction();
    Act();
    updateState();
    updateWeights();
    %     showState();
    i = i+1;
    if p.teach && w.redo
        % re-initialize the world
        reinitState();
        updateState();
        i = 0;
    end
end
%keyboard;
results.h = h;
results.a = a;
end