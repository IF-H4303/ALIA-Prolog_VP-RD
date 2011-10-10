% D�finition : la grille est compos�e de 6 lignes et 7 colonnes. Elle est 
% impl�ment�e comme une liste de 7 listes de 6 �l�ments chacune. � noter 
% que dans une colonne les cases sont invers�es par rapport � la 
% repr�sentation logique : la case � du bas � est la premi�re de la liste. 

% Appel : initialiserGrille.
% 
% Initialise la grille de jeu comme 7 listes contenant 6 �l�ments positionn�s 
% � � vide �. La clause grille doit avoir �t� d�finie comme dynamique auparavant. 
initialiserGrille :- 
    retractall(grille(_)),
    assert(grille([[vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide], [vide, vide, vide, vide, vide, vide]])).

% Appel : extraireLigne(+Grille, ?NumeroLigne, ?Ligne).
%
% Extrait la ligne NumeroLigne de Grille et unifie le r�sulat dans Ligne.
% Peut aussi g�n�rer la liste des lignes et leur num�ro. Voir extraireLigne/4. 
extraireLigne(Grille, NumeroLigne, Ligne) :-
    between(1, 6, NumeroLigne),
    extraireLigne(Grille, NumeroLigne, 1, Ligne).

% Appel : extraireLigne(+Grille, ?NumeroLigne, +Nombre, ?Ligne).
%
% Extrait la ligne NumeroLigne de Grille et unifie le r�sultat dans Ligne. Nombre 
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
% Extrait la colonne NumeroColonne de Grille et unifie le r�sulat dans Colonne.
% Peut aussi g�n�rer la liste des colonnes et leur num�ro. Voir extraireLigne/4.
extraireColonne(Grille, NumeroColonne, Colonne) :-
    between(1, 7, NumeroColonne),
    extraireColonne(Grille, NumeroColonne, 1, Colonne).

% Appel : extraireColonne(+Grille, ?NumeroColonne, Nombre, ?Colonne).
%
% Extrait la colonne NumeroColonne de Grille et unifie le r�sulat dans Colonne.
% Nombre retient la colonne en cours de parcours.
extraireColonne(_, NumeroColonne, _, _) :- not(between(1, 7, NumeroColonne)), fail.
extraireColonne([Colonne|_], NumeroColonne, Nombre, Colonne) :- NumeroColonne = Nombre.
extraireColonne([_|L], NumeroColonne, Nombre, Colonne) :- 
    not(NumeroColonne = Nombre),
    NouveauNombre is Nombre + 1,
    extraireColonne(L, NumeroColonne, NouveauNombre, Colonne).

% Appel : extraireElement(+Grille, +CoordCol, +CoordLig, -Colonne).
% Extrait l'element de coordonn�e (CoordCol,CoordLig) et place le re�sulat dans Colonne.
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
