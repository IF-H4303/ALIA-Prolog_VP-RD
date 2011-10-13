%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Projet Prolog - 4IF               %
%                                                %
% Ce fichier est le script d'initialisation du   %
% programme. Les commandes liées au jeu sont     %
% définies dans ui.pl.                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- dynamic grille/1.
:- consult('/Users/vincent/workspace/Projet Prolog/src/grille.pl').
:- consult('/Users/vincent/workspace/Projet Prolog/src/jeu.pl').
:- consult('/Users/vincent/workspace/Projet Prolog/src/ia.pl').
:- consult('/Users/vincent/workspace/Projet Prolog/src/ui.pl').
:- consult('/Users/vincent/workspace/Projet Prolog/src/score.pl').
:- initialiserGrille.
