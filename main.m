% --------- Clear the envionment -----------
clc;
clear;
close all;
  
[makespan, sequence, avg_fit, best_fit] = JSSP("entrada_25.txt");

best_fit;
avg_fit;
makespan
sequence