compile using: 

=> erlc progp.erl utils.erl

=> erl

progp:bernoulli(N) || progp:bernoulliseq(N) || progp:bernoulliconcurrent(N)

-----------------------------------------------------------
Now there's also a new way to run the program.

=> erlc progp.erl utils.erl

=> chmod +x run

=>./run N

Will spawn N number of erlang processes (concurrently) and wait for all the
processes to finish before quiting the program.