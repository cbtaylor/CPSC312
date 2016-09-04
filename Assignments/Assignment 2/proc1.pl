proc1([],Ys,Ys).
proc1(Xs,[],Xs).
proc1([X|Xs], [Y|Ys], [X,Y|Zs]) :- proc1(Xs, Ys, Zs).