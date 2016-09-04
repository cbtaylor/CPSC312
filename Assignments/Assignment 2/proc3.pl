proc3(Xs, Ys) :- proc3(Xs, [], Ys).

proc3([], Ys, Ys).
proc3([X|Xs], Acc, Ys) :- member(X, Acc), proc3(Xs, Acc, Ys).
proc3([X|Xs], Acc, Ys) :- \+member(X, Acc), proc3(Xs, [X|Acc], Ys).

member(X,[X|Xs]).
member(X,[Y|Ys]) :- member(X,Ys).