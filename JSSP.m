function [makespan, sequence, avg_fit, best_fit] = JSSP (file)
  
  %------------- Open input file -------------
  fileID = fopen(file,'r');
  formatSpec = '%d,%d,%d';
  sizeIn = [3 Inf];
  input = fscanf(fileID, formatSpec, sizeIn)';
  
  % ------------ Initial conditions ------------
  population = [];                % Population matrix
  velocities = [];                % Velocities matrix
  positions = [];                 % Positions matrix
  fitPop = [];
  fitBestInd = [];                % fitness matrix of best of individuals
  bestInd = [];                   % matrix of the best position indivualy
  bestGlobal = 0;                 % The best global position
  globalFit = 0;                  % Best global fitness
  bestFit = [];
  avgFit = [];
  
  w = 0.9;                        % Inertia Weight
  lF = 2;                         % Local factor
  gF = 1.6;                       % Global factor
  
  popSize = 25;                   % Population Size
  gen = 0;                        % Genereation counter
  maxGen = 200;                   % Max number of generation
  limitPos = [-4, 4];             % Position limits (only to random)
  limitVel = [-4, 4];             % Velocities limits
  
  % ----------- Initial Population --------------
  numPlates = length(input(:, 1));
  for i=1:popSize
    r1 = [];
    r2 = [];
    for j=1:numPlates
      r1 = [r1, limitPos(1) + (limitPos(2) - limitPos(1))*rand];
      r2 = [r2, limitVel(1) + (limitVel(2) - limitVel(1))*rand];
    end
    population = [population; r1];          % Calculation of initial population
    velocities = [velocities; r2];          % Calculation of initial velocities
    job = SPV(r1);                          % Discretization
    fitBestInd = [fitBestInd; fitness(job, input)];
  end
  bestInd = population;
  positions = population;
  [globalFit, index] = min(fitBestInd);
  bestGlobal = bestInd(index, :);
  
  bestFit = [bestFit, globalFit];
  avgFit = [avgFit, sum(fitBestInd)/popSize];
  
  %------------------ Infinity loop -----------------
  while(gen < maxGen)                  % Duranting some epochs
    gen = gen + 1;
  
    for i=1:popSize
      for j=1:numPlates
        r1 = rand;
        r2 = rand;
        wpond = w - ((w - 0.5)/maxGen)*gen;               % Inertia weigth is calculated
        velocities(i, j) = wpond*velocities(i, j) + \     % New velocity
        r1*lF*(bestInd(i, j) - positions(i, j)) + \
        r2*gF*(bestGlobal(j) - positions(i, j));
        if velocities(i, j) > limitVel(2)                  % Limit the velocities
          velocities(i, j) = limitVel(2);
        end
        if velocities(i, j) < limitVel(1)
          velocities(i, j) = limitVel(1);
        end
      end
    end
    population = population + velocities;           % Population atualization
    
    fitPop = [];
    for i=1:popSize
      job = SPV(population(i, :));                  % Discretization
      ft = fitness(job, input);                     % Evaluate the new pop
      fitPop = [fitPop, ft];
      if (ft < fitBestInd(i))                       % Update individual bests
        bestInd(i, :) = population(i, :);
        fitBestInd(i) = ft;
      end
    end

    [minV, index] = min(fitBestInd);                % Update global best
    if minV < globalFit
      globalFit = minV;
      bestGlobal = bestInd(index, :);
    end
    
    bestFit = [bestFit, globalFit];
    avgFit = [avgFit, sum(fitPop)/popSize];
  end
  
  best_fit = bestFit;                               % Return the variables
  avg_fit = avgFit;
  makespan = globalFit;
  sequence = SPV(bestGlobal);
  
  genVec = [0:1:maxGen];                            % Graphic plots
  figure(1)
  plot(genVec, bestFit, 'r')
  title('Grafico de menor makespan por geracao')
  xlabel('Numero da geracao')
  ylabel('Makespan')
  figure(2)
  plot(genVec, avgFit, 'b')
  title('Grafico de makespan medio por geracao')
  xlabel('Numero da geracao')
  ylabel('Makespan medio')
  
end