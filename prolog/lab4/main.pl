:- use_module(library(clpfd)).

% Returns N binary indicator variables. Credit goes to author of assignment.
gen_var(0, []). 
gen_var(N, [X|Xs]) :- 
  N > 0, 
  M is N-1, 
  gen_var(M, Xs), 
  X in 0..1. % The domain of X is constrained to 0/1

% We get the sum of our indicator variables and tell Prolog to give us the
% solution with the smallest sum first.
choose_primers(NumberOfPrimers, Genes, RecommendedPrimersByPrologCLPFD) :- 
  gen_var(NumberOfPrimers, I),
  iterate_genes(Genes, I),
  sum(I, #=, S),         
  labeling([min(S)], I),
  get_indices_of_ones(1, I, RecommendedPrimersByPrologCLPFD). 

% Iterate over the genes given in the first argument and ensure that all genes
% have at least one primer chosen.
iterate_genes([], _).
iterate_genes([pri(_, Primers)|Tail], I) :-
  primer_indicators(Primers, I, Indicators),
  sum(Indicators, #>=, 1),
  iterate_genes(Tail, I).

% Given a list of integers and a list of indicator variables this returns the
% indicator variables placed at the indices given in the integer list.
primer_indicators([], _, []).
primer_indicators([Primer|Tail], I, [Indicator|Indicators]) :-
  element(Primer, I, Indicator),
  primer_indicators(Tail, I, Indicators).

% Returns the indices where ones are placed in the given list.
get_indices_of_ones(_, [], []).
get_indices_of_ones(N, [0|Tail], List) :-
  M is N + 1,
  get_indices_of_ones(M, Tail, List).
get_indices_of_ones(N, [1|Tail], [N|List]) :-
  M is N + 1,
  get_indices_of_ones(M, Tail, List).


