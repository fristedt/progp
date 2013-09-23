digit_char(2,0'a). %97
digit_char(2,0'b). 
digit_char(2,0'c). 
digit_char(3,0'd). %100
digit_char(3,0'e).
digit_char(3,0'f).
digit_char(4,0'g). %103
digit_char(4,0'h).
digit_char(4,0'i).
digit_char(5,0'j). %106
digit_char(5,0'k).
digit_char(5,0'l).
digit_char(6,0'm). %107
digit_char(6,0'n).
digit_char(6,0'o).
digit_char(7,0'p). %110
digit_char(7,0'q).
digit_char(7,0'r).
digit_char(7,0's). 
digit_char(8,0't). %114
digit_char(8,0'u).
digit_char(8,0'v). 
digit_char(9,0'w). %117
digit_char(9,0'x). 
digit_char(9,0'y).
digit_char(9,0'z).

t9(Code, Words, Word) :-
	decode(Code, Words, Word),
	member(Word, Words). % FUSK

decode([], _, []).
decode([Digit|Code], Words, [Char|Word]):-
	digit_char(Digit, Char),
	memberchk([Char|_], Words), 
	filter(Words, Char, Filtered),
	decode(Code, Filtered, Word).

filter([], _, []).
filter([[Char|Word]|Rest], Char, [Word|Filtered]) :-
	filter(Rest, Char, Filtered), !.
filter([_|Rest], Char, Filtered) :-
	filter(Rest, Char, Filtered).

test:-
	words(Words),
	statistics(runtime,_),
	t9([3, 2, 7, 8, 4], Words, Word),
	statistics(runtime,[_, Time]),
	format("one solution is \"~s\", found in ~w ms~n" ,[Word, Time]).

test2 :-
	A = [[2, 1, 4, 6], [2, 5, 4, 6], [4, 3, 5, 9]],
	X = [1|_],
	memberchk(X, A).

	
