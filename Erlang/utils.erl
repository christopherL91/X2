% The MIT License (MIT)

% Copyright (c) 2015 Christopher Lillthors

% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.

-module(utils).
-date('5/1-15').
-author('Christopher Lillthors').
-license('MIT').
-export([factorial/1,binomial/2]).

factorial(N) when is_integer(N) ->
    tail_factorial(N,1).

tail_factorial(0,M) ->
    M;
tail_factorial(N,M) ->
    tail_factorial(N-1,N*M).

binomial(N,K) when is_integer(N), is_integer(K) ->
    factorial(N) div (factorial(N-K) * factorial(K)).