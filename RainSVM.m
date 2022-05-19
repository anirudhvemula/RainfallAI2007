function output = RainSVM(Input)
  global LEARNDATA TRAINDATA TESTDATA DATA PrevCostFactor;
  global PrevTrainAccuracy PrevTestAccuracy ii generationcount;

  if(Input(1) <= 0)
     Input(1) = PrevCostFactor; %take a positive value of cost factor!
  end

  options = sprintf('-c %s',num2str(Input(1)));
  model = svmtrain(LEARNDATA(1:end,6), LEARNDATA(1:end,1:5),options);
  [predicted_label_learn, accuracy_learn, decision_values] = svmpredict(LEARNDATA(1:end,6), LEARNDATA(1:end,1:5), model);
  [predicted_label_train, accuracy_train, decision_values] = svmpredict(TRAINDATA(1:end,6), TRAINDATA(1:end,1:5), model);
  [predicted_label_test, accuracy_test, decision_values]   = svmpredict(TESTDATA(1:end,6), TESTDATA(1:end,1:5), model);

  if (accuracy_train(1) > PrevTrainAccuracy)
    DATA(ii,1) = Input(1);
    DATA(ii,2) = accuracy_learn(1);
    DATA(ii,3) = accuracy_train(1);
    DATA(ii,4) = accuracy_test(1);
    DATA(ii,5) = generationcount;
    DATA(ii,6) = model.totalSV;
    PrevTrainAccuracy = accuracy_train(1);
    ii = ii + 1;
  
  elseif (accuracy_test(1) > PrevTestAccuracy)
    DATA(ii,1) = Input(1);
    DATA(ii,2) = accuracy_learn(1);
    DATA(ii,3) = accuracy_train(1);
    DATA(ii,4) = accuracy_test(1);
    DATA(ii,5) = generationcount;
    DATA(ii,6) = model.totalSV;
    PrevTestAccuracy = accuracy_test(1);    
    ii = ii + 1;
  end

  PrevCostFactor = Input(1);
  if((generationcount - 20*int32(generationcount/20)) == 0)
        save LINGA_RESULTS
    end
  generationcount = generationcount + 1;
  output = -accuracy_learn(1) * model.totalSV; %maximize the accuracy!
end