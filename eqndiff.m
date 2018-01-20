function f = eqndiff(t,y)

% Exemple de membre de droite d'un système d'EDO : f(t,y(t))

f = zeros(size(y),1);  % on détermine le nombre d'EDO

% On définit quelques constantes
mu = 0.012277471;

% Système d'équations différentielles adimensionnalisé qui modélise la
% dynamique du satellite
% Le membre de droite de chaque EDO
f(1) = y(2);
f(2) = y(1)+2*y(4)-(1-mu)*((y(1)+mu)/sqrt((y(1)+mu)^2 + y(3)^2 )^3) - mu*((y(1)-1+mu)/sqrt((y(1)-1+mu)^2 + y(3)^2 )^3);
f(3) = y(4);
f(4) = y(3)+2*y(2)-(1-mu)*(y(3)/sqrt((y(1)+mu)^2 + y(3)^2 )^3) - mu*(y(3)/sqrt((y(1)-1+mu)^2 + y(3)^2 )^3);
end