% Rainfall forecasting using Support Vector Machines :)
% Programmed by Anirudh.V
%               B Tech Civil III yr
%               IIT Roorkee

clear all; clc;

global LEARNDATA TRAINDATA TESTDATA DATA ii PrevCostFactor; % Set global variables
global PrevTrainAccuracy PrevTestAccuracy generationcount;

Threshold = 1;
PrevTrainAccuracy = 0; PrevTestAccuracy = 0;
load('DATA.mat');
DATA(1,1:5) = 0; ii = 1; generationcount=1;

optionz = gaoptimset('PopulationSize', 200,'EliteCount',52,'StallTimeLimit',5000,'Generations',5000,'StallGenLimit',5000);
[Parameters Accuracy reason] = ga(@RainSVM,1,optionz);
xlswrite('LINGA',DATA);
exit