% Rainfall forecasting using Support Vector Machines :)
% Programmed by Anirudh.V
%               B Tech Civil III yr
%               IIT Roorkee

clear all; clc;
load('DATA.mat');
DATA(1,1:5) = 0; ii = 1;

for COST = [2.2383 2.4221 2.5145 3.3131 3.9269 5.6127]
options = sprintf('-c %15.5f',COST);
   model_1 = svmtrain(LEARNDATA(1:end,6), LEARNDATA(1:end,1:5),options);
   model_2 = svmtrain(TRAINDATA(1:end,6), TRAINDATA(1:end,1:5),options);   
   model_3 = svmtrain(TESTDATA(1:end,6), TESTDATA(1:end,1:5),options);

   [predicted_label_learn, accuracy_learn, decision_values] = svmpredict(LEARNDATA(1:end,6), LEARNDATA(1:end,1:5), model_1);
   [predicted_label_train, accuracy_train, decision_values] = svmpredict(TRAINDATA(1:end,6), TRAINDATA(1:end,1:5), model_1);
   [predicted_label_test, accuracy_test, decision_values]   = svmpredict(TESTDATA(1:end,6), TESTDATA(1:end,1:5), model_1);
   
    DATA(ii,1) = COST;
    DATA(ii,2) = accuracy_learn(1);
    DATA(ii,3) = accuracy_train(1);
    DATA(ii,4) = accuracy_test(1);
    DATA(ii,5) = model_1.totalSV;
    DATA(ii,6) = model_2.totalSV;
    DATA(ii,7) = model_3.totalSV;
ii = ii + 1;
end
xlswrite('LINGA_2',DATA)