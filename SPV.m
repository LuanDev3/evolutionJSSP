function [sequenceDis] = SPV (sequenceCont, lim)
  % Function to transform a continue sequence
  % on a discrete sequence of Jobs
  jobs = [];
  for i=1:length(sequenceCont)
    [value, pos] = min(sequenceCont);
    sequenceCont(pos) = lim + 1;
    jobs = [jobs, pos];
  end
  sequenceDis = jobs;
end