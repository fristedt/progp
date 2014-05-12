:- use_module(library(clpfd)).

gen_var(0, []). 
gen_var(N, [X|Xs]) :- 
  N > 0, 
  M is N-1, 
  gen_var(M, Xs), 
  X in 0..1. % The domain of X is constrained to 0/1

choose_primers(NumberOfPrimers, Genes, I) :- 
  gen_var(NumberOfPrimers, I),
  iterate_genes(Genes, I),
  sum(I, #=, S),
  labeling([min(S)], I).

iterate_genes([], _).
iterate_genes([pri(_, Primers)|Tail], I) :-
  length(Primers, Length),
  primer_indicators(Primers, I, Indicators),
  sum(Indicators, #=, 1),
  iterate_genes(Tail).

primer_indicators([], _, _).
primer_indicators([Primer|Tail], I, [Indicator|Indicators]) :-
  element(Primer, I, Indicator),
  primer_indicators(Tail, I, Indicators).


