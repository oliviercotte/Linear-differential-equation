function f = eqndiff(t,y)

% Exemple de membre de droite d'un syst�me d'EDO : f(t,y(t))

f = zeros(size(y),1);  % on d�termine le nombre d'EDO

% On d�finit quelques constantes
sigma = 10;
r = 28;
b = 2.6666667;

% Syst�me d'�quations diff�rentielles adimensionnalis� qui mod�lise la
% dynamique du satellite
% Le membre de droite de chaque EDO
f(1) = sigma*(y(2) - y(1));
f(2) = r*y(1) - y(2) - y(1)*y(3);
f(3) = y(1)*y(2) - b*y(3);
end