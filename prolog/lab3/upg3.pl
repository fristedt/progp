link(p0, p1, 5).
link(p1, p2, 2).
link(p1, p3, 4).
link(p2, p1, 2).
link(p2, p3, 6).
link(p1, p4, 8).
link(p0, p5, 4).

shortest_path(X, Y, Distance) :-
  shortest_path(X, Y, Distance, 0).

shortest_path(X, Y, Distance, Counter) :-
  C1 is Counter + 1,
  find(X, Y, C1),
  Distance = C1.

shortest_path(X, Y, Distance, Counter) :-
  C1 is Counter + 1,
  \+ find(X, Y, C1),
  shortest_path(X, Y, Distance, C1).
  
% Wrapper to abstract the list of visited nodes from the user.
find(X, Y, Distance) :-
  find(X, Y, Distance, []).

% Base case.
find(X, Y, Distance, _) :-
  link(X, Y, Distance).

% Recursion.
find(X, Y, Distance, Visited) :-
  \+ member(X, Visited),
  link(X, Z, D1),
  find(Z, Y, D2, [X|Visited]),
  Distance is D1 + D2.
