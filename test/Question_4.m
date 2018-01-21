% function f = eqndiff(t,y)
% 
% % Exemple de membre de droite d'un syst�me d'EDO : f(t,y(t))
% 
% f = zeros(size(y),1);  % on d�termine le nombre d'EDO
% 
% % On d�finit quelques constantes
% 
% % Syst�me d'�quations diff�rentielles adimensionnalis� qui mod�lise la
% % dynamique du satellite
% % Le membre de droite de chaque EDO
% f(1) = -7*y(1);
% end

% Question 4

% Initialisation des variables importantes

nbpas1 = 4;
nbpas2 = 8;
h1 = 0.5;
h2 = 0.25;
t0 = 0;
y0 = 5;

% R�solution de l'�quation
[t1,y1] = eulerexpl('eqndiff',t0,y0,h1,nbpas1);
[t2,y2] = eulerexpl('eqndiff',t0,y0,h2,nbpas2);
[t3,y3] = eulerexpl('eqndiff',t0,y0,h2,nbpas2);

%Euler-implicite
y4 = zeros(nbpas1,1);  % on d�termine le nombre d'EDO
y5 = zeros(nbpas2,1);  % on d�termine le nombre d'EDO

y4(1,1) = 5;
for ii=1:1:nbpas1
    y4(ii+1,1) = y4(ii,1)./(1+7*h1);
end

y5(1,1) = 5;
for ii=1:1:nbpas2
    y5(ii+1,1) = y5(ii,1)./(1+7*h2);
end

% Graphique de diff�rentes approximations (Euler-implicite)
clf reset;
hold on
plot(t1, y4(:,1), '-.o');
plot(t2, y5(:,1), '-.x');
hold off;


% Graphique de diff�rentes approximations (Euler implicite)
figure
hold on
plot(t1, y1, '-.o');
plot(t2, y2, '-.x');
hold off;


