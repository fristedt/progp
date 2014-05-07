link(p0, p1, 5).
link(p1, p2, 2).
link(p2, p1, 2).
link(p1, p3, 4).
link(p3, p1, 4).
link(p2, p3, 6).
link(p3, p4, 3).
link(p4, p5, 3).

% Uppgift 3 */

% shortestWay(+From, +To, ?Distance, ?Path) */
shortestWay(From, To, Distance, Path):-
	shortestWay(From, To, Distance, Path, 0).
	
% Basfall shortestway */
% shortestWay(+From, +To, ?Distance, ?Path, ?Distance) */
shortestWay(From, To, Distance, Path, Distance):-	
	graphSearch(From, To, Distance, Path, [From]).
 
 % shortestWay(+From, +To, ?Distance, ?Path, ?Max) */
 shortestWay(From, To, Distance, Path, Max):-
	NewMax is Max + 1,	
	shortestWay(From, To, Distance, Path, NewMax).
	

% Basfall */
% graph_search(+From, +To, -Distance, ?Path, ?_) */
graphSearch(From, To, Distance, [From,To], _):- 
	link(From, To, Distance).
	
% Rekursion */
% graph_search(+From, +To, -Distance, ?Path, ?Visited) */
graphSearch(From, To, Distance,[From|Path], Visited):- 	
	link(From, X, D1),	
	\+member(X,Visited),
	graphSearch(X, To, D2, Path, [X|Visited]),
	Distance is D1 + D2.

	

%Test*/
% Finds the distance between From and To and prints it out. */
% find_way(+From, +To) */
find_way(From, To):-
	statistics(runtime, _),
	shortestWay(From, To, Distance, Path),
	statistics(runtime, [_, Time]),
	format("Way found for ~w->~w (~w) and the distance is ~w (found in ~w ms).", 
	[From, To, Path, Distance, Time]), nl.

% Tests. */
test1:- find_way(p0, p1).
test2:- find_way(p0, p2).
test3:- find_way(p0, p3).
test4:- find_way(p0, p5).
test5:- find_way(p0, p1), find_way(p0, p2), find_way(p0, p3), find_way(p0, p5). 


% Utskrifter tester */
%# | ?- test5.
%# Way found for p0->p1 ([p0,p1]) and the distance is 5 (found in 0 ms).
%# Way found for p0->p2 ([p0,p1,p2]) and the distance is 7 (found in 0 ms).
%# Way found for p0->p3 ([p0,p1,p3]) and the distance is 9 (found in 0 ms).
%# Way found for p0->p5 ([p0,p1,p3,p4,p5]) and the distance is 15 (found in 0 ms).
%# yes
