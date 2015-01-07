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

-module(progp).
-date('4/1-15').
-author('Christopher Lillthors').
-license('MIT').
-import(utils,[factorial/1,binomial/2]).
-export([bernoulli/1,bernoulliseq/1,bernoulliconcurrent/1,bernoullidistributed/1,bernoulli_PID/2]).

% n is always 0 in the recursive definition.
% see wikipedia for reference.
bernoulli(0) ->
    1;
bernoulli(M) when is_integer(M) ->
    0 - lists:sum([binomial(M,K)* (bernoulli(K)/(M-K+1)) || K <- lists:seq(0,M-1)]).

bernoulliseq(M) when is_integer(M) ->
    [bernoulli(N) || N <- lists:seq(0,M)].

% Local concurrency
bernoulliconcurrent(M) when is_integer(M) ->
    Wait_pid = self(),
    Printer_PID = spawn(fun() -> printer(M,Wait_pid) end),
    [spawn(fun() -> Printer_PID ! {node(),bernoulli(N),N} end) || N <- lists:seq(0,M)],
    receive
        die ->
            io:format("Got all the numbers, will now quit program...~n"),
            true
    end.

% Private function.
bernoulli_PID(N,Printer_PID) when is_integer(N),is_pid(Printer_PID) ->
    Printer_PID ! {node(),bernoulli(N),N}.

% Distributed concurrency.
bernoullidistributed(M) when is_integer(M) ->
    Nodes = ['lillt@104.131.23.38'],
    %Connect to each node.
    [net_kernel:connect_node(Node) || Node <- Nodes],
    Wait_pid = self(), % PID to this process.
    Printer_PID = spawn(fun() -> printer(M,Wait_pid) end),
    lists:foreach(fun(Node) ->
        [spawn(Node,?MODULE,bernoulli_PID,[N,Printer_PID]) || N <- lists:seq(0,M)] end,
        Nodes
    ),
    receive
        die ->
            io:format("Got all the numbers, will now quit program...~n"),
            true
    end.

printer(N,Wait_pid) when is_integer(N), is_pid(Wait_pid) ->
    receive
	{Node,Value,Number} ->
        io:format("Node: ~p got value:~p from number ~p~n",[Node,Value,Number]),
        if
            N == 0 ->
                Wait_pid ! die,
                true;
            true ->
                printer(N-1,Wait_pid)
        end
    end.
