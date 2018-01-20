% Question 1

function f = eqndiff(t,y)

% Exemple de membre de droite d'un système d'EDO : f(t,y(t))

f = zeros(size(y),1);  % on détermine le nombre d'EDO

% On définit quelques constantes

m = 100000;       
k = 2e-6;

% Le membre de droite de chaque EDO
f(1) =k*y(1)*(m-y(1));
end

% Initialisation des variables importantes
m = 100000; % population totale m
k = 2e-6;
nbpas = 30;
h = 1;
t0 = 0;
y0 = 1000;

% Résolution de l'équation avec euler explicite et Runge-Kutta ordre 4
[t1,y1] = eulerexpl('eqndiff',t0,y0,h,nbpas);
[t2,y2] = rk4('eqndiff',t0,y0,h,nbpas);

% Solution analytique
%t= linspace(0,30, 1000);
constante_1 = 1/1000 - 1/m;
constante_2 = exp(-k*m*t);
sol = constante_1*constante_2 + 1/m;
sol_analytique = 1./(sol);


% Graphique de différentes approximations superposés avec la solution
% analytique
clf reset;
hold on
plot (t1,y1, 'x');    % Euleur explicite
plot (t2,y2, 'o' );   % Runge-Kutta ordre 4  
plot (t,sol_analytique);        % Solution analytique
hold off;

% Calcul de l'erreur absolue
constante_1 = 1/1000 - 1/m;
constante_2 = exp(-k*m*t1);
sol = constante_1*constante_2 + 1/m;
sol_analytique = 1./(sol);

theorique = sol_analytique';
euler_explicite = y1;
runge_kutta_4 = y2;

erreur_absolue_explicite = abs(theorique - euler_explicite);

constante_1 = 1/1000 - 1/m;
constante_2 = exp(-k*m*t2);
sol = constante_1*constante_2 + 1/m;
sol_analytique = 1./(sol);

erreur_absolue_runge_kutta_4 = abs(theorique - runge_kutta_4);
erreur_relative_explicite = (erreur_absolue_explicite./theorique).*100;
erreur_relative_runge_kutta_4 = (erreur_absolue_runge_kutta_4./theorique).*100;

%clf reset;
%hold on
%plot (t1,erreur_relative_explicite, 'x');    % Euleur explicite
%plot (t2,erreur_relative_runge_kutta_4, 'o' );   % Runge-Kutta ordre 4  
%hold off;

% c) Même si euler explicite est plutôt précise, on remarque que
% l'approximation par Runge-Kutta ordre 4 passes beaucoup plus près de la
% courbe théorique que euler-explicite (les deux courbes se confondent).


