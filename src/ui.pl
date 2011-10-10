% Appel : afficherGrille.
%
% Affiche la grille dans la console avec des x, o et tirets pour les cases vides.
afficherGrille :-
    grille(Grille),
    findall(Ligne, extraireLigne(Grille, _, Ligne), Lignes),
    reverse(Lignes, LignesInversees), % Les cases du bas sont en tête de tableau.
    afficherLignes(LignesInversees).

% Appel : afficherLignes(+Lignes).
%
% Affiche un ensemble de Lignes. Chaque ligne débute par quatre espaces.
afficherLignes([L|R]) :- write('    '), afficherLigne(L), afficherLignes(R).
afficherLignes([]).

% Appel : afficherLigne(+Ligne).
%
% Affiche une ligne complète. Deux symbole sont séparés par un espace.
afficherLigne([L|R]) :- afficherSymbole(L), write(' '), afficherLigne(R).
afficherLigne([]) :- nl.

% Appel : afficherSymbole(+Symbole).
%
% Affiche un symbole (x, o ou vide).
afficherSymbole(vide) :- write('-').
afficherSymbole(o) :- write('o').
afficherSymbole(x) :- write('x').

% Appel : j(+NumeroColonne).
%
% Joue dans la colonne NumeroColonne (pour le joueur jouant les « o ») 
% et affiche ensuite la nouvelle grille.
j(NumeroColonne) :- jouer(o, NumeroColonne), afficherGrille, afficherVictoire(o), !.

% Appel : o.
%
% Calcule le meilleur coup pour le joueur jouant les « x », le joue 
% et affiche ensuite la nouvelle grille.
o :- grille(Grille), minimax(Grille, 2, Coup), jouer(x, Coup), afficherGrille, afficherVictoire(x), !.

% Appel : afficherVictoire.
%
% Affiche une victoire ou une défaite si un des deux joueurs a gagné.
afficherVictoire(o) :- grille(Grille), victoire(Grille), write('Vous avez gagné !'), nl, !.
afficherVictoire(x) :- grille(Grille), victoire(Grille), write('Vous avez perdu !'), nl, !.
afficherVictoire(o).
afficherVictoire(x).