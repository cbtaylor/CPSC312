% CPSC 312 -- Assignment 3
% Brian Taylor
% 52311859
% z2b0b

/* floors(Fs) is true if all conditions are true                          */
floors(Fs) :-
	% the list Fs should contain yves, dave, brian, ed and mike
	% in order from 1st to 5th floors
	
	Fs = [_,_,_,_,_],                 % there are five floors
    
    member(yves, Fs),
    member(dave, Fs),
    member(brian, Fs),
    member(ed, Fs),
    member(mike, Fs),

    not(Fs = [_,_,_,_,yves]),         % yves doesn't live on the 5th floor
    not(Fs = [dave,_,_,_,_]),         % dave doesn't live on the 1st floor
    not(Fs = [_,_,_,_,brian]),        % brian doesn't live on the top floor
    not(Fs = [brian,_,_,_,_]),        % brian doesn't live on the bottom floor
    not(next(brian, dave, Fs)),       % brian doesn't live next to dave
    not(next(brian, mike, Fs)),       % brian doesn't live next to mike
    above(ed, dave, Fs).              % ed lives above dave

/* next(A, B, Ls) is true if A is adjacent to B in Ls.                     */
next(A, B, Ls) :- append(_, [A,B|_], Ls).
next(A, B, Ls) :- append(_, [B,A|_], Ls).

/* above(A, B, Ls) is true if A is above B in Ls (i.e. later in the list). */
above(A, B, Ls) :- append(Is, [A|_], Ls), append(_, [B|_], Is).

/* member(X,Xs) is true if X is a member of the list Xs.                   */
member(X,[X|Xs]).
member(X,[Y|Ys]) :- member(X,Ys).

/* append(X, Y, Z) is true if Z is the list with Y appended to X.          */
append([], X, X).
append([H|T1], X, [H|T2]) :- append(T1, X, T2).

% Output:

% ?- floors(Fs).
% Fs = [mike, dave, yves, brian, ed] 
% false.

% The procudure found a valid ordering of the five people that satisfies
% all the conditions, and it also determined that this is a unique
% solution.