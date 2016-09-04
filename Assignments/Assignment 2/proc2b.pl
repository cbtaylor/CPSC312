proc2b([],_).
proc2b(Xs,Ys) :- solo(Xs, Ys), solo(Ys, Xs), uniq(Xs).

/* solo(Xs, Ys) is true if each element in Xs appears once or more in Ys  */
solo([],_).
solo([X|Xs],Ys) :- member(X,Ys),solo(Xs,Ys).

/* determines if a list has unique elements */
uniq([]).
uniq([X|Xs]) :- \+member(X,Xs), uniq(Xs).

/* member(X,Xs) is true if X is a member of the list Xs.                   */
member(X,[X|Xs]).
member(X,[Y|Ys]) :- member(X,Ys).