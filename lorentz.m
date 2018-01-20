function f = eqndiff(t,y)

% Exemple de membre de droite d'un système d'EDO : f(t,y(t))

f = zeros(size(y),1);  % on détermine le nombre d'EDO

% On définit quelques constantes
sigma = 10;
r = 28;
b = 2.6666667;

% Système d'équations différentielles adimensionnalisé qui modélise la
% dynamique du satellite
% Le membre de droite de chaque EDO
f(1) = sigma*(y(2) - y(1));
f(2) = r*y(1) - y(2) - y(1)*y(3);
f(3) = y(1)*y(2) - b*y(3);
end

% lorentz

h = 0.01;           % longueur du pas de temps
nbpas = 2000;
t0 = 80;

[t1,y1] = rk4('eqndiff',t0,[-2.4881258, 1.5045223, 26.865757],h,nbpas);
%[t2,y2] = rk4('eqndiff',t0,[-2.4881 1.5045 26.865],h,nbpas);


% Graphique de différentes approximations
%plot(t1,y1(:,1),t2,y2(:,1));
%axis([80 100 -25 45]);
plot3(y1(:,1),y1(:,2),y1(:,3))
xlabel('y1'),ylabel('y2'),zlabel('y3')
axis([-20 20 -30 30 5 45])
