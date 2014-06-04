/*
DCG for danish counting.

Test is made by pasting a prolog list of list of literals from
0 to 99 which is contained in dr-prolog.txt. Works like a charm.

The grammar is not needed to predictiv because Prolog is able to
backtrack to a right solution. With tracing in Prolog this is
noticable when my solution tests for every possible combination
of a "sentence" that is in the language until it finds the right
one.

The solution also works both ways.
*/

/*
This predicate takes a list of literals and returns a number.
Reverses the inputs because of the way the language is implemented.
The empty list means no Rest list according to SWI-prolog documentation.
*/

translateDansk(X, Y) :-
	dansk(Y, X, []).

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
en2ni(8)--> [otte].
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
tyve2halvfems(X) --> [halv], halvmult(Y), emfas(Z), {X is Z * Y - 10}.
tyve2halvfems(X) --> mult(Y), emfas(Z), {X is Z * Y}.

mult(3) --> [tres].
mult(4) --> [firs].
mult(4) --> [fjerds].

halvmult(X) --> mult(X).
halvmult(5) --> [fems].

emfas(20) --> [].
emfas(20) --> [sindstyve].

testTranslation([]).
testTranslation([First|Rest]) :-
	translateDansk(First, Translated),
	write(Translated), write(','),
	testTranslation(Rest).