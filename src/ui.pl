% Ensemble de clauses permettant de gérer l'interaction 
% du joueur avec l'ordinateur de façon agréable et visuelle.

% Permet d'afficher la grille de façon graphique.
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