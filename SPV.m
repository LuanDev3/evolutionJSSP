function [sequenceDis] = SPV (sequenceCont)
  % Function to transform a continue sequence
  % on a discrete sequence of Jobs
  jobs = [];
  for i=1:length(sequenceCont)
    [value, pos] = min(sequenceCont);    % Find the min
    sequenceCont(pos) = inf;             % Replace by inf
    jobs = [jobs, pos];                  % Update Jobs
  end
  sequenceDis = jobs;
end