proc4([], []).
proc4([X|Xs], Ys0) :-
  proc4(Xs, Ys), 
  remove_one(X, Ys0, Ys).

/* remove_one(X, Ys, Zs) is true if Zs is the result of removing one       */
/*   occurence of the element X from the list Ys.                          */
remove_one(X, [X|Xs], Xs).
remove_one(X, [Y|Ys], [Y|Zs]) :-
  remove_one(X, Ys, Zs).