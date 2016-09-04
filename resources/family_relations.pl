parent(X,Y):- father(X,Y);mother(X,Y).

grandparent(X,Y) :- parent(X,Z), parent(Z,Y).

son(S,P):- parent(P,S), male(S).
daughter(D,P) :- parent(P,D), female(D).

sister(X,Y) :- parent(P,X), parent(P,Y), female(X),X\=Y.	% this states that X is a sister of Y. Y need not be X's sister.
sisters(X,Y) :- parent(P,X), parent(P,Y), female(X),female(Y),X\=Y.

brother(X,Y) :- parent(P,X), parent(P,Y), male(X),X\=Y.
brothers(X,Y) :- parent(P,X), parent(P,Y), male(X), male(Y), X\=Y.

siblings(X,Y) :- parent(P,X),parent(P,Y),X\=Y.	% note that this code will include half siblings too as siblings, to account only for full siblings, the check for same parent needs to be replaced by same father and same mother.

% another way to write sister
sister2(X,Y) :- siblings(X,Y), female(X).
brother2(X,Y) :- siblings(X,Y), male(X).

cousin(X,Y) :- parent(Px,X),parent(Py,Y), siblings(Px,Py).
second_cousin(X,Y) :- grandparent(GPx,X),grandparent(GPy,Y), siblings(GPx,GPy).

nephew(X,Y) :- son(X,P), siblings(P,Y).
niece(X,Y) :- daughter(X,P), siblings(P,Y).

aunt(X,Y) :- sister(X,P), parent(P,Y).
uncle(X,Y) :- brother(X,P), parent(P,Y).


% once you've stated all these rules, you need to define your facts as well (or do it vice versa - doesnt matter)
% given the rule base above, it's clear that relations father/2, mother/2 as well as male/1 and female/1 should be provided as facts
% since there are no rules defining them.
%
% could you have written rules for those relations as well? 
% rules such as
% female(X) :- mother(X);daughter(X,_);sister(X,_).
% male(X) :- father(X);son(X,_);brother(X,_).
% ?
%
% these rules will cause your programs to get into infinite loops, since they're defining a logical loop:
% X is a father if X is a male. X is a male if he is a father.
% neither of these rules will ever be resolved if you added the above rule to your program.
% 
% this should make you think about the hierarchy of knowledge when you're designing your program:
% which information is available as raw facts? which knowledge can easily be derived from other knowledge through rules?
% and which information is not available as facts and we are interested in exploring? this last group is the aim of your program 
% the hierarchy that you design should have the last group at its top; built on top of the more easily available rules
% in a family tree program, for instance, we can be intrested in finding out all of a person's second+ cousins
% but we are never insterested in finding out whether someone is male or female. This information is usually factually available.
% these questions should help you distinguish between knowledge that should be represented as facts and those that should be rules in programs you write. 
% 

mother(vajih, sara).
father(mahmoud,sara).

father(mahmoud,amirali).
mother(vajih,amirali).

mother(vajih,zahra).
father(mahmoud,zahra).

mother(zahra,parsa).
father(sepehr,parsa).

mother(grandma,vajih).
mother(grandma,azra).
mother(grandma,javad).

father(javad, amin).
mother(fahime, amin).

male(X) :- father(X,_).
female(X) :- mother(X,_).

male(amirali).
male(parsa).
male(amin).

female(sara).
female(azra).

% note that I could have simply expressed my siblings as a sibling relation, or as a brother or sister relation to me,
% however, looking at how siblings relation is defined above, I know that if I state the parents of my siblings, the program will automatically derive the sibling information from.
% it was possible to do it a different way though. Since writing sibling relation is more terse, I could have expressed those as facts
% and then write a rule that derive parent relations from sibling information, such as
% father(X,Y) :- father(X,Z), siblings(Y,Z). 
% they are both possible; one way may be more efficient, both for the amount of fact writing and computationally, but that depends on the purpose of the program.
% it cannot be determined without knowing what goal is to be achieved from this program.

/* now if I query this program, I'll get these results:
?- aunt(X,sara).           
X = azra ;
false.

?- uncle(X,sara).
X = javad ;
false.

?- brother(X,sara).
X = amirali ;
X = amirali ;
false.

?- sister(X,sara). 
X = zahra 
Unknown action: l (h for help)
Action? .

?- sister(X,sara).
X = zahra ;
X = zahra ;
false.

?- nephew(X,sara).
X = parsa ;
X = parsa ;
false.

?- niece(X,sara). 
false.

?- father(X,sara).
X = mahmoud.

?- mother(X,sara).
X = vajih.

?- grandparent(X,sara).
X = grandma ;
false.

?- cousin(X,sara).     
X = amin ;
false.

*/

% note the redundant answers, which signals redundancies in the definitions of rules and facts. 
% Wherever a result is repeated, it means there are overlaps in definitions of that certain fact. 
% try sisters(X,Y) query and see how many overlaps you get there.

% Exercise:
% now write your own small family tree, using the relations father, mother, and male and female. 
% then query it in as many ways as you can
% now look into those repeated results and try to see if you can rewrite any of the above rules or express your facts using other relations (change the hierarchy of facts and rules) 
% to see if you can make the redundancy disappear. 


