:- use_module(library(clpfd)).

% Choose the optimal set of primers.
%
% choose_primer(2, [pri(a, [1, 2]), pri(b, [1, 2])], BestSolution).
% BestSolution = [1]
choose_primer(N, Primers, BestSolution) :-
  gen_var(N, I),           % generate a list of primer usage indicators
  gen_primers(Primers, I), % choose a primer for each gene
  sum(I, #=, Sum),         % calculate the number of used indicators
  labeling([min(Sum)], I), % minimize the number of used indicators
  indicators_to_primers(I, BestSolution).

gen_var(0, []). 
gen_var(N, [X|Xs]) :- 
  M is N-1, 
  gen_var(M, Xs), 
  X in 0..1.

% Select a arbitrary primer from the list of accessible primers for each given
% gene. The corresponding primer indicator will be flagged as used. Since a
% gene can have more than one primer the process of selecting one at random can
% have many outcomes.
%
%   gen_primers([pri(a, [1, 2], [0..1, 0..1]).
gen_primers([], _).
gen_primers([pri(_, Primers)|Ps], I) :-
  element(_, Primers, Primer),   % select a arbitrary primer for the given gene
  element(Primer, I, Indicator), % select the corresponding primer indicator
  Indicator = 1,                 % flag the indicator as used
  gen_primers(Ps, I).            % continue

% Format a list of indicators into a list of primers. All non used primers will
% be removed. Each indicator list index is equal to the actual primer.
%
%   indicators_to_primers([1, 0, 1], Primers).
%   Primers = [1, 3]
indicators_to_primers(Indicators, Primers) :-
  indicators_to_primers(0, Indicators, Primers).
indicators_to_primers(_, [], []).
indicators_to_primers(N, [1|Is], [P|Ps]) :-
  P is N+1,
  indicators_to_primers(P, Is, Ps).
indicators_to_primers(N, [_|Is], Ps) :-
  P is N+1,
  indicators_to_primers(P, Is, Ps).
