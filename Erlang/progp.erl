%Several functions for progp X2
-module(progp).
-date('4/1-15').
-license('MIT').
-export([bernoulli/1,bernoulliseq/1]).

factorial(N) ->
    tail_factorial(N,1).

tail_factorial(0,M) ->
    M;
tail_factorial(N,M) when N > 0 ->
    tail_factorial(N-1,N*M).

% n is always 0 in the recursive definition.
bernoulli(0) ->
    1;
bernoulli(M) when is_integer(M) ->
    0 - lists:sum([binomial(M,K)* (bernoulli(K)/(M-K+1)) || K <- lists:seq(0,M-1)]).

bernoulliseq(M) when is_integer(M) ->
    [bernoulli(N) || N <- lists:seq(0,M)].

binomial(N,K) when is_number(N), is_number(K) ->
    factorial(N) div (factorial(N-K) * factorial(K)).
