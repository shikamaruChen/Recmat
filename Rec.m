function [ S ] = Rec( R, F, T, alpha, beta, lambda, miter )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% F = rnorm(F);
Q = square_diff(F);
RR = R'*R + lambda;
n = size(R,2);
one = ones(n,1);
S = rand(n);
S = S - diag(diag(S));
S = S ./ repmat(sum(S),n,1);

% alpha = 0.5;
updateS();
for i=1:miter
d = size(F,2);
L = laplace_mat(S);
W = eig1(F'*L*F,d-100,0);
% F = F*W;
Q = square_diff(F*W);
updateS();
% alpha = alpha*.5;
end
% pR = R*S;
% pR = pR - pR.*R;        
% res = test(pR,T);
% disp(res);
% 
% d = size(F,2);
% L = laplace_mat(S);
% W = eig1(F'*L*F,d-10,0);
% F = F*W;
% Q = square_diff(F);
% alpha = alpha*0.8;
% end
% for iter=1:miter
%     fprintf('iteration %d, obj=%f\n',iter, object())
%     dn = RR*S + alpha*Q + beta*S;
%     S = S.*RR;
%     S = S./dn;
% end

% alpha = 0.1;
% for iter=1:miter
%     fprintf('iteration %d, obj=%f\n',iter, object())
%     dn = RR*S + alpha*Q + beta*S;
%     S = S.*RR*0.2;
%     S = S./dn;
% end
% 
% alpha = 0.01;
% for iter=1:miter
%     fprintf('iteration %d, obj=%f\n',iter, object())
%     dn = RR*S + alpha*Q + beta*S;
%     S = S.*RR;
%     S = S./dn;
% end
    function []= updateS()
        for iter=1:10
          fprintf('iteration %d, obj=%f\n',iter, object())
          dn = RR*S + alpha*Q + beta*S;
          S = S.*RR;
          S = S./dn;
        end
        pR = R*S;
        pR = pR - pR.*R;        
        res = test(pR,T);
        disp(res);
    end
    function obj=object()
        t = R-R*S;
        obj = trace_eff(t)/2;
%         disp(obj)
        obj = obj + alpha*sum(sum(Q.*S));
%         disp(obj)
        obj = obj + trace_eff(S)/2*beta;
%         disp(obj)
        t = S'*one - one;
        obj = obj + trace_eff(t)/2*lambda;
    end
end

