t9(Code, Tree, Word) :-
	decode(Code, Tree, Word).

decode([], _, []).
decode([Digit|Code], Tree, [Char|Word]):-
	digit_char(Digit, Char),
	memberchk(branch(Char, Sub), Tree),
	decode(Code, Sub, Word).

insert_word([], _).
insert_word([Char|Word], Tree):-
	memberchk(branch(Char, Branches), Tree), !,
	insert_word(Word, Branches).

insert_all([], _).
insert_all([Word|Words], Tree) :-
	insert_word(Word, Tree),
	insert_all(Words, Tree).

done([]):- !.
done([branch(_, Branches)|Rest]):-
	done(Branches),
	done(Rest).

build(Words, Tree) :-
	insert_all(Words, Tree),
	done(Tree).

test:-
	words(Words),
	statistics(runtime,_),
	build(Words, Tree),!,
	statistics(runtime,[_,Build]),
	t9([3,2,7,8, 4], Tree, Word),
	statistics(runtime,[_, Time]),
	format("one solution is \"~s\", found in ~w ms, (building of tree in ~w ms)~n" ,[Word, Time, Build]).

% test :-
% 	T = [branch(0'd, [branch(0'o, []),
% 			  branch(0'i, [])]),
% 	     branch(0'r, [branch(0'e, [branch(0'm, [])])])],
% 	decode([7, 3, 6], T, W),
% 	write(W).
