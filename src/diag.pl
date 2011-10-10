%Predicat de validiter de diagonal :
%Liste de vérification [false, false, false]
%Comparaison des elements voisins pour remplir la liste, si element identique, alors true.



victoireJoueurDiag(Joueur, Conseq, Grille) :- 
	extraireElement(Grille, 1, 1, Res),
	Joueur = Res,
	CoordCol is CoordCol+1,
	extraireElement(Grille, CoordCool
	