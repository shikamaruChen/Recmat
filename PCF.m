function [ S ] = PCF( R, F, beta, gamma, lambda )
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here

disp('Parameters: ')
fprintf('beta=%f\n', beta)
fprintf('gamma=%f\n', gamma)
fprintf('lambda=%d\n', lambda)

[m,n] = size(R);
d = size(F,2);
H = eye(n) - 1/n;
FH = F'*H;
Q = FH*F + beta*eye(d);
A = Q^-1*FH;
B = H*(F*A-eye(n));
F = [B; sqrt(beta)*A; sqrt(gamma)*eye(n)];
S = [zeros(n+d, m); sqrt(gamma)*(R')];
[Fl,Fs,Fr] = svd(F);
[Rl,Rs,Rr] = svd(R');
tol = 0.0001;
Fs = arrayfun(@(v) recip(v), Fs);
F = Fr*(Fs')*(Fl');
Rs = arrayfun(@(v) recip(v), Rs);
iR = Rr*(Rs')*(Rl');

M = Fl*S*Rr;
[Ml,Ms,Mr] = svd(M);
ms = diag(Ms);
ms((lambda+1):end) = 0;
Ms(eye(size(Ms))>0) = ms;
M = Ml*Ms*(Mr');
S = F*M*iR;

    function [v] = recip(v)
        if v>tol
            v = 1/v;
        else
            v = 0;
        end
    end
end