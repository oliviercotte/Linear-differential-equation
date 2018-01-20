function [ res ] = coefficient( degre, x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
coeff = zeros(degre/2, 1);
for n=0:1:degre/2
    % coeff ai
    coeff(n+1) = factorial(2*n+1)/((2*n+3)*(2*n+5)*((factorial(n))^2)*(2^(2*n-2)));
end

if (degre/2 == 0)
    pn = 4/15;
else
    pn= coeff(degre/2);
end

for k=degre/2:-1:1
    pn = pn*x + coeff(k);
end
res = pn;
end

