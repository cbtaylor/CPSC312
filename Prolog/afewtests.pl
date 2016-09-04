append1([],X,X).
append1([H|T1],X,[X|T2]) :- append(T1,X,T2).