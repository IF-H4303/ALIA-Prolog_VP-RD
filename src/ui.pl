% Ensemble de clauses permettant de g�rer l'interaction 
% du joueur avec l'ordinateur de fa�on agr�able et visuelle.

% Permet d'afficher la grille de fa�on graphique.
afficherGrille :-
    grille(Grille),
    findall(Ligne, extraireLigne(Grille, _, Ligne), Lignes),
    reverse(Lignes, LignesInversees),
    afficherLignes(LignesInversees).

afficherLignes([L|R]) :- write('    '), afficherLigne(L), afficherLignes(R).
afficherLignes([]).

afficherLigne([L|R]) :- afficherSymbole(L), write(' '), afficherLigne(R).
afficherLigne([]) :- nl.

afficherSymbole(X) :- var(X), write('#').
afficherSymbole(X) :- \+var(X),write(X).