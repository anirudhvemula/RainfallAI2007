% Rainfall forecasting using Support Vector Machines :)
% Programmed by Anirudh.V
%               B Tech Civil III yr
%               IIT Roorkee
clc;
clear all;

file = importdata('train.xls');
TRAINDATA = file.data.Sheet1;
max_rainfall = max(TRAINDATA(1:end,6));
file = importdata('train.xls');
TESTDATA = file.data.Sheet1;
Threshold = 1.2;

TRAINDATA(1:end,6) = Classify(TRAINDATA(1:end,6),Threshold);
TESTDATA(1:end,6) = Classify(TESTDATA(1:end,6),Threshold);

for ii = 1:5
 TRAINDATA(1:end,ii) = Normalize(TRAINDATA(1:end,ii),TESTDATA(1:end,ii));
 TESTDATA(1:end,ii) =  Normalize(TESTDATA(1:end,ii),TRAINDATA(1:end,ii));
end

  svmlwrite('train.svml',TRAINDATA(1:end,1:5),TRAINDATA(1:end,6));
  svmlwrite('test.svml',TESTDATA(1:end,1:5),TESTDATA(1:end,6));
%   ------------------------------------------------------------------------------ 
    [Y, X] = svmlread('train.svml');          % Import Training Rainfall data...                                              
    net = svml('model', 'Kernel', 0, 'C', 1); % Construct the SVM Net structure...
    net = svmltrain(net, X, Y);

    [Ytest1, Xtest1] = svmlread('train.svml'); % Import Testing DATA
    YPred1 = svmlfwd(net, 'train.svml');       % Predict the data using constructed SVM... 

    [Ytest2, Xtest2] = svmlread('test.svml');  % Import Testing DATA
    YPred2 = svmlfwd(net, 'test.svml');        % Predict the data using constructed SVM... 

    Error(1,1) = DecisionError(Ytest1,YPred1) * 100; % Calculate the Decision Error
    Error(1,2) = DecisionError(Ytest2,YPred2) * 100  % Calculate the Decision Error
 save variable;