
%%%%%%%%%%%%%%%%%%%%%%%%%% 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Need to import wn_s.pl and wn_g.pl.
:- consult('wn/wn_s.pl').
:- consult('wn/wn_g.pl').

% definition(Word, Meaning) is true if Word is a word in WordNet with
% the meaning Meaning.  Either or both may be non-ground although the
% predicate is inefficient if Word is non-ground.
definition(Word, Meaning) :- 
	s(ID, _, Word, _, _, _),
	g(ID, Meaning).


%%%%%%%%%%%%%%%%%%%%%%%%%% 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Need to import pronto_morph_engine.pl.
:- consult('312-pess-grammar.pl')
:- consult('prontomorph/pronto_morph_engine.pl').

% word_line_morphs reads in a word (assumes one word before a period)
% and uses ProNTo_Morph to stem the word, printing out the results.
word_line_morphs :- 
	read_sentence([Word|_]), !, 
	morph_atoms_bag(Word, Morphs),
	write(Morphs), nl.

% Many other solutions exist, some cleaner and clearer. This one is
% probably the easiest to write :)

%%%%%%%%%%%%%%%%%%%%%%%%%% 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add to 312-pess.pl just after the "process(['rule:'..." line
process(['words:'|L]) :-    % Found a vocab statement.
        vocab(V,L,[]),      % Parse the new vocabulary.
        bug(V),             % Print it for debugging.
        assert_rules(V), !. % Assert it (them, potentially) in the DB.

% Note that you could also have directly asserted the new vocabulary
% into the database while parsing it, but this seems a less modular
% solution to me than parsing out the vocabulary's meaning and then
% separately asserting it into the database. 

% Add to 312-pess-grammar.pl in its own section:

% A new set of vocabulary can be a single "sentence" defining a word 
% or multiple such "sentences" connected by an optional "and". 
vocab([Word]) --> word(Word).
vocab([Word|Words]) --> word(Word), vocab(Words).

% A word "sentence" is a new word followed by "is a", either or 
% both of which may be missing, followed by a part of speech.
% build_word_term uses functor and arg to build up the part of
% speech into an appropriate predicate, but there are other 
% solutions as well.
word(WordTerm) --> [Word], opt_is, opt_a_an, part_of_speech(POS),
	{ build_word_term(WordTerm, Word, POS) }.

opt_is --> [is].
opt_is --> [].

opt_a_an --> [a].
opt_a_an --> [an].
opt_a_an --> [].

part_of_speech(n)   --> [noun].
part_of_speech(v)   --> [verb].
part_of_speech(adj) --> [adjective].
part_of_speech(adv) --> [adverb].

% Given a ground part of speech, build_word_term(WordTerm, Word, POS)
% is true if WordTerm is of the form Word(POS).
build_word_term(WordTerm, Word, POS) :- 
	functor(WordTerm, POS, 1),
	arg(1, WordTerm, Word).

% Now, try changing around bird.kb.  For example, you could add:
% 
% word: tubenose is a noun.
%
% That should let you change rules like:
%
% rule:
% if   its nostrils are external and tubular and 
%      it lives "n:at sea" and 
%      its bill is hooked 
% then its order is "n:tubenose".
%
% to:
%
% rule:
% if   its nostrils are external and tubular and 
%      it lives "n:at sea" and 
%      its bill is hooked 
% then its order is tubenose.
%
% (Note that tubenose is now just a regular word like the rest.)

%%%%%%%%%%%%%%%%%%%%%%%%%% 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% simplify_attr(AC, AS) is true if AS is the simple version of AC as
% defined in the project handout. Assumes a ground AC.

% General strategy: describe each of the 5 rules of simplification,
% recursively simplifying at each step.

%%%%%%%%% rules %%%%%%%%%%%%%

% A rule with no body is a fact.  Simplify the head recursively.
simplify_attr(rule(HC, []), fact(HS)) :- simplify_attr(HC, HS).

% A rule with one body clause drops the brackets.
% Simplify head and body recursively.
simplify_attr(rule(HC, [BC]), rule(HS, BS)) :-
	simplify_attr(HC, HS),
	simplify_attr(BC, BS).

% A rule with many body clauses does not simplify at the top level,
% but still must simplify recursively.
simplify_attr(rule(HC, BCs), rule(HS, BSs)) :-
	BCs = [_, _ | _],      % 0 and 1 element lists already handled.
			       % Insist on 2 or more.
			       % Because this is not done in the head,
			       % a carefully placed cut in the previous
			       % simplify_attr rule might improve
			       % efficiency.  Do you understand why?
	simplify_attr(HC, HS),
	simplify_attr(BCs, BSs).

%%%%%%%%%% lists of stuff %%%%%%%%%%%

% Just recursively simplify the contents of lists.
simplify_attr([], []).
simplify_attr([C|Cs], [S|Ss]) :-
	simplify_attr(C, S),
	simplify_attr(Cs, Ss).

%%%%%%%%%% attr/3 --> attr/2 %%%%%%%%%%%%%

% Changing attr(X, Y, Z) to attr(X(Y), Z) is the only step that 
% requires the functor and arg predicates, and the only step
% that you should use them!
simplify_attr(attr(X, Y, ZC), SimpleAttr) :-
	% Build X(Y).
	functor(XYTerm, X, 1),    % The functor is X/1.
	arg(1, XYTerm, Y),        % The single argument is Y.
	
	% Recursively simplify.  Note that simplification of ZC
	% is left to later steps.
	simplify_attr(attr(XYTerm, ZC), SimpleAttr).

%%%%%%%%%% attr/2 %%%%%%%%%%%%%

% Empty attribute lists drop the whole attr/3 bit.
% Note, however, that at no point is something without either
% an attr or rule functor (or a list) the first argument of
% simplify_attr; so, there's no need for cases handling such
% beasts.
simplify_attr(attr(XY, []), XY).

% One element attribute lists drop the brackets
simplify_attr(attr(XY, [ZC]), attr(XY, ZS)) :-
	simplify_attr(ZC, ZS).

% Longer attribute lists are just recursively simplified.
simplify_attr(attr(XY, ZCs), attr(XY, ZSs)) :-	
	ZCs = [_, _ | _],      % 0 and 1 element lists already handled.
			       % Insist on 2 or more.
			       % Because this is not done in the head,
			       % a carefully placed cut in the previous
			       % simplify_attr rule might improve
			       % efficiency.  Do you understand why?
	simplify_attr(ZCs, ZSs).

