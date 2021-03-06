dhistory(
	b(
	    l(yeast),
	    b(
	          b(
		          l(fly),
		          l(mosquito)
		        ),
	          b(
		          l(frog),
		          b(
			    l(chicken),
			    b(
			        l(mouse),
			        b(
				      l(human),
				      l(chimp)
				    )
			      )
			          )
		        )
	        )
	  )).

tree1(l(enkelt)).
tree2(b(l(1),l(2))).
tree3(b(l(1),b(l(2),l(3)))).
tree4(b(b(l(1),l(2)), b(l(3), l(4)))).
tree5(b(l(1), b(l(2), b(l(3),b(l(4),l(5)))))).
tree6(b(b(l(1), b(l(2), b(l(3),b(l(4), l(5))))),
	b(l(6), b(l(7), b(l(8),b(l(9), l(10))))))).


writetree(T) :- writetree(T, 0).
writetree(l(X), N) :-
	indent(N),
	write(X).
writetree(b(X,Y), N) :-
	indent(N),
	write('('), nl,
	Next is N + 2,
	writetree(X, Next),
	write(', '), nl,
	writetree(Y, Next), nl,
	indent(N),
	write(')').

indent(0).
indent(N) :- N>0, write(' '), Next is N-1, indent(Next).

% Uppgift 1.
count_leaves(l(_), N) :-
	N is 1.
count_leaves(b(B1, B2), N) :-
	count_leaves(B1, N1),
	count_leaves(B2, N2),
	N is N1 + N2.

% Uppgift 2.
leaves(l(X), L) :- L = [X].
leaves(b(B1, B2), L) :-
	leaves(B1, L1),
	leaves(B2, L2),
	append(L1, L2, L).

% Uppgift 3.
build_tree(L, T) :-
	leaves(T, L).

% Uppgift 4.
height(l(_), H) :-
	H is 1.
height(b(B1, B2), H) :-
	height(B1, H1),
	height(B2, H2),
	max(H1, H2, H3),
	H is H3 + 1.

% Assigns the larger value of A and B to O.
max(A, B, O) :-
	A >= B,
	O = A.

max(A, B, O) :-
	A =< B,
	O = B.

% Uppgift 5.
balanced(l(_)).
balanced(b(B1, B2)) :-
	balanced(B1),
	balanced(B2),
	height(B1, H1),
	height(B2, H2),
	abs(H1 - H2) =< 1.

	
