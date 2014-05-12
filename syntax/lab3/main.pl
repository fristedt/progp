% Becaues Prolog has backtracking, the grammar does not need to be
% predictive. This makes the grammar neater than the one in S2. For
% example, in S2 we need to suffix en2ni with "mer", because we do
% not know if it is "en" or "en og tyve". We do not need this in S3 because if
% we find more after "en", we can just backtrack and try again.
% 
% The solution works both ways.
%
% Assignment wants first argument to be a list of terminals and the
% second argument the integer the terminals represent. Really just a
% wrapper for phrase/2.
param_swap(Terminals, Integer) :- 
  phrase(dansk(Integer), Terminals).

% Credit for main and read_file goes to Ishq of Stack Overflow.
% Used to read test data. Should output 0..99.
main :-
  open('dr.txt', read, Str),
  read_file(Str, Integers),
  close(Str),
  write(Integers), nl.

read_file(Stream,[]) :-
  at_end_of_stream(Stream).

read_file(Stream,[H|L]) :-
  \+ at_end_of_stream(Stream),
  read(Stream, X),
  param_swap(X, H),
  read_file(Stream, L).

dansk(0) --> [nul].
dansk(X) --> en2ni(X).
dansk(X) --> ti2nitten(X).
dansk(X) --> en2ni(Y), [og], tyve2halvfems(Z), {X is Y + Z}.
dansk(X) --> tyve2halvfems(X).

en2ni(1) --> [en].
en2ni(1) --> [et].
en2ni(2) --> [to].
en2ni(3) --> [tre].
en2ni(4) --> [fire].
en2ni(5) --> [fem].
en2ni(6) --> [seks].
en2ni(7) --> [syv].
en2ni(8) --> [otte].
en2ni(9) --> [ni].

ti2nitten(10) --> [ti].
ti2nitten(11) --> [ellve].
ti2nitten(12) --> [tolv].
ti2nitten(13) --> [tretten].
ti2nitten(14) --> [fjorten].
ti2nitten(15) --> [femten].
ti2nitten(16) --> [seksten].
ti2nitten(17) --> [sytten].
ti2nitten(18) --> [atten].
ti2nitten(19) --> [nitten].

tyve2halvfems(20) --> [tyve].
tyve2halvfems(30) --> [tredive].
tyve2halvfems(40) --> [fyrre].
tyve2halvfems(40) --> [fyrretyve].
tyve2halvfems(X) --> [halv], halvmult(Y), emfas(Z), {X is (-0.5+Y) * Z}.
tyve2halvfems(X) --> mult(Y), emfas(Z), {X is Y * Z}.

mult(3) --> [tres].
mult(4) --> [firs].
mult(4) --> [fjerds].

halvmult(X) --> mult(X).
halvmult(5) --> [fems].

emfas(20) --> [sindstyve].
emfas(20) --> [].
