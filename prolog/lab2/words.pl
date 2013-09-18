words(Words):-
	words('words.txt', Words).

words(Source, Words):-
	open(Source, read, In),
	read_words(In, Words),
	close(In).

read_words(In, Words):-
	get_code(In, Char),
	read_words(Char, In, Words).

read_words(-1, _In, []):- !. % EOF
read_words(Char, In, Words):-
	read_words(Char, Word, Word, In, Words).

read_words(10, [], Word, In, [Word|Words]):- !,
	read_words(In, Words).
read_words(Char, [Char|Rest], Word, In, Words):-
	get_code(In, Next),
	read_words(Next, Rest, Word, In, Words).
