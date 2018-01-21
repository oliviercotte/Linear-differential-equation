% Question 3

% Initialisation des variables importantes
mu = 0.012277471;

T = 17.065216560157962559;
h1 = 0.001;           % longueur du pas de temps
nbpas1 = 50;
h2 = 0.001
nbpas2 = 100;

t0 = 0;             
x0 = [0.994, 0];      % conditions initiales pour x
y0 = [0, -2.0015851063790825224];      % conditions initiales pour y

% Résolution de l'équation
[t1,y1] = eulmod('eqndiff',t0,[0.994, 0, 0, -2.0015851063790825224],h1,nbpas1);
[t4,y4] = rk4('eqndiff',t0,[0.994, 0, 0, -2.0015851063790825224],h2,nbpas2);

% Graphique de différentes approximations
clf reset;
hold on
plot(y1(:,3), y1(:,1));
hold off;