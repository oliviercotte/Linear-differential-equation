function [t,y] = ptmilieu(f,t0,y0,h,nbpas)
%
%  Méthode du point milieu (Runge-Kutta d'ordre 2) pour les systèmes
%    d'équations différentielles de la forme y'(t) = f(t,y(t)) {SD}
%
%  Préalable:
%  Vous devez creer un fichier .m contenant la fonction f(t,y).
%  Voir par exemple le fichier eqndiff.m
%
%  Exemples d'appel:
%  [t,y] = ptmilieu('eqndiff',0.0,[1 1],1.0e-1,10)
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
fyn = zeros(nbeq,1);
y = zeros(1,nbeq);
n = 1;
t(1) = t0;
y(1,:) = y0';
warning off

% la boucle transitoire

while(n <= nbpas),

  k1 = h*feval(f,t(n),y0);
  if (any(~isfinite(k1))),
    disp('la fonction n''est pas definie en certains points');
    return;
  end

  fyn = feval(f,t(n)+h/2,y0+k1/2);
  if (any(~isfinite(fyn))),
    disp('la fonction n''est pas definie en certains points');
    return;
  end

  y0 = y0 + h*fyn;
  t(n+1) = t(n) + h;
  y(n+1,:) = y0';
  n = n+1;

end
