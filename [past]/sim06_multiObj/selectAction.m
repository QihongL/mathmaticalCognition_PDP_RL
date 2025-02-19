% written by professor Jay McClelland
function [] = selectAction( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global w a p;

%% compute the normalized activation
% a.net = a.wts * w.vS.visInput';
% scnet = p.smgain*a.net;
% a.act = exp(scnet)/sum(exp(scnet));
%% compute the output activation
a.act = a.wts * w.vS.visInput';
% bias toward action 0 (don't move)
a.act(p.mvRad + 1) = a.act(p.mvRad + 1) + a.bias; 
% choose among the activation
a.choice = choose(a.act.^a.smgain);
w.out.targGuess = a.choice - p.mvRad - 1; % get vS action

%% compute the "moving vector" for eye and hand (in vS)
w.out.handStep = w.out.targGuess - w.vS.handPos;
w.out.eyeStep = w.out.targGuess; % already in eye-centered coordinates
end
