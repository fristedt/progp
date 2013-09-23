link(p0, p1, 5).
link(p1, p2, 2).
link(p1, p3, 4).
link(p2, p1, 2).
link(p2, p3, 6).

path(X, Y, Distance) :- 
  link(X, Y, Distance).

path(X, Y, Distance) :-
  link(X, _, _), % Make sure that the first value exists in a link.
  link(Z, Y, D1),
  path(X, Z, D2),
  Distance is D1 + D2.

test :-
  path(p0, p1, 5),
  \+ path(p10, p1, _),
  \+ path(p0, p12, _),
  \+ path(p21, p54, _).
