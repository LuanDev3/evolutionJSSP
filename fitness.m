function [fit] = SPV (ind, input)
  % Function which calculates the makespan
  % of a sequence of jobs
  mA = [input(ind(1), 1)];          % Create machine A vector
  for i=1:(length(ind) - 1)
    mA = [mA, mA(i) + input(ind(i + 1), 1)];
  end
  
  mB = [mA(1) + input(ind(1), 2)];  % Create machine B vector
  for i=1:(length(mA) - 1)
    if ((mB(i)) >= mA(i + 1)) 
      aux = mB(i) + input(ind(i + 1), 2);
    else
      aux = mA(i + 1) + input(ind(i + 1), 2);
    end
    mB = [mB, aux];
  end
  
  mC = [mB(1) + input(ind(1), 3)];  % Create machine C vector
  for i=1:(length(mB) - 1)
    if ((mC(i)) >= mB(i + 1))
      aux = mC(i) + input(ind(i + 1), 3);
    else
      aux = mB(i + 1) + input(ind(i + 1), 3);
    end
    mC = [mC, aux];
  end
  fit = mC(end); % The maskespan value, is the last value of mC vector
end