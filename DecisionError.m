function output = DecisionError(Target,Predict)
% DecisionError is used to find the decision error
% between the Target and Predicted data...

count = 0;
nSize = size(Target);

for ii = 1 : nSize
    if sign(Target(ii)) ~= sign(Predict(ii))
        count = count + 1;
    end
end

output = (count / nSize(1));
end