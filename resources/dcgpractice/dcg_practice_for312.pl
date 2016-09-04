% This file contains a few examples of writing DCG grammar rules for simple sentences
% some exercises for you to do and an example of using an extra argument to advance our program 
% from a simple true/false parser to one that returns useful information about the parsed sentence
% by Sara Sagaii

% the room is empty 

% s --> np, vp.
s --> np(X), vp.

vp --> v, adj.

% np --> d, n.
np(X) --> d, n(X).

adj --> [empty].

% n --> [room].
n(room) --> [room].

d --> [the].
v --> [is].

% john is a student 
% all of the above is true, plus these rules:

% n --> [john].
n(john) --> [john].

% n --> [student].
n(student) --> [student].

d --> [a].

% vp --> v, np.
% vp -- v, np(X).
vp --> v(V), np(N).

% mary is a student 
% all of the above is true, plus:

% n --> [mary].
n(mary) --> [mary].

% john entered the room 
% plus:

v --> [entered].

%mary entered the room
% nothing needs to added to the grammar for this sentence. It can already parse it.

/* the final grammar rules would be these:

s --> np, vp.
vp --> v, adj.
vp --> v, np.
np --> d, n.

adj --> [empty].
n --> [room]; [john]; [student]; [mary].
d --> [the]; [a].
v --> [is]; [entered].

*/

% you can run each of the above sentences against this grammar to see the result for yourself:
% ?- s([the,room,is,empty],[]).
% at this stage, the output would only be true or false.
% note that in querying we always switch back to the prolog notation rather than DCG, 
% because the variables are hidden in DCG notation and we can't explicitly give them values.

% try this now
% ?- s([mary, entered, the, room],[]).
% there is still one rule need to be added to the grammar in order to parse this one.
% see if you can spot it. if you can't, use trace to see where it fails.

% can you modify the grammar above to make it mandatory for every sentence to end in a period?
% if there is no period, parsing should fail.

% adding new vocabulary should be very easy. try this:
% mary is a child.

% can you now add a rule that can parse these:
% mary arrived to the room
% john returned to school
% don't forget to test your grammar on the same sentences 

% what about this one?
% mary and john are at home

% and this
% the dog and the cat are in the garden
% (this is the subject of slide 50 of the DCG slide set, 
% but try to do it yourself and test it yourself before looking at the slide)

/* adding a new sentence to the mix will not require more than a handful of rules:
"the flower is in the garden"

n --> [flower].
n --> [garden].
pp --> prep, np.
prep --> [in].
what else?

try the sentence after uncommenting this part to see if it parses.
*/

%------------------ 
% Here's an exercise to get you to think about using extra variables to DCG 
% and how that feature can be exploited to actually translate english sentences to prolog predicates

% imagine we want to construct new predicates based on the information in the sentences that we parse.
% for instance, if we read "john is a student", we want to record that information as this predicate: student(john)
% here's an example of how you can use an extra argument to produce that:

% first, extend the noun rule to return the actual noun it has encountered as an argument:
% n(student) --> [student].
%you need to do this for all n rules in order to have a consistent predicate. 
% remember adding a new argument changes the arity of a predicate and therefore its identity.
% n(flower) --> [flower].
% n(john) --> [john].
% and so on.

% now we modify the np rule to pass on this information:

% np(X) --> d, n(X).

% all the occurrences of np in other rules also need to modified to carry that argument, either as X or an unknown variable 
% for instance, the top level sentence rule will look like this
% s --> np(X), vp.
% and the instance of vp that has an np in it:
% vp --> v, np(X).

% now in order to recognize the case of "X is a student", we can explicitly check for it.
% if v is also modified in a similar fashion to n to pass on the actual it encounters, 
% the above rule will look like this
% vp --> v(V), np(N).
% now we can specify the particular case of student as a separate rule like this:
% vp(student(_)) --> v(is), np(student).
% and on the top level, we'll find out the value that goes inside student:
% s(student(N)) --> np(N), vp(student(_)).

% if you write a new grammar set with these rules and query it with ?- s(Meaning,[john, is, a, student],[]).
% the output will be 
% Meaning=student(john).
