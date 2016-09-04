% a list is either a list, or it has a head and a tail, where the tail is a list.
list([]).
list([_|T]) :- list(T).

%%%%%%%%%%
% two ways to write the member procedure
member1(X,[X|_]).	%either X is the head of the list
member1(X,[_|T]) :- member1(X,T).	% or X is a member of the tail

% X is a member of L if there are two lists that can be appended together to make L such that X is the head of the second list.
member2(X,L) :- append(_,[X|_],L).

% what other ways can you write the procedure member? which one of the procedures in this file can you use to implement member?

%%%%%%%%%%
% the last member of a list

last(X,[X]).	% X is the last member of a list, if it's the only member.
last(X,[_|T]) :- last(X,T).		% X is the last member of a list if it's the last member of its tail

% can you use append to write the last procedure, using the second implementation of member as an example? like:

% last(X,L) :- append(?,?,L).

%%%%%%%%%%
% adding and deleting

% adding to the head can simply be done through the bar operatore (|)
% adding X to the head of L: [X|L]
% the same logic can be written into a predicate:
add_to_head(X,L,[X|L]).

% what about adding to the end? here is a recursive version:
add_to_tail(X,[],[X]).		% if L is empty, the result of adding X to its end will be [X]
add_to_tail(X,[H|T],[H|Tx]) :- add_to_tail(X,T,Tx).	% if X has other members add X to the end of the tail of L.

% using the example of last above, how would you implement a version of add_to_tail using append?
% add_to_tail2(X,L,L1) :- append(?,?,L1).

% there are different ways to write a delete procedure.
% the add procedure written above can be queried this way to function as a delete from the head:
% ?-add([a],L,[a,b,c]).
% L=[b,c].
% Similarly the bar operator also works for deleting from the list, since it makes the tail of the list accessible as a new variable
% (that's kind of like deleting the head and putting the result into the tail) -> if L=[H|T] -> T is the result of removing the head of L

% what about removing an element from anywhere in the list though?

del1(X, [X|Xs],Xs).			% either X is at the head of the list.. (same case as above)
del1(X, [H|Xs],[H|Xs1]) :- del1(X,Xs,Xs1).  
% or it's deeper inside the list, in which case, keep on taking the heads off until you reach a point where X is the head the remainder

% q1. what will happen in this case, if X is not a member of the given list? query it to find out.
% procedurally, what is the meaning of the output you see?

% q2. what will happen if there is more than one occurrence of X in the list? which occurrence does this delete remove?

% delete all occurences of X in list L:

del2(_,[],[]).	% if there is no members in the list, there are no occurrences of X left to delete
del2(X,[X|T],Tx) :- del2(X,T,Tx).	% if X is at the head of the list, remove them, then call the procedure again with the tail of the list, to remove the rest of the occurrences
del2(X,[H|T],[H|Tx]) :- X\=H, del2(X,T,Tx).	% if the head of the list is not X, then search the rest of the list and remove all occurrences of X from it.

% q1. in the second and the third clause of the above procedure, 
% why is it that in the third clause the second list and the third have the same head, but in the second clause that doesn't happen?
% what is the procedural meaning of this pattern? what is the procedural difference between these two clauses? 
% and what I mean by "procedural meaning" is what procedural action is being taken or procedural effect is achieved through this pattern. 
% In other words, if this code was written procedurally, what would be done instead of the pattern matching of the heads in the third clause?

% q2. try removing X\=H from the third clause and see how the output will change.

% q3. what will happen in the case of del2, if X does not exist in the given list? 

% q4. there is a new way of implementing member using del1:
% member3(X,L) :- del1(X,L,_). % X is a member of L if it can be deleted from it.
% using the multi-deleter that we wrote in del2, we can't do this any more, because this query is true:
% ?- del2(a,[b,c],[b,c]).
% in other words, the logical statement that "X is a member of L if it can be deleted from it" does not hold anymore;
% with this new definition of delete, X can be not a member of list but still be deleted from it.

% can you write a version of delete that removes all occurrences of X BUT still returns false if X is not a member of the list?
% remember that something is false in prolog if it is not stated as true or cannot be derived from other stated truths.
% so if your program simply does not cover a case where X is not a member of L, a query asking that will automatically fail

% therefore, think about your solution in terms of changing the base case which clearly states a list not including X (the empty list), 
% will produce the empty list as a result (and therefore implying that deleting X from a list that doesn't contain it can succeed)
% and adding a condition check as a substitute for termination case.

% del3(X, [X|T], ?) :- ?
% del3(X, [X|T], ?) :- ?
% del3(X, [H|T], [H|Tx]) :- X\=H, del3(X,T,Tx). 

%%%%%%%%%%%
% append, prefix, suffix, sublist

myappend([],X,X).		% if a list is empty, appending it to a second list will result in the second list itself.
myappend([H|T1],X,[H|T2]) :- myappend(T1,X,T2).	
% if a list is has a head and a tail, appending it to a second list, is equivalent to putting its head as the head of the resulting list
% then appending its tail to the second list and have the result of that be the tail of the resulting list.

% append can also perform the job of a split. Try this query on your own:
% ?- append(X,Y,[a,b,c]).

% how can you prove that X is the prefix of Y? what about suffix and sublist?
prefix(X,Y) :- append(X,_,Y).	% if X is a list that can be appended to another list and result in Y, then X is Y's prefix
suffix(X,Y) :- append(_,X,Y).	% if there is a list that can be appended to the list X and result in Y, then X if Y's suffix.

sublist(X,Y) :- prefix(X,Z),suffix(Z,Y).	
% if X is a sublist of Y, then there is a list Z, such that X is a prefix of it and Z is a suffix of Y
% visually:
% [<----Y---->]
% 	  [<--Z-->]		% Z is a suffix of Y
%	  [<-X->]		% X is prefix of Z
% or
% [<----Y---->]
% 	[<---Z--->]
%	[<-X->]	
% or
% [<----Y---->]
% [<----Z---->]
% [<-X->]	

% note that we could use suffix and prefix in the reversed order as well: such that Z is a prefix of Y, and X is its suffix:
% sublist(X,Y) :- prefix(Z,Y), suffix(X,Z).
% and the visuals too will be mirrored:
% [<----Y---->]
% [<--Z-->]			% Z is a prefix of Y
%	[<-X->]			% X is suffix of Z
% or
% [<----Y---->]
% [<---Z--->]
%	  [<-X->]	
% or
% [<----Y---->]
% [<----Z---->]
% 		[<-X->]	

% in both cases nonetheless, X has the freedom to start and end anywhere in Y, and therefore be its sublist
% because Z can, through backtracking, unify with any portion of Y, that starts from the head (as a prefix) or the tail (as a suffix) of Y.

% q. can you write sublist as a recursive procedure and only using either one of prefix and suffix?
% so, for instance, using only prefix, a base case for sublist can be: if list is a prefix of Y, then it's its sublist too:
% sublist2(X,Y) :- prefix(X,Y).
% what would the recursive clause be like, also using prefix?

% can you rewrite prefix (or suffix) recursively and without the use of append?
% for prefix, for instance, think about it as writing an auxiliaty proceudre that checks wether two lists have the same members, 
% then only perform the check for the length of the first list. So in
% X=[1,2,3]
% Y=[1,2,3,...]
% only do the check on the first part of Y, for as long as there are members left in X.
% what would the base case be?


%%%%%%%%%%%
% equal lengths (without using arithmetics or the length procedure)
% a procedure that checks whether two given lists have equal lengths, without measuring their lengths.

equal_lengths([],[]).	% two lists have equal lengths if they both have no members (zero lengths)
equal_lengths([_|T1],[_|T2]) :- equal_lengths(T1,T2).	% or if they have members, if their heads are removed, their tails will have equal lengths.

% query it with 
% ?- equal_lengths([1,2],[a,b]).
% what about this ?- equal_lengths([1,2],X).

%%%%%%%%%%%
% two versions of reverse

% reverse with append 
reverse1([],[]).
reverse1([X|Xs],Zs) :- reverse1(Xs,Ys), append(Ys,[X],Zs).

% reverse with an accumulator (i.e. iterative) (see Sep 29 lecture)
reverse2(Xs,Ys) :- reverse2(Xs, [], Ys).
reverse2([X|Xs],Acc,Ys) :- reverse2(Xs,[X|Acc],Ys).
reverse2([],Ys,Ys).

% q1. run these two procedures with the time predicate and see which one is faster:
% ?- time(reverse1([a,b,c],X)).
% ?- time(reverse2([a,b,c],X)).

% q2. can you write a version of reverse through direct recursion?
% at every step, you would need to check whether the head of the first list is the last item of the second list..
% using the procedure last that we wrote above..
% then remove the last element, and continue to check whether the tail of the first list is the reverse of the remainder of the second list..
% what would the base case be?
% is this the same as the first reverse? if you write a different procedure, time it to see how it's different from the first version.
% do you know now how to implement the procedure last with append?

% q3. using the example of the second reverse, can you implement append using an accumulator (an extra argument)?
% here is a part of it; see if you can fill in the blanks:
% append2(X,Y,L) :- append2(X,Y,?,?).
% append2([X|Xs],Y,?,L) :- append2(Xs,Y,Z,L).
% append2([],?,?,?).

% which version of append performs faster?

%%%%%%%%%%%
% insert an item at a given in a list
% insert(X,L,N,Lx). -> insert X at point N in L, producing Lx
% counting the places in the list from s(0)

insert(X,L,s(0),[X|L]).
insert(X,[H|T],s(N),[H|Tx]) :- insert(X,T,N,Tx).

% you can query it this way:
% ?- insert(3,[1,2,4,5],s(s(s(0))),X).
% or
% ?- insert(3,[1,2,4,5],N,[1,2,3,4,5]).
% returning to you the position of N in the last list
% or even in this cool way:
% ?- insert(3,L,N,[1,2,3,4,5]).
% without having to produce L, before you find out the position of X in a list.
% or even in this way:
% ?- insert(X,L,s(s(s(0))),[1,2,3,4,5]).
% extracting an element from a specific position in a list and having both the element and the resulting list returned to you.

% q1. can you write a version of insert that takes numbers instead of the successor function using arithmetics?
% q2. can you write a version of insert using append? you can use the procedure length as an auxiliary

%%%%%%%%%%%
% length: four versions (from the slides of Sep 29th)

%recursive; display numbers as successor function
length1([_|Xs], s(N)) :- length1(Xs,N).
length1([],0).
% works whether queried this way
% ?- length([1,2,3],N).
% or this way
% ?- length(X,s(s(0))).

length2([],0).
length2([_|Xs],N) :- length2(Xs,N1), succ(N1,N).
% try queryng with ?- length(X,3).
% can succ appear before the recursive call? try changing it that way and querying it, without a ground list and an unknown N
 

% the difference between this and the above: succ can have either of its arguments instantiated and work
% but with is the left one can never be uninstantiated
length3([],0).
length3([_|Xs],N) :- length3(Xs,N1), N is N1+1.
% is there any case where the outcome of length3 will be different from length2?

% an iterative implementation (ch. 8 of textbook)
length4([],0).
length4([_|Xs], N) :- N>0, N1 is N-1, length4(Xs, N1).
% can this code calculate the length of a given list?
