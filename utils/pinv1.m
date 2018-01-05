function [B] = pinv1(A, tol)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
[U,S,V] = svd(A);
S = arrayfun(@(v) recip(v), S);
B = V*(S')*(U');
    function [v] = recip(v)
        if v>tol
            v = 1/v;
        else
            v = 0;
        end
    end
end

