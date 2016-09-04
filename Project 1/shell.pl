go :-
    greeting, 
    repeat, 
    write('> '), 
    read(X), 
    do(X), 
    X == quit.

greeting :-
    write('This is the Native Prolog shell.'), nl, 
    write('Enter load, consult, or quit at the prompt.'), nl.

do(load) :- load_kb, !.

do(consult) :- solve, !.

do(quit).

do(X) :-
    write(X), 
    write('is not a legal command.'), nl, 
    fail.

load_kb :-
    write('Enter file name: '), 
    read(F), 
    reconsult(F).

