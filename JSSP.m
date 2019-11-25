function [makespan, sequence, avg_fit, best_fit] = JSSP (file)
  
  %------------- Open input file -------------
  fileID = fopen(file,'r');
  formatSpec = '%d,%d,%d';
  sizeIn = [3 Inf];
  input = fscanf(fileID, formatSpec, sizeIn)';
  
  % ------------ Initial conditions ------------
  pop = [];
  vel = [];
  bestInd = [];
  fitInd = [];
  fitBest = inf;
  popSize = 6;
  gen = 1;
  maxGen = 50;
  limitPos = [-4, 4];
  limitVel = [-4, 4];
  
  % ----------- Initial Population --------------
  numPlates = length(input(:, 1));
  for i=1:popSize
    r1 = [];
    r2 = [];
    for j=1:numPlates
      r1 = [r1, limitPos(1) + (limitPos(2) - limitPos(1))*rand];
      r2 = [r2, limitVel(1) + (limitVel(2) - limitVel(1))*rand];
    end
    pop = [pop; r1];
    vel = [vel; r2];
  end
  
  while (gen < maxGen)
    for i=1:popSize
      popJob = SPV(pop(i), limitPos(2));
      fit = fitness(popJob, input);
      if fit < fitBest
        fitBest = fit;
        G = 
      end
    end
    gen = gen + 1
  end
end