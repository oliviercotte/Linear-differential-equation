% function f = eqndiff(t,y)
% 
% % Exemple de membre de droite d'un système d'EDO : f(t,y(t))
% 
% f = zeros(size(y),1);  % on détermine le nombre d'EDO
% 
% % On définit quelques constantes
% 
% % Système d'équations différentielles adimensionnalisé qui modélise la
% % dynamique du satellite
% % Le membre de droite de chaque EDO
% f(1) = 10*(y(1) - t.^2);
% end

% Question 5

% Initialisation des variables importantes
C = 1/50;
epsilon1 = 1e-14;
epsilon2 = 1e-10;
epsilon3 = 1e-8;
nbpas1 = 50;
nbpas2 = 500;
nbpas3 = 5000;
h1 = 0.1;
h2 = 0.01;
h3 = 0.001;
t0 = 0;
y0 = C;

% Résolution de l'équation avec euler explicite et Runge-Kutta ordre 4
[t1,y1] = rk4('eqndiff',t0,y0,h1,nbpas1);
[t2,y2] = rk4('eqndiff',t0,y0,h2,nbpas2);
[t3,y3] = rk4('eqndiff',t0,y0,h3,nbpas3);

analytique1 = t1'.^2 + t1'./5 + 1/50 + (C - 1/50)*exp(10.*t1');
analytique2 = t2'.^2 + t2'./5 + 1/50 + (C - 1/50)*exp(10.*t2');
analytique3 = t3'.^2 + t3'./5 + 1/50 + (C - 1/50)*exp(10.*t3');

erreur_relative_h1 = 100.*(abs(analytique1 - y1)./abs(y1));
erreur_relative_h2 = 100.*(abs(analytique2 - y2)./abs(y2));
erreur_relative_h3 = 100.*(abs(analytique3 - y3)./abs(y3));

% Graphique des erreur relatives par Runge-Kutta
clf reset;
hold on
semilogy(t1, erreur_relative_h1, '-.r');
semilogy(t2, erreur_relative_h2, '-.b');
semilogy(t3, erreur_relative_h3, '-.g');
hold off;

% Solution analytique
%analytique1 = t1.^2 + t1./5 +(1/50)*(C - 1/50).*exp(10*t1);
%analytique2 = t2.^2 + t2./5 +(1/50)*(C - 1/50).*exp(10*t2);
%analytique3 = t3.^2 + t3./5 +(1/50)*(C - 1/50).*exp(10*t3);

t = linspace(0,5,10);
erreur1 = epsilon1.*(exp(10*t)./(t.^2 + t./5 +(1/50)));
erreur2 = epsilon2.*(exp(10*t)./(t.^2 + t./5 +(1/50)));
erreur3 = epsilon3.*(exp(10*t)./(t.^2 + t./5 +(1/50)));
% Graphique des erreur relative
figure
hold on
semilogy(t, erreur1, '-.r');
semilogy(t, erreur2, '-.g');
semilogy(t, erreur3, '-.b');
hold off;
