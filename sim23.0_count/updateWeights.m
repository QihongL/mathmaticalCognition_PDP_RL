% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global p a w buffer;

% % update the input 
w.input_old = horzcat(w.vS.visInput_old, w.rS.touchLocs_old);
w.input_cur = horzcat(w.vS.visInput_cur, w.rS.touchLocs_cur);
% updateInput();
testInput(w.vS.visInput_cur, w.input_cur(1:p.eyeRange));
% testInput(w.vS.visInput_old, w.input_old(1:p.eyeRange));


%% experience replay ON - update wts w/ a random sample from the buffer
if p.experienceReply
    % save the current transition to the buffer
    updateBuffer();
    % start replay when the buffer is filled
    if a.bufferUsage > a.usage_startReplay
        % take a batch of experience from the buffer
        for i = 1 : p.replay_batchSize
            % sample from the memory buffer, uniformly w/ replacement
            memoryIdx = sampleFromBuffer();
            
            % compute the expected rewrad
            dfRwd = computeFutureReward(buffer(memoryIdx).s_next, ...
                buffer(memoryIdx).r_cur, buffer(memoryIdx).taskDone);
            % weight update
            TD_Err = dfRwd - buffer(memoryIdx).a_act(buffer(memoryIdx).a_cur);
            a.wts(buffer(memoryIdx).a_cur,:) = a.wts(buffer(memoryIdx).a_cur,:) ...
                + p.lrate * TD_Err * buffer(memoryIdx).s_cur;
        end
    end
else
    %% experience replay OFF - update wts w/ current info
    % compute the expected rewrad
    a.dfRwd = computeFutureReward(w.input_cur, a.curRwd, w.done);
    % change in weights equals input times reward prediction error
    TD_Err = a.dfRwd - a.actVal(a.action) - a.countVal(a.count);
    a.wts_m(a.action,:) = a.wts_m(a.action,:) + p.lrate * TD_Err * w.input_old;
    a.wts_c(a.count,:) = a.wts_c(a.count,:) + p.lrate * TD_Err * w.input_old;
end

end


%% HELPER FUNCTIONS

% take a transition from the memory buffer
function [memoryIdx] = sampleFromBuffer()
global a p;

if strcmp(p.replaySamplingMode, 'uniform')
    % sample uniformly
    memoryIdx = randsample(min(p.bufferSize,a.bufferUsage), 1);
elseif strcmp(p.replaySamplingMode, 'softmax')
    % sample using softmax distribution, w.r.t the TD error
    memoryIdx = softmaxChoose(getTD_err(),1);
else
    error('ERROR: unrecognizable sampling mode for experience replay!')
end


% compute the softmax distribution of the TD error
    function [TDErrs] = getTD_err()
        global buffer
        %% TODO check if the buffer is filled!
        
        TDErrs = nan(p.bufferSize,1);
        for i = 1 : length(buffer)
            TDErrs(i) = buffer(i).TDErr;
        end
        TDErrs = abs(TDErrs);
    end
end