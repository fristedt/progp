link(p0, p1, 5).
link(p1, p2, 2).
link(p1, p3, 4).
link(p2, p1, 2).
link(p2, p3, 6).

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

%  path(p0, p1, 5). % True
%  \+ path(p10, p1, _). % True
%  \+ path(p0, p12, _). % True
%  \+ path(p21, p54, _). % True
