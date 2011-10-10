% Définition : la grille est composée de 6 lignes et 7 colonnes. Elle est 
% implémentée comme une liste de 7 listes de 6 éléments chacune. À noter 
% que dans une colonne les cases sont inversées par rapport à la 
% représentation logique : la case « du bas » est la première de la liste. 

% Appel : initialiserGrille.
% 
% Initialise la grille de jeu comme 7 listes contenant 6 éléments positionnés 
% à « vide ». La clause grille doit avoir été définie comme dynamique auparavant. 
initialiserGrille :- 
    retractall(grille(_)),
    assert(grille([[vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide]])).

% Appel : extraireLigne(+Grille, ?NumeroLigne, ?Ligne).
%
% Extrait la ligne NumeroLigne de Grille et unifie le résulat dans Ligne.
% Peut aussi générer la liste des lignes et leur numéro. Voir extraireLigne/4. 
extraireLigne(Grille, NumeroLigne, Ligne) :-
    between(1, 6, NumeroLigne),
    extraireLigne(Grille, NumeroLigne, 1, Ligne).

% Appel : extraireLigne(+Grille, ?NumeroLigne, +Nombre, ?Ligne).
%
% Extrait la ligne NumeroLigne de Grille et unifie le résultat dans Ligne. Nombre 
% retient la ligne en cours de parcours. Ne fonctionne qu'avec des grilles de 7
% colonnes.
extraireLigne(_, NumeroLigne, _, _) :- not(between(1, 6, NumeroLigne)), fail.
extraireLigne([[X1|_], [X2|_], [X3|_], [X4|_], [X5|_], [X6|_], [X7|_]], NumeroLigne, NumeroLigne, [X1, X2, X3, X4, X5, X6, X7]).
extraireLigne([[_|L1], [_|L2], [_|L3], [_|L4], [_|L5], [_|L6], [_|L7]], NumeroLigne, Nombre, [X1, X2, X3, X4, X5, X6, X7]) :- 
    not(NumeroLigne = Nombre),
    NouveauNombre is Nombre + 1,
    extraireLigne([L1, L2, L3, L4, L5, L6, L7], NumeroLigne, NouveauNombre, [X1, X2, X3, X4, X5, X6, X7]).

% Appel : extraireColonne(+Grille, ?NumeroColonne, ?Colonne).
%
% Extrait la colonne NumeroColonne de Grille et unifie le résulat dans Colonne.
% Peut aussi générer la liste des colonnes et leur numéro. Voir extraireLigne/4.
extraireColonne(Grille, NumeroColonne, Colonne) :-
    between(1, 7, NumeroColonne),
    extraireColonne(Grille, NumeroColonne, 1, Colonne).

% Appel : extraireColonne(+Grille, ?NumeroColonne, Nombre, ?Colonne).
%
% Extrait la colonne NumeroColonne de Grille et unifie le résulat dans Colonne.
% Nombre retient la colonne en cours de parcours.
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
	
%Definition des diagonals
%NE(1):  *   NO(2): *
%     /              \
%    /                \
%
%Diagonal de 1 a  6 en sens NE
%Diagonal de 7 a 12 en sens 
%     __ __ __ __ __ __ __
%    |__|__|__|__|__|__|__|
%    |__|__|__|__|__|__|__|
%    |__|__|__|__|__|__|__|
%    |_1|__|__|__|__|__|_7|
%    |_2|__|__|__|__|__|_8|
%    | 3| 4| 5| 6|11|10| 9|
%    |__|__|__|12|__|__|__| 
%     
%

%Appel : extraireDiag(+Grille,+NumDiag,-Diag)
%En fonction de la diagonale, appel la fonction correspondante
%pour extraire la diagonale dans le bon sens.
extraireDiag(Grille,NumDiag,Diag) :- 
	between(1,12,NumDiag),
	extraireDiag(Grille,NumDiag,[],Diag).
%En fonction de la diagonal demandee, appel la fonction extraireDiag-5
%avec les premieres coordonnees de la diagonale.
extraireDiag(Grille, 1, Temp, Diag) :-
	extraireDiag(Grille,1,3,Temp,Diag,1). 
extraireDiag(Grille, 2, Temp, Diag) :-
	extraireDiag(Grille,1,2,Temp,Diag,1). 
extraireDiag(Grille, 3, Temp, Diag) :-
	extraireDiag(Grille,1,1,Temp,Diag,1). 
extraireDiag(Grille, 4, Temp, Diag) :-
	extraireDiag(Grille,2,1,Temp,Diag,1). 
extraireDiag(Grille, 5, Temp, Diag) :-
	extraireDiag(Grille,3,1,Temp,Diag,1). 
extraireDiag(Grille, 6, Temp, Diag) :-
	extraireDiag(Grille,4,1,Temp,Diag,1).
extraireDiag(Grille, 7, Temp, Diag) :-
	extraireDiag(Grille,7,3,Temp,Diag,2). 
extraireDiag(Grille, 8, Temp, Diag) :-
	extraireDiag(Grille,7,2,Temp,Diag,2). 
extraireDiag(Grille, 9, Temp, Diag) :-
	extraireDiag(Grille,7,1,Temp,Diag,2). 
extraireDiag(Grille,10, Temp, Diag) :-
	extraireDiag(Grille,6,1,Temp,Diag,2). 
extraireDiag(Grille,11, Temp, Diag) :-
	extraireDiag(Grille,5,1,Temp,Diag,2). 
extraireDiag(Grille,12, Temp, Diag) :-
	extraireDiag(Grille,4,1,Temp,Diag,2).
%Appel extraireDiag(+Grille, +CoordCol, +CoordLig, +Temp,+Diag).
%Si les coordonees sont dans la grilles, alors extraction de l'element
%puis recherche de l'element suivant de la diagonal et stockage dans Temp.
extraireDiag(Grille,CoordCol,CoordLig,Temp, Diag,Sens) :-
	between(1,7,CoordCol),
	between(1,6,CoordLig),
	extraireElement(Grille,CoordCol, CoordLig, Element),
	append(Temp,[Element],NewDiag),
	calcNewCoord(CoordCol,Sens,NewCoordCol),
	NewCoordLig is CoordLig+1,
	extraireDiag(Grille, NewCoordCol, NewCoordLig, NewDiag, Diag,Sens).
%Si les coordonnees ne sont pas dans la grille, alors retour de diag.
extraireDiag(_, CoordCol,_,Diag, Diag,_) :-
	not(between(1,7,CoordCol)).
extraireDiag(_, _, CoordLig, Diag, Diag,_) :-
	not(between(1,6,CoordLig)).

%Calcul les nouvelles coordonee de la colonne en fonction du sens donne :
%1 = NE, donc NewCoordCol = CoordCol+1
%2 = N0, donc NewCoordCol = CoordCol-1
calcNewCoord(CoordCol,1,NewCoordCol) :-
	NewCoordCol is CoordCol+1.
calcNewCoord(CoordCol,2,NewCoordCol) :-
	NewCoordCol is CoordCol-1.
	