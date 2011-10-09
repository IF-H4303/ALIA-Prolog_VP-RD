evaluer(Grille, 1000) :- victoireJoueur(x, Grille), !.
evaluer(Grille, -1000) :- victoireJoueur(o, Grille), !.
evaluer(Grille, Valeur) :-
    score(x, Grille, ScoreX),
    score(o, Grille, ScoreO),
    Valeur is ScoreX - ScoreO.

score(Joueur, Grille, Score) :-
    scoreLignes(Joueur, Grille, ScoreLignes),
    scoreColonnes(Joueur, Grille, ScoreColonnes),
    Score is ScoreLignes + ScoreColonnes, !.

scoreLignes(Joueur, Grille, Score) :-
    findall(Ligne, extraireLigne(Grille, _, Ligne), Lignes),
    scoreAlignement(Joueur, Lignes, 0, Score).

scoreColonnes(Joueur, Grille, Score) :-
    findall(Colonne, extraireColonne(Grille, _, Colonne), Colonnes),
    scoreAlignement(Joueur, Colonnes, 0, Score).

scoreAlignement(Joueur, [X|L], ScoreCourant, Score) :-
    scoreAlignement(Joueur, X, ScoreAlignement),
    NouveauScoreCourant is ScoreCourant + ScoreAlignement,
    scoreAlignement(Joueur, L, NouveauScoreCourant, Score).
scoreAlignement(_, [], ScoreCourant, ScoreCourant).  

scoreAlignement(Joueur, Colonne, 100) :- alignement(Joueur, Colonne, Max), Max > 3.
scoreAlignement(Joueur, Colonne, 50) :- alignement(Joueur, Colonne, 3).
scoreAlignement(Joueur, Colonne, 5) :- alignement(Joueur, Colonne, 2).
scoreAlignement(Joueur, Colonne, 1) :- alignement(Joueur, Colonne, 1).
scoreAlignement(Joueur, Colonne, 0) :- alignement(Joueur, Colonne, 0).

alignement(Joueur, Colonne, Max) :- alignement(Joueur, 0, Colonne, -1, Max). 
alignement(Joueur, Nombre, [X|L], MaxCourant, MaxResultat) :-
    Joueur == X,
    NouveauNombre is Nombre + 1,
    alignement(Joueur, NouveauNombre, L, MaxCourant, MaxResultat).
alignement(Joueur, Nombre, [X|L], MaxCourant, MaxResultat) :-
    not(Joueur == X),
    Nombre > MaxCourant,
    alignement(Joueur, 0, L, Nombre, MaxResultat).
alignement(Joueur, _, [X|L], MaxCourant, MaxResultat) :-
    not(Joueur == X),
    alignement(Joueur, 0, L, MaxCourant, MaxResultat).
alignement(_, Nombre, [], MaxCourant, Nombre) :- Nombre > MaxCourant, !. 
alignement(_, _, [], MaxCourant, MaxCourant) :- MaxCourant > -1, !.


% Appel : victoireJoueurColonne(+Joueur, +Colonne).
% Une preuve existe si une suite de 4 symboles consécutifs de Joueur 
% est trouvée dans Colonne.
victoireJoueurColonne(Joueur, Colonne) :- alignement(Joueur, Colonne, Max), Max > 3.

% Appel : victoireJoueurLigne(+Joueur, +Ligne).
% Une preuve existe si une suite de 4 symboles consécutifs de Joueur 
% est trouvée dans Ligne.
victoireJoueurLigne(Joueur, Ligne) :- alignement(Joueur, Ligne, Max), Max > 3.

% Appel : victoireJoueur(+Joueur, +Grille).
% Une preuve existe si le joueur Joueur a gagné sur Grille.
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 1, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 2, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 3, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 4, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 5, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 6, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireColonne(Grille, 7, Colonne), victoireJoueurColonne(Joueur, Colonne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 1, Ligne), victoireJoueurLigne(Joueur, Ligne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 2, Ligne), victoireJoueurLigne(Joueur, Ligne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 3, Ligne), victoireJoueurLigne(Joueur, Ligne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 4, Ligne), victoireJoueurLigne(Joueur, Ligne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 5, Ligne), victoireJoueurLigne(Joueur, Ligne).
victoireJoueur(Joueur, Grille) :- extraireLigne(Grille, 6, Ligne), victoireJoueurLigne(Joueur, Ligne).

% Appel : victoire(+Grille).
% Une preuve existe si un des deux joueurs (x ou o) a gagné.
victoire(Grille) :- victoire(x, Grille).
victoire(Grille) :- victoire(o, Grille).

