%-------------------------------------------------------------------------
% connect 4
%-------------------------------------------------------------------------

% computer is playing X's
% opponent plays O's


%-------------------------------------------------------------------------
% this allows the addition of facts to the predicates "x" and "o"

:- dynamic(o/1).
:- dynamic(x/1).


%-------------------------------------------------------------------------
% define the board geometry

ordered_line(1,2,3).  ordered_line(4,5,6).  ordered_line(7,8,9).
ordered_line(1,4,7).  ordered_line(2,5,8).  ordered_line(3,6,9).
ordered_line(1,5,9).  ordered_line(3,5,7).

line(A,B,C) :- 
  ordered_line(A,B,C); ordered_line(A,C,B); ordered_line(B,A,C); 
  ordered_line(B,C,A); ordered_line(C,A,B); ordered_line(C,B,A).

full(A) :- x(A); o(A).  % ';' is 'or'

empty(A) :- not(full(A)).  % NB: empty must be called on a instantiated A

different(A,B) :- A \= B.


%-------------------------------------------------------------------------
% strategy

move(A) :- good(A), empty(A), !.

good(A) :- win(A).
good(A) :- block_win(A).
good(A) :- split(A).
good(A) :- block_split(A).
good(A) :- build(A).

% defaults: if previous rules fail (like when the board is empty),
% Note the implicit preference for some corners over others.  
% This prolog-induced order could be exploited by opponents if known

good(5).                            % prefer the center
good(1). good(3). good(7). good(9). % failing that prefer the corners
good(2). good(4). good(6). good(8). % take the mid-edges if you have to


%-------------------------------------------------------------------------
% define each sub-strategy

win(A) :- x(B), x(C), line(A,B,C).

block_win(A) :- o(B), o(C), line(A,B,C).

split(A) :- x(B), x(C), different(B,C), 
            line(A,B,D), line(A,C,E), empty(D), empty(E).

block_split(A) :- o(B), o(C), different(B,C), 
                  line(A,B,D), line(A,C,E), empty(D), empty(E).

build(A) :- x(B), line(A,B,C), empty(C).


%-------------------------------------------------------------------------
% manage the user interface

all_full :- full(1), full(2), full(3), 
            full(4), full(5), full(6), 
            full(7), full(8), full(9).

done :- all_full, write('We have a draw'), nl.
done :- ordered_line(A,B,C), x(A), x(B), x(C), write('I won.'), nl.
% this next one should not happen since perfect play will cause draw
done :- ordered_line(A,B,C), o(A), o(B), o(C), write('You won.'), nl.

% the idea here with repeat is if you enter a cell number that
% is already marked, then empty(X) will fail and this will 
% cause the interpreter to try again from the repeat.
% so, it loops until the user enters the number of an empty square
% the parens are not necessary... I added them to emphasize the
% 'body' of the repeat
getmove :- repeat, (
              write('Please enter a move: '), 
              read(X), 
              empty(X)
           ), 
           assert(o(X)).

makemove :- move(S), !, assert(x(S)).
makemove :- all_full.

prSq(N) :- o(N), write(' O ').
prSq(N) :- x(N), write(' X ').
prSq(N) :- empty(N), write(' _ ').

prAll :- nl, write('   '), prSq(1), prSq(2), prSq(3), nl,
             write('   '), prSq(4), prSq(5), prSq(6), nl,
             write('   '), prSq(7), prSq(8), prSq(9), nl,
         nl.

clearBoard :- not(moreToClear).
moreToClear :- x(A), retract(x(A)), fail.
moreToClear :- o(A), retract(o(A)), fail.

%------------------------------------------------------------------------
% main goal
%
% this is a loop (the 'repeat') 
% on get user move, make computer move, print board
% until full, win, lose, draw

play :- clearBoard, repeat, ( 
                       getmove, 
                       makemove, 
                       prAll, 
                       done 
                    ).

