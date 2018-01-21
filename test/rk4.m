function [t,y] = rk4(f,t0,y0,h,nbpas)
%
%  Méthode de Runge-Kutta d'ordre 4 pour les systèmes d'équations
%    différentielles de la forme y'(t) = f(t,y(t)) {SD}
%
%  Préalable:
%  Vous devez creer un fichier .m contenant la fonction f(t,y).
%  Voir par exemple le fichier eqndiff.m
%
%  Exemples d'appel:
%  [t,y] = rk4('eqndiff',0.0,[1 1],1.0e-1,10)
%
%  Arguments en entrée:
%  1) f: Le nom entre apostrophes (' ') du fichier .m contenant la fonction
%     f(t,y).
%  2) t0: le temps initial
%  3) y0: la(les) condition(s) initiale(s), sous la forme d'un vecteur ligne:
%         par exemple, [1 2]. La dimension de y0 donne la dimension du système
%  4) h: le pas de temps
%  5) nbpas: le nombre maximal de pas de temps
%
%  Arguments en sortie:
%  1) t est un vecteur contenant les temps, ti
%  2) y est une matrice contenant la solution obtenue:
%     la colonne i de y correspond a la solution de l'équation i

% on fait quelques calculs préliminaires

nbeq = size(y0,2);
y0 = y0';
k1 = zeros(nbeq,1);
k2 = zeros(nbeq,1);
k3 = zeros(nbeq,1);
k4 = zeros(nbeq,1);
y = zeros(1,nbeq);

n = 1;
t(1) = t0;
y(1,:) = y0';
warning off

% la boucle transitoire

while(n <= nbpas),

  k1 = h * feval(f,t(n),y0);
  k2 = h * feval(f,t(n)+h/2,y0+k1/2);
  k3 = h * feval(f,t(n)+h/2,y0+k2/2);
  k4 = h * feval(f,t(n)+h,y0+k3);

  if (any(~isfinite(k1)))|(any(~isfinite(k2)))|(any(~isfinite(k3)))|(any(~isfinite(k4))),
    disp('la fonction n''est pas definie en certains points');
    return;
  end

  y0 = y0 + (1/6) * (k1+2*(k2+k3) + k4);
  y(n+1,:) = y0';
  t(n+1) = t(n) + h;
  n = n+1;

end
