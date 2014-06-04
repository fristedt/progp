:- use_module(library(clpfd)).


% Generate a vector containing N unbound variables.
gen_var(0, []) :- !. 
gen_var(N, [X|Xs]) :- 
        N > 0, 
        M is N-1, 
        gen_var(M, Xs), 
        X in 0..1.

% From a vector I = [X, Y, Z] and a list of genes and their compatible primers,
% Generate sparse matrix J with the compatible primers:

% J = [
%      [ X ],
%      [ Y, Z ],
%      [ X, Z ]
%     ]
gen_matrix([], _, []).
gen_matrix([pri(GeneName, Primers)|Genes], I, [Ji|J]) :-
	gen_row(Primers, I, Ji),
	gen_matrix(Genes, I, J).

% From some primers P = [ 1, 3 ...]
% From a vector of unbound vars I = [ X, Y, Z ...]
% Generate the row of selected ubound variables
% M = [X, Z ...]
gen_row([],_,[]).
gen_row([Primer|Primers], I, [Mo|M]) :-
	nth1(Primer, I, Mo),
	gen_row(Primers, I, M).


% Choose the smallest set of primers that satisfy all the supplied
% genes.
choose_primer(TotalNumberOfPrimers, GeneList, SelectedPrimers) :-
	gen_var(TotalNumberOfPrimers, I),
	gen_matrix(GeneList, I, J),
	genes_have_primer(J),
	sum(I, #=, S),
	labeling([min(S)], I),
	SelectedPrimers = I.

% Demand that all genes have atleast one primer.
genes_have_primer([]).

genes_have_primer([Gene|RestOfGenes]) :-
	sum(Gene, #>, 0),
	genes_have_primer(RestOfGenes).