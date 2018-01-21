% function f = eqndiff(t,y)
% 
% % Exemple de membre de droite d'un système d'EDO : f(t,y(t))
% 
% f = zeros(size(y),1);  % on détermine le nombre d'EDO
% 
% % On définit quelques constantes
% 
% k = 0.83e-6;        % coéfficient de friction
% g = 32.17;          % accélération gravitaionelle
% m = 0.001781163;    % population totale m
% 
% % Le membre de droite de chaque EDO
% f(1) = y(2);
% f(2) = (-k.*abs(y(1)).*y(1) - m.*g)./m;
% end

% Question 2

% Initialisation des variables importantes
% k = 0.83e-6;        % coéfficient de friction
g = 32.17;          % accélération gravitaionelle
m = 0.001781163;    % masse de la flèche
nbpas = 45;
h = 0.15;           % longueur du pas de temps
t0 = 0;             
y0 = [0, 200];      % conditions initiales

% Résolution de l'équation avec euler explicite et Runge-Kutta ordre 4
[t1,y1] = eulerexpl('eqndiff',t0,y0,h,nbpas);
[t2,y2] = ptmilieu('eqndiff',t0,y0,h,nbpas);
[t3,y3] = eulmod('eqndiff',t0,y0,h,nbpas);
[t4,y4] = rk4('eqndiff',t0,y0,h,nbpas);

% Graphique de différentes approximations superposés avec la solution
% analytique
clf reset;
hold on
plot (t1,y1(:,1), 'x');     % Euleur explicite
plot (t2,y2(:,1), 'o' );   % Point milieu (Runge-Kutta ordre 2)
plot (t3,y3(:,1), '-ro');  % Euler Modifie (Runge-Kutta ordre 2)
plot (t4,y4(:,1), '-.b' );  % Runge-Kutta ordre 4  
hold off;

% Hauteur maximale atteinte par la flèche
HAUTEUR_MAX_EULER_EXPLICITE = y1(1,1);
HAUTEUR_MAX_EULER_MODIFIE = y2(1,1);
HAUTEUR_MAX_POINT_MILIEU = y3(1,1);
HAUTEUR_MAX_RUNGE_KUTTA_4 = y4(1,1);
for n=1:1:30
    if y1(n+1,1) > HAUTEUR_MAX_EULER_EXPLICITE % HAUTEUR_MAX_EULER_EXPLICITE
        HAUTEUR_MAX_EULER_EXPLICITE = y1(n+1,1);
        ELEMENT_EULER_EXPLICITE = n+1;
    end
    
    if y2(n+1,1) > HAUTEUR_MAX_EULER_MODIFIE % HAUTEUR_MAX_EULER_MODIFIE
        HAUTEUR_MAX_EULER_MODIFIE = y2(n+1,1);
        ELEMENT_EULER_MODIFIE = n+1;
    end
    
    if y3(n+1,1) > HAUTEUR_MAX_POINT_MILIEU % HAUTEUR_MAX_POINT_MILIEU
        HAUTEUR_MAX_POINT_MILIEU = y3(n+1,1);
        ELEMENT_POINT_MILIEU = n+1;
    end
    
    if y4(n+1,1) > HAUTEUR_MAX_RUNGE_KUTTA_4 % HAUTEUR_MAX_RUNGE_KUTTA
        HAUTEUR_MAX_RUNGE_KUTTA_4 = y4(n+1,1);
        ELEMENT_RUNGE_KUTTA_4 = n+1;
    end
end 

% Temps correspondant à la hauteur maximale atteinte par la flèche
TEMPS_HAUTEUR_MAX_EXPLICITE = t0;
TEMPS_HAUTEUR_MAX_MODIFIE = t0;
TEMPS_HAUTEUR_MAX_MILIEU = t0;
TEMPS_HAUTEUR_MAX_KUTTA_4 = t0;
for ii=1:1:ELEMENT_EULER_EXPLICITE - 1
    TEMPS_HAUTEUR_MAX_EXPLICITE = TEMPS_HAUTEUR_MAX_EXPLICITE + 0.15;
end
for ii=1:1:ELEMENT_EULER_MODIFIE - 1
    TEMPS_HAUTEUR_MAX_MODIFIE = TEMPS_HAUTEUR_MAX_MODIFIE + 0.15;
end
for ii=1:1:ELEMENT_POINT_MILIEU - 1
    TEMPS_HAUTEUR_MAX_MODIFIE = TEMPS_HAUTEUR_MAX_MODIFIE + 0.15;
end
for ii=1:1:ELEMENT_RUNGE_KUTTA_4 - 1
    TEMPS_HAUTEUR_MAX_KUTTA_4 = TEMPS_HAUTEUR_MAX_KUTTA_4 + 0.15;
end

SEUIL = 10;
POSITION_EXPLICITE = 2;
POSITION_MODIFIE = 2;
POSITION_MILIEU = 2;
POSITION_KUTTA_4 = 2;
for jj=2:1:nbpas
   if y1(POSITION_EXPLICITE, 1) > SEUIL % HAUTEUR_MAX_EULER_EXPLICITE
        POSITION_EXPLICITE = POSITION_EXPLICITE + 1;
    end
    
    if y2(POSITION_MODIFIE, 1) > SEUIL % HAUTEUR_MAX_EULER_MODIFIE
        POSITION_MODIFIE = POSITION_MODIFIE + 1;
    end
    
    if y3(POSITION_MILIEU, 1) > SEUIL % HAUTEUR_MAX_POINT_MILIEU
        POSITION_MILIEU = POSITION_MILIEU + 1;
    end
    
    if y4(POSITION_KUTTA_4, 1) > SEUIL % HAUTEUR_MAX_RUNGE_KUTTA
        POSITION_KUTTA_4 = POSITION_KUTTA_4 + 1;
    end
end

VITESSE_EXPLICITE = y1(POSITION_EXPLICITE,2);
VITESSE_MODIFIE = y2(POSITION_MODIFIE,2);
VITESSE_MILIEU = y3(POSITION_MILIEU,2);
VITESSE_KUTTA_4 = y4(POSITION_KUTTA_4,2);

clf reset;
hold on
plot (t1,y1(:,2), 'x');       % Euleur explicite
plot (t2,y2(:,2), 'o' );      % Point milieu (Runge-Kutta ordre 2)
plot (t3,y3(:,2), '-ro');     % Euler Modifie (Runge-Kutta ordre 2)
plot (t4,y4(:,2), '-.b' );    % Runge-Kutta ordre 4  
hold off;

ACCELERATION_EXPLICITE = (-k.*abs(y1(POSITION_EXPLICITE,2)).*y1(POSITION_EXPLICITE,2) - m.*g)./m;
ACCELERATION_MODIFIE = (-k.*abs(y2(POSITION_MODIFIE,2)).*y2(POSITION_MODIFIE,2) - m.*g)./m;
ACCELERATION_MILIEU = (-k.*abs(y3(POSITION_MILIEU,2)).*y3(POSITION_MILIEU,2) - m.*g)./m;
ACCELERATION_KUTTA_4 = (-k.*abs(y4(POSITION_KUTTA_4,2)).*y4(POSITION_KUTTA_4,2) - m.*g)./m;

clf reset;
hold on
plot (t1,(-k.*abs(y1(:,2)).*y1(:,2) - m.*g)./m, 'x');       % Euleur explicite
plot (t2,(-k.*abs(y2(:,2)).*y2(:,2) - m.*g)./m, 'o' );      % Point milieu (Runge-Kutta ordre 2)
plot (t3,(-k.*abs(y3(:,2)).*y3(:,2) - m.*g)./m, '-ro');     % Euler Modifie (Runge-Kutta ordre 2)
plot (t4,(-k.*abs(y4(:,2)).*y4(:,2) - m.*g)./m, '-.b' );    % Runge-Kutta ordre 4  
hold off;

