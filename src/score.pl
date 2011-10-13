%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Projet Prolog - 4IF               %
%                                                %
% Ce fichier contient toutes les fonctions liées %
% au calcul du score d'un joueur ainsi qu'à la   %
% détermination d'un état de victoire (ou non).  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Appel : evaluer(+Grille, -Score).
%
% Calcule la valeur de la Grille et unifie le résultat dans Score.
% Un score est compris en -5000 et +5000. Plus le score est élevé plus 
% la configuration de la grille est favorable au joueur jouant les 
% « x » (le joueur ordinateur).
evaluer(Grille, 5000) :- victoireJoueur(x, Grille), !.
evaluer(Grille, -5000) :- victoireJoueur(o, Grille), !.
evaluer(Grille, Valeur) :-
    score(x, Grille, ScoreX),
    score(o, Grille, ScoreO),
    Valeur is ScoreX - ScoreO, !.

% Appel : score(+Joueur, +Grille, -Score).
%
% Calcule le score d'un Joueur sur la Grille et unifie le 
% résultat dans Score. Le score est calculé à partir des 
% alignements trouvés sur les lignes, les colonnes et les 
% diagonales.
% Note : cet algorithme possède une faiblesse identifiée : 
% les pions solitaires (ne formant aucun alignement) sont 
% comptés trois fois (ligne, colonne et diagonale). C'est 
% compensé par le poids beaucoup plus important accordé 
% aux alignements de deux, trois et quatre pions dans le 
% calcul du score.
score(Joueur, Grille, Score) :-
    scoreLignes(Joueur, Grille, ScoreLignes),
    scoreColonnes(Joueur, Grille, ScoreColonnes),
    scoreDiagonales(Joueur, Grille, ScoreDiags),
    Score is ScoreLignes + ScoreColonnes + ScoreDiags, !.

% Appel : scoreLignes(+Joueur, +Grille, -Score).
%
% Calcule le score d'un Joueur sur la Grille en ne prenant 
% en compte que les alignements présents sur des lignes. Le 
% résultat est unifié dans Score.
scoreLignes(Joueur, Grille, Score) :-
    findall(Ligne, extraireLigne(Grille, _, Ligne), Lignes),
    scoreAlignement(Joueur, Lignes, 0, Score).

% Appel : scoreColonnes(+Joueur, +Grille, -Score).
%
% Calcule le score d'un Joueur sur la Grille en ne prenant 
% en compte que les alignements présents sur des colonnes. Le 
% résultat est unifié dans Score.
scoreColonnes(Joueur, Grille, Score) :-
    findall(Colonne, extraireColonne(Grille, _, Colonne), Colonnes),
    scoreAlignement(Joueur, Colonnes, 0, Score).

% Appel : scoreDiagonales(+Joueur, +Grille, -Score).
%
% Calcule le score d'un Joueur sur la Grille en ne prenant 
% en compte que les alignements présents sur des diagonales. Le 
% résultat est unifié dans Score.
scoreDiagonales(Joueur, Grille, Score) :-
    findall(Diag, extraireDiag(Grille, _, Diag), Diags),
    scoreAlignement(Joueur, Diags, 0, Score).

% Appel : scoreAlignement(+Joueur, +Colonnes, +ScoreCourant, -Score).
%
% Calcule le score d'un Joueur sur une liste de Colonnes. Le score vaut 
% la somme est scores individuels de chaque colonne. Voir scoreAlignement/3.
scoreAlignement(Joueur, [X|L], ScoreCourant, Score) :-
    scoreAlignement(Joueur, X, ScoreAlignement),
    NouveauScoreCourant is ScoreCourant + ScoreAlignement,
    scoreAlignement(Joueur, L, NouveauScoreCourant, Score).
scoreAlignement(_, [], ScoreCourant, ScoreCourant).  

% Appel : scoreAlignement(+Joueur, +Colonne, -Score).
%
% Calcule le score d'un Joueur sur une Colonne. Un pion isolé vaut 1, 
% deux pions consécutifs 10, trois pions consécutifs 100 et quatre 
% pions consécutifs 500. Voir alignement/3.
scoreAlignement(Joueur, Colonne, 500) :- alignement(Joueur, Colonne, Max), Max > 3, !.
scoreAlignement(Joueur, Colonne, 100) :- alignement(Joueur, Colonne, 3), !.
scoreAlignement(Joueur, Colonne, 10) :- alignement(Joueur, Colonne, 2), !.
scoreAlignement(Joueur, Colonne, 1) :- alignement(Joueur, Colonne, 1), !.
scoreAlignement(Joueur, Colonne, 0) :- alignement(Joueur, Colonne, 0), !.

% Appel : alignement(+Joueur, Colonne, +Max).
%
% Trouve la plus grande suite de pions d'un Joueur sur une Colonne
% et unifie ce résultat dans Max. 
alignement(Joueur, Colonne, Max) :- alignement(Joueur, 0, Colonne, -1, Max). 
alignement(Joueur, Nombre, [X|L], MaxCourant, MaxResultat) :-
    Joueur == X,
    NouveauNombre is Nombre + 1,
    alignement(Joueur, NouveauNombre, L, MaxCourant, MaxResultat).
alignement(Joueur, Nombre, [X|L], MaxCourant, MaxResultat) :-
    not(Joueur == X),
    Nombre > MaxCourant,
    alignement(Joueur, 0, L, Nombre, MaxResultat).
alignement(Joueur, Nombre, [X|L], MaxCourant, MaxResultat) :-
    not(Joueur == X),
    Nombre < MaxCourant + 1,
    alignement(Joueur, 0, L, MaxCourant, MaxResultat).
alignement(_, Nombre, [], MaxCourant, Nombre) :- Nombre > MaxCourant, !. 
alignement(_, _, [], MaxCourant, MaxCourant) :- MaxCourant > -1, !.


% Appel : victoireJoueurColonne(+Joueur, +Colonne).
%
% Une preuve existe si une suite de 4 symboles consécutifs de Joueur 
% est trouvée dans Colonne.
victoireJoueurColonne(Joueur, Colonne) :- alignement(Joueur, Colonne, Max), Max > 3.

% Appel : victoireJoueur(+Joueur, +Grille).
%
% Une preuve existe si le Joueur a gagné sur la Grille.
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 1, Colonne), victoireJoueurColonne(Joueur, Colonne), !.
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 2, Colonne), victoireJoueurColonne(Joueur, Colonne), !.
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 3, Colonne), victoireJoueurColonne(Joueur, Colonne), !.
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 4, Colonne), victoireJoueurColonne(Joueur, Colonne), !.
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 5, Colonne), victoireJoueurColonne(Joueur, Colonne), !.
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 6, Colonne), victoireJoueurColonne(Joueur, Colonne), !.
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 7, Colonne), victoireJoueurColonne(Joueur, Colonne), !.
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 1, Ligne), victoireJoueurColonne(Joueur, Ligne), !.
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 2, Ligne), victoireJoueurColonne(Joueur, Ligne), !.
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 3, Ligne), victoireJoueurColonne(Joueur, Ligne), !.
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 4, Ligne), victoireJoueurColonne(Joueur, Ligne), !.
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 5, Ligne), victoireJoueurColonne(Joueur, Ligne), !.
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 6, Ligne), victoireJoueurColonne(Joueur, Ligne), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 1, Diag), victoireJoueurColonne(Joueur, Diag), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 2, Diag), victoireJoueurColonne(Joueur, Diag), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 3, Diag), victoireJoueurColonne(Joueur, Diag), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 4, Diag), victoireJoueurColonne(Joueur, Diag), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 5, Diag), victoireJoueurColonne(Joueur, Diag), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 6, Diag), victoireJoueurColonne(Joueur, Diag), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 7, Diag), victoireJoueurColonne(Joueur, Diag), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 8, Diag), victoireJoueurColonne(Joueur, Diag), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 9, Diag), victoireJoueurColonne(Joueur, Diag), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 10, Diag), victoireJoueurColonne(Joueur, Diag), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 11, Diag), victoireJoueurColonne(Joueur, Diag), !.
victoireJoueur(Joueur, Grille) :- extraireDiag(Grille, 12, Diag), victoireJoueurColonne(Joueur, Diag), !.

% Appel : victoire(+Grille).
%
% Une preuve existe si un des deux joueurs a gagné.
victoire(Grille) :- victoireJoueur(x, Grille), !.
victoire(Grille) :- victoireJoueur(o, Grille), !.
