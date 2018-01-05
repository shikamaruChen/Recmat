function [ diff ] = preserve( F1,F2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
X1 = square_diff(F1);
X2 = square_diff(F2);
X = X1-X2;
diff = sum(sum(abs(X)));
end

