% Rainfall forecasting using Artificial Nueral Networks [Perceptron]
% Programmed by Anirudh.V
%               B Tech Civil III yr
%               IIT Roorkee

clc;
clear all;

notify = wavread('notify.wav'); % Notification sound for one complete set
                                % of iterations 
load('DATA.mat');
Threshold = 0.99;
INPUT_DATA(1:end,end) = Classify(INPUT_DATA(1:end,end),Threshold);

LEARN_COUNT = 10;             % No of training samples
nEpochs = 2;                  % No of Passes...

LIMITS = AutoGenLIM(5);       % Autogenerate the Min. Max. values of the inputs depending on LEARNCOUNT;

net = newp(LIMITS,1);         % Create a new nnet using newp [perceptron]

% To initialize the perceptron with random weights
% and biases...
% net.inputweights{1,1}.initFcn = 'rands';
% net.biases{1}.initFcn = 'rands';

net.inputweights{1,1}.initFcn = 'initzero'; % DEFAULT - init with zeros
net.biases{1}.initFcn = 'initzero';         % DEFAULT - init with zeros
net = init(net);

p = INPUT_DATA(1:LEARN_COUNT,1:end-1)';     % Inputs to the Perceptron
t = INPUT_DATA(1:LEARN_COUNT,end)';         % Targets to the Perceptron

for nEpochs = 1:20                          % No of Passes...
   net.trainParam.epochs = nEpochs;
   net = train(net,p,t);                    % Begin TRAINING!

  DATA(nEpochs,1) = (100 - DecisionError(net,TRAINDATA(1:end,1:5)',TRAINDATA(1:end,6)')); % TRAIN_ACCURACY
  DATA(nEpochs,2) = (100 - DecisionError(net,LEARNDATA(1:end,1:5)',LEARNDATA(1:end,6)')); % LEARN_ACCURACY
  DATA(nEpochs,3) = (100 - DecisionError(net,TESTDATA(1:end,1:5)',TESTDATA(1:end,6)'));   % TEST_ACCURACY
  save percpt_EpochVar
  wavplay(notify,22050);                    % Notify
end
exit