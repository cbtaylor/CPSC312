
natural_number(0).
natural_number(s(X)) :- natural_number(X).

/* sample queries:

?- natural(s(s(s(0)))).
true.

?- natural(X).
X=0;
X=s(0);
X=s(s(0));
...

using the template of the code for natural_numbers, 
here is a code that proves X is an odd number (in the form of s(s(..s(X))) if it is an odd numnber:

odd(s(0)).
odd(s(s(X))):-odd(X).

can you write the code for even(X)?
*/

%%%%%%%%%%%%%%%%%%%%%%%%%
% two versions of plus:
% plus1 uses s(X) notation instead of numbers
% plus2 uses the arithmetic procedure succ to display numbers. 
% note that with succ/2 at least one of the arguments need to be instantiated.

plus1(0,X,X):- natural_number(X).
plus1(s(X),Y,s(Z)) :- plus1(X,Y,Z).

plus2(0,X,X).
plus2(X,Y,Z) :- succ(Xa,X), succ(Za,Z), plus2(Xa,Y,Za).

/* sample queries:

?-plus1(s(s(0)),s(s(s(0))),X).
X = s(s(s(s(s(0))))).

?-plus1(X,s(s(s(0))),s(s(s(s(s(0)))))).
X=s(s(0));
false

?-plus2(2,3,X).
ERROR: succ/2: Arguments are not sufficiently instantiated

?-plus2(2,X,5).
X=3;
false

try these on your own:
?-plus2(X,3,5).
?-plus2(X,Y,5).

and reason about the output.

can you rewrite plus with arithmetic operators that you've learned (see lecutre slides from Sep 29th) so that it can be quried like this:
?-plus3(2,3,X).
without getting into an error condition?

How will you rewrite plus1 such that the second argument, Y, instead of X, be the subject of recursion?
*/

%%%%%%%%%%%%%%%%%%%%%%%%
% two versions of times:
% times1 uses s(X) notation instead of numbers
% times2 uses the arithmetic procedure succ to display numbers. 
% note that with succ/2 at least one of the arguments need to be instantiated.
% note also that times1 works with plus1 and times2 with plus2 because of the compatibility in their display of numbers. 
 
times1(0,_,0).
times1(s(X),Y,Z) :- times1(X,Y,P),plus1(P,Y,Z).

times2(0,_,0).
times2(X,Y,Z) :- succ(Xa,X),times2(Xa,Y,P),plus2(P,Y,Z).

/*
sample queries

?- times1(s(s(0)),s(s(s(0))),X).
X = s(s(s(s(s(s(0)))))).

what would this return:
?- times1(X,Y,s(s(s(0)))).  
why?

?- times2(3,Y,9).         
ERROR: succ/2: Arguments are not sufficiently instantiated
?- times2(3,3,9).
ERROR: succ/2: Arguments are not sufficiently instantiated
?- times2(X,3,9).
ERROR: succ/2: Arguments are not sufficiently instantiated

Why isn't times2 working in any of the above cases?
Can you use arithmetic operators to write a version of times that would work for this query:
?-times3(2,3,X).

*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exponentation of X to the power Y is Z

exp1(_,0,s(0)).
exp1(X,s(N),Y) :- exp1(X,N,Yn),times1(X,Yn,Y).

% can you write the second version of exp, with succ, using the examples of plus and times?

/* 
sample queries
?- exp1(s(s(0)),s(s(s(0))),X).
X = s(s(s(s(s(s(s(s(0)))))))) ;
false.

?- exp1(X,s(s(0)),s(s(s(s(s(s(s(s(s(0)))))))))).
X = s(s(s(0))) ;

How can you fix this to not overflow the stack/get stuck?

*/

%%%%%%%%%%%%%%%%%%%%%
% factorial of N is F

% factorial1: can you write a version of factorial using s(X), based on similar examples above?

% factorial2: recursive factorial with arithmetic successor
factorial2(0,1).
factorial2(N,F) :- succ(Na,N), factorial2(Na,Fn),times2(N,Fn,F).

% recursive factorial with arithmetic evaluation
factorial3(0,1).
factorial3(N,F) :- N1 is N-1, factorial3(N1,F1), F is N*F1. 

% the iterative factorial
factorial4(N,F) :- factorial4(0,N,1,F).
factorial4(N,N,F,F).
factorial4(I,N,T,F) :- I < N, I1 is I+1, T1 is T*I1, factorial4(I1,N,T1,F).

/*
sample queries
?- time(factorial4(4,X)).
?- time(factorial3(4,X)).
?- factorial2(X,24).
?- factorial3(10,X).
?- factorial4(X,6).
add you own query

do exercise (vi) from section 3.1 of your textbook regarding the times predicate.
*/

%%%%%%%%%%%%%%%%%%%%%%%
% arithmetic operators

/* sample queries with is/2, =:=/2, and other arithmetic operators (See lecture slides from Sep 29th for the meaning of each operator)
what would these queries return? why?
?- Y is 3+2, X is Y+1.
?- X is 5/2, Y is 5//2, Z is 5 mod 2.
?- X =:= 2+3.
?- 9*8 =:= 72.
?- 4+1 = 1+4.
?- X+1 = 4+Y.
?- X = 4.
?- X = Y*2.
?- X = 1+2.
?- X == 4.
?- 2+2 =\= 2*2
?- 2+2 \== 2*2
?- X is 2*134/45.
?- X is 2*134//45.
?- X is 2*(134//45).
?- 3 is 5-2.
?- 3 is X-2.
?- write your own query using =<, <, >, >=
*/

%%%%%%%%%%%%%%%%%%%%%%
% implement 

/* using the arithmetic operators you've learned how can you implement:

1. max(X,Y, Max) 
such that Max is the greater of two numbers X and Y
2. between(N1,N2,X)
such that given the two integers N1 and N2, through backtracking, X unifies with all the integers that satisfy the constraint: N1 < X < N2
*/