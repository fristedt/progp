link(p0, p1, 5).
link(p1, p2, 2).
link(p1, p3, 4).
link(p2, p1, 2).
link(p2, p3, 6).

path(X, X, 0).
path(X, Y, Distance) :- 
  link(X, Y, Distance).

path(X, Y, Distance) :-
  link(X, Z, D1),
  path(Z, Y, D2),
  Distance is D1 + D2.
