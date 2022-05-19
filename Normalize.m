function output = Normalize(x,y)
% Normalize is used to normalize the Rainfall data into
% data within the range [0,1]...

Min = min(min(x),min(y));
Max = max(max(x),max(y));

output = (x - Min)/(Max - Min)
end