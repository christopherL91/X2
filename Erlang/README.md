compile using: 
=> erlc progp.erl utils.erl
=> erl
progp:bernoulli(N) OR progp:bernoulliseq(N) OR progp:bernoulliconcurrent(N)

Now there's also a new way to run the program.

chmod +x run
./run N

will spawn N number of erlang processes (concurrently) and wait for all the
processes to finish before quiting the program.