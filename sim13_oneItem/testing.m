% just testing, a short cut for running the model
function testing(epoch)
if nargin == 0
    epoch = 3000;
end
record = trainAgent(epoch);
save('record','record');
quiz()
checkLearning()
end
