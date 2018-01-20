% Initialisation des variables importantes
nbpas1 = 4;
nbpas2 = 8;
h1 = 0.5;
h2 = 0.25;
t0 = 0;
y0 = 5;

% Résolution de l'équation avec euler explicite et Runge-Kutta ordre 4
[t1,y1] = eulerexpl('eqndiff',t0,y0,h1,nbpas1);
[t2,y2] = eulerexpl('eqndiff',t0,y0,h2,nbpas2);
function f = eqndiff(t,y)

% Exemple de membre de droite d'un système d'EDO : f(t,y(t))

f = zeros(size(y),1);  % on détermine le nombre d'EDO

% On définit quelques constantes
lambda = -7;
% Le membre de droite de chaque EDO
f(1) = lambda*y(1);

% Solution analytique
analytique = 5*exp(-7*t2)';

% Graphique de différentes approximations superposés avec la solution
% analytique
clf reset;
hold on
plot (t1,y1, 'x');     % Euleur explicite
plot (t2,y2, 'o' );    % Euleur explicite
%plot (t,y3, '-ro');     % Euler Modifie (Runge-Kutta ordre 2)
plot (t,analytique, '-.b' );    % Runge-Kutta ordre 4  
hold off;
euler_explicite = zeros(1,nbpas1);
euler_explicite(1) = 5;
for n=1:1:nbpas
    euler_explicite(n+1) = euler_explicite(n)/(1+7*h2);
end
absolue = abs(analytique - euler_explicite');