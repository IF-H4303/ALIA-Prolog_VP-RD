% Grille : 6 lignes et 7 colonnes

% Initialise la grille de jeu.
% Au départ, il s'agit 7 listes de 6 variables libres quelconques.
% Avant d'appeler initialiser, lancer dans l'interpréteur : dynamic grille/1.
initialiser :- 
    retractall(grille(_)),
    assert(grille([[_, _, _, _, _, _], [_, _, _, _, _, _], [_, _, _, _, _, _], [_, _, _, _, _, _], [_, _, _, _, _, _], [_, _, _, _, _, _], [_, _, _, _, _, _]])).

% Appel : extraireLigne(+Grille, +NumeroLigne, -Ligne).
% Extrait la ligne NumeroLigne de Grille et stocke le résulat dans Ligne.
extraireLigne(Grille, NumeroLigne, Resultat) :- extraireLigne(Grille, NumeroLigne, 1, Resultat).
extraireLigne(_, NumeroLigne, _) :- NumeroLigne < 0, fail.
extraireLigne(_, NumeroLigne, _) :- NumeroLigne = 0, fail.
extraireLigne(_, NumeroLigne, _) :- NumeroLigne > 6, fail.
extraireLigne([[X1|_], [X2|_], [X3|_], [X4|_], [X5|_], [X6|_]], NumeroLigne, Nombre, [X1, X2, X3, X4, X5, X6]) :- NumeroLigne = Nombre.
extraireLigne([[_|L1], [_|L2], [_|L3], [_|L4], [_|L5], [_|L6]], NumeroLigne, Nombre, [X1, X2, X3, X4, X5, X6]) :- 
    not(NumeroLigne = Nombre),
    NouveauNombre is Nombre + 1,
    extraireLigne([L1, L2, L3, L4, L5, L6], NumeroLigne, NouveauNombre, [X1, X2, X3, X4, X5, X6]).

% Appel : extraireColonne(+Grille, +NumeroColonne, -Colonne).
% Extrait la colonne NumeroColonne de Grille et stocke le résulat dans Colonne.
extraireColonne(Grille, NumeroColonne, Colonne) :- extraireColonne(Grille, NumeroColonne, 1, Colonne).
extraireColonne(_, NumeroColonne, _) :- NumeroColonne < 0, fail.
extraireColonne(_, NumeroColonne, _) :- NumeroColonne = 0, fail.
extraireColonne(_, NumeroColonne, _) :- NumeroColonne > 7, fail.
extraireColonne([Colonne|_], NumeroColonne, Nombre, Colonne) :- NumeroColonne = Nombre.
extraireColonne([_|L], NumeroColonne, Nombre, Colonne) :- 
    not(NumeroColonne = Nombre),
    NouveauNombre is Nombre + 1,
    extraireColonne(L, NumeroColonne, NouveauNombre, Colonne).

% Appel : extraireElement(+Grille, +CoordCol, +CoordLig, -Colonne).
% Extrait l'element de coordonnÈe (CoordCol,CoordLig) et place le reésulat dans Colonne.
    extraireElement(Grille, CoordCol, CoordLig, Element) :- 
	extraireColonne(Grille, CoordCol, Colonne),
	extraireElementCol(Colonne, CoordLig, Element).

%Appel : extraireElementCol(+Colonne, +NumeroElement, -Element).
%Extrait l'element numero NumeroElement dans la liste Colonne et place le resultat dans Element.
extraireElementCol(Colonne, NumeroElement, Element) :- extraireElementCol(Colonne, NumeroElement, 1, Element).
extraireElementCol(_,NumeroElement,_) :- NumeroElement < 0, fail.
extraireElementCol(_,NumeroElement,_) :- NumeroElement = 0, fail.
extraireElementCol(_,NumeroElement,_) :- NumeroElement > 6, fail.
extraireElementCol([Element|_], NumeroElement, Compt, Element) :- NumeroElement = Compt.
extraireElementCol([_|Tail], NumeroElement, Compt, Element) :-
	not(NumeroElement = Compt),
	NewCompt is Compt+1,
	extraireElementCol(Tail,NumeroElement, NewCompt, Element).
	
