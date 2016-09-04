% CPSC 312 -- Assignment 3
% Brian Taylor
% 52311859
% z2b0b

word(dog, d, o, g).
word(run, r, u, n).
word(top, t, o, p).
word(five, f, i, v, e).
word(four, f, o, u, r).
word(lost, l, o, s, t).
word(mess, m, e, s, s).
word(unit, u, n, i, t).
word(baker, b, a, k, e, r).
word(forum, f, o, r, u, m).
word(green, g, r, e, e, n).
word(super, s, u, p, e, r).
word(prolog, p, r, o, l, o, g).
word(vanish, v, a, n, i, s, h).
word(wonder, w, o, n, d, e, r).
word(yellow, y, e, l, l, o, w).

solution(A1, A4, D1, D2, D3) :-
    word(A1, C11, _, C13, _, C15),
    word(A4, C31, _, C33, _, C35, _),
    word(D1, C11, _, C31, _),
    word(D2, C13, _, C33),
    word(D3, C15, _, C35, _).

% Output:

% ?- solution(A1, A4, D1, D2, D3).

% A1 = forum,
% A4 = vanish,
% D1 = five,
% D2 = run,
% D3 = mess 

% I used more conventional crossword puzzle labeling (left-to-right, top-to-bottom)
% so A1 means 1-across, A4 means 4-across, D1 means 1-down, D2 means 2-down and
% D3 means 3-down.

% Then, in the solution rule I used row-column notation, so C11 refers to row 1,
% column 1 in the crossword, C35 refers to row 3, column 5, etc.

% The solution rule ensures that the cells that are common to two words contain the
% same letter.