% written by professor Jay McClelland
function [record] = trainAgent( )
global p d a;

initParamsEtc();
run = struct('results',[]);
di = 1;
% textprogressbar('Training: ')
for i = 1:p.runs
%     textprogressbar(i)
   run.results = runAgent();
   a.smgain = a.smgain + p.smirate;
   if i == d.dtimes(di)
       prstr = sprintf('%d: ',i);
       rstr = input(prstr,'s');
       if rstr == 'b'
           break;
       end
       di = di+1;
   end
end
% textprogressbar(' Done.')
record.r = run;
record.p = p;
end