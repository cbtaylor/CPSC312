proc2a([],[]).
proc2a([X|Xs],[X,X|Ys]) :- proc2a(Xs,Ys).