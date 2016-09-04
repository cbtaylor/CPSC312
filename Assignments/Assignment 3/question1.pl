% CPSC 312 -- Assignment 3
% Brian Taylor
% 52311859
% z2b0b

% I was not able to finish this problem.
% Please do not grade this problem.
% I've included it because the assignment specified that the submission
% should include three files.

equi(o, o).
equi(fortuna, fortune).
equi(velut, as).
equi(luna, 'the moon').
equi(statu, 'you are').
equi(variabilis, changeable).
equi(semper, ever).
equi(crescis, waxing).
equi(aut, or).
equi(decrescis, waning).
equi(vita, life).
equi(detestabilis, hateful).
equi(nunc, now).
equi(obdurat, oppresses).
equi(et, and).
equi(tunc, then).
equi(curat, soothes).
equi(egestatem, poverty).
equi(potestatem, power).
equi(dissolvit, melts).
equi(ut, like).
equi(glaciem, ice).

trans(Xs, Ys) :- maplist(equi, Xs, Ys).