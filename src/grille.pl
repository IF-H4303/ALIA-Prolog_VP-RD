% Grille : 6 lignes et 7 colonnes

% Initialise la grille de jeu.
% Au départ, il s'agit 7 listes de 6 variables libres quelconques.
% Avant d'appeler initialiser, lancer dans l'interpréteur : dynamic grille/1.
initialiser :- 
    retractall(grille(_)),
    assert(grille([[vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide]])).

% Appel : extraireLigne(+Grille, +NumeroLigne, -Ligne).
% Extrait la ligne NumeroLigne de Grille et stocke le résulat dans Ligne.
extraireLigne(Grille, NumeroLigne, Resultat) :- between(1, 6, NumeroLigne), extraireLigne(Grille, NumeroLigne, 1, Resultat).
extraireLigne(_, NumeroLigne, _, _) :- not(between(1, 6, NumeroLigne)), fail.
extraireLigne([[X1|_], [X2|_], [X3|_], [X4|_], [X5|_], [X6|_], [X7|_]], NumeroLigne, NumeroLigne, [X1, X2, X3, X4, X5, X6, X7]).
extraireLigne([[_|L1], [_|L2], [_|L3], [_|L4], [_|L5], [_|L6], [_|L7]], NumeroLigne, Nombre, [X1, X2, X3, X4, X5, X6, X7]) :- 
    not(NumeroLigne = Nombre),
    NouveauNombre is Nombre + 1,
    extraireLigne([L1, L2, L3, L4, L5, L6, L7], NumeroLigne, NouveauNombre, [X1, X2, X3, X4, X5, X6, X7]).

% Appel : extraireColonne(+Grille, +NumeroColonne, -Colonne).
% Extrait la colonne NumeroColonne de Grille et stocke le résulat dans Colonne.
extraireColonne(Grille, NumeroColonne, Colonne) :- between(1, 7, NumeroColonne), extraireColonne(Grille, NumeroColonne, 1, Colonne).
extraireColonne(_, NumeroColonne, _, _) :- not(between(1, 7, NumeroColonne)), fail.
extraireColonne([Colonne|_], NumeroColonne, Nombre, Colonne) :- NumeroColonne = Nombre.
extraireColonne([_|L], NumeroColonne, Nombre, Colonne) :- 
    not(NumeroColonne = Nombre),
    NouveauNombre is Nombre + 1,
    extraireColonne(L, NumeroColonne, NouveauNombre, Colonne).

%Appel : extraireElement(+Grille, +CoordCom, +CoordLig, -Colonne).
%Extrait l'element de coordonnees (CoordCol, CoordLig) et place le resultat dans Colocnne.
extraireElement(Grille, CoordCol, CoordLig, Element) :- 
	extraireColonne(Grille, CoordCol, Colonne),
	extraireElementCol(Colonne, CoordLig, Element).

%Appel : extraireElementCol(+Colonne, +NumeroElement, -Element).
%Extrait l'element numero NumeroElement dans la liste Colonne et place le resultat dans Element.
extraireElementCol(Colonne, NumeroElement, Element) :- 
	between(1,6,NumeroElement),
	extraireElementCol(Colonne, NumeroElement, 1, Element).
extraireElementCol([Element|_], NumeroElement, Compt, Element) :- 
	NumeroElement = Compt.
extraireElementCol([_|Tail], NumeroElement, Compt, Element) :-
	not(NumeroElement = Compt),
	NewCompt is Compt+1,
	extraireElementCol(Tail,NumeroElement, NewCompt, Element).
	
%Definission des diagonals
extraireDiag(Grille,NumDiag,Diag) :- 
	between(1,6,NumDiag),
	not(between(7,12,NumDiag)),
	NumDiag < 6,
	extraireDiagNE(Grille,NumDiag,[],Diag).
extraireDiag(Grille,NumDiag,Diag) :- 
	between(7,12,NumDiag),
	not(between(1,6,NumDiag)),
	extraireDiagNO(Grille,NumDiag,[],Diag).


extraireDiagNE(Grille, 1, Temp, Diag) :-
	extraireDiagNE(Grille,1,3,Temp,Diag). 
extraireDiagNE(Grille, 2, Temp, Diag) :-
	extraireDiagNE(Grille,1,2,Temp,Diag). 
extraireDiagNE(Grille, 3, Temp, Diag) :-
	extraireDiagNE(Grille,1,1,Temp,Diag). 
extraireDiagNE(Grille, 4, Temp, Diag) :-
	extraireDiagNE(Grille,2,1,Temp,Diag). 
extraireDiagNE(Grille, 5, Temp, Diag) :-
	extraireDiagNE(Grille,3,1,Temp,Diag). 
extraireDiagNE(Grille, 6, Temp, Diag) :-
	extraireDiagNE(Grille,4,1,Temp,Diag).
extraireDiagNE(Grille,CoordCol,CoordLig,Temp, Diag) :-
	between(1,7,CoordCol),
	between(1,6,CoordLig),
	extraireElement(Grille,CoordCol, CoordLig, Element),
	append(Temp,[Element],NewDiag),
	NewCoordCol is CoordCol+1,
	NewCoordLig is CoordLig+1,
	extraireDiagNE(Grille, NewCoordCol, NewCoordLig, NewDiag, Diag),
	append(Temp,[],Diag).
extraireDiagNE(_, CoordCol,_,Diag, Diag) :-
	not(between(1,7,CoordCol)).
extraireDiagNE(_, _, CoordLig, Diag, Diag) :-
	not(between(1,6,CoordLig)).

extraireDiagNO(Grille, 7, Temp, Diag) :-
	extraireDiagNO(Grille,7,3,Temp,Diag). 
extraireDiagNO(Grille, 8, Temp, Diag) :-
	extraireDiagNO(Grille,7,2,Temp,Diag). 
extraireDiagNO(Grille, 9, Temp, Diag) :-
	extraireDiagNO(Grille,7,1,Temp,Diag). 
extraireDiagNO(Grille,10, Temp, Diag) :-
	extraireDiagNO(Grille,6,1,Temp,Diag). 
extraireDiagNO(Grille,11, Temp, Diag) :-
	extraireDiagNO(Grille,5,1,Temp,Diag). 
extraireDiagNO(Grille,12, Temp, Diag) :-
	extraireDiagNO(Grille,4,1,Temp,Diag).
extraireDiagNO(Grille,CoordCol,CoordLig,Temp, Diag) :-
	between(1,7,CoordCol),
	between(1,6,CoordLig),
	extraireElement(Grille,CoordCol, CoordLig, Element),
	append(Diag,Element,NewDiag),
	NewCoordCol is CoordCol-1,
	NewCoordLig is CoordLig+1,
	extraireDiagNO(Grille, NewCoordCol, NewCoordLig, NewDiag,Diag),
	append(Temp,[],Diag).
extraireDiagNO(_,CoordCol,_,Temp,Temp) :-
	not(between(1,7,CoordCol)).
extraireDiagNO(_,_,CoordLig,Temp,Temp) :-
	not(between(1,6,CoordLig)).
	