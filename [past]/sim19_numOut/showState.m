% written by professor Jay McClelland
function [ ] = showState()
global p w d a;
FONTSIZE = 13; 
% plot rewards over time 
axes(d.rwd);
plot(w.rS.time, a.aCurRwd,'-b*'); 
hold on;
plot(w.rS.time, a.cCurRwd,'-r*'); 
legend({'move', 'number'},'Location','northeast', 'fontsize', FONTSIZE)
ylim(d.rwd,[p.r.bigNeg p.r.bigPos]); 
xlim(d.rwd,[-0.25,w.rS.time+0.25]);
title(d.rwd, 'reward history', 'fontsize', FONTSIZE)
xlabel(d.rwd, 'time', 'fontsize', FONTSIZE)
ylabel(d.rwd, 'reward value', 'fontsize', FONTSIZE)

% plot the history of eye and hand positions
t = w.rS.time;
axes(d.history);
plot(d.history,[-p.spRad p.spRad],[t t]); hold on;
ylim(d.history,[-0.25 t + .25]);
if w.done
    text(w.rS.handPos,t,'o','HorizontalAlignment','center');
else
    text(w.rS.eyePos,t,'@','HorizontalAlignment','center');
    text(w.rS.handPos,t,'#','HorizontalAlignment','center');
end

for i = 1 : w.nItems
    if w.rS.targRemain(i)
        symbol = 'X';
    else
        symbol = '|';
    end
    text(w.rS.targPos(i),t,symbol,'HorizontalAlignment','center');
end
if t ~= 0 
    text((-p.spRad+5),t ,num2str(w.out.countWord),'HorizontalAlignment','center')
end
title(d.history, 'action history', 'fontsize', FONTSIZE)
xlabel(d.history, 'position', 'fontsize', FONTSIZE)
ylabel(d.history, 'time', 'fontsize', FONTSIZE)

end

