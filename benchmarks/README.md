## Setup

* Initialize EventStore
```
mix do event_store.create, event_store.init
```


## `issue_command.ex`

Issues simple command, generating one event. Each command lands in different aggregate. Compares sequential vs concurrent versions.

Scenarios differ by providing different `warmup` argument to `Benchee` and different `mix.exs` `erlc_options`.

### With warmup:

##### With input Big (10k) #####
Name                   ips        average  deviation         median         99th %
concurrently          3.11      321.73 ms    ±13.23%      315.77 ms      498.34 ms
sequentially          1.24      808.52 ms    ±11.66%      767.64 ms     1292.19 ms

Comparison:
concurrently          3.11
sequentially          1.24 - 2.51x slower

##### With input Middle (1k) #####
Name                   ips        average  deviation         median         99th %
concurrently         14.11       70.87 ms    ±14.93%       67.70 ms      112.10 ms
sequentially         14.11       70.89 ms    ±23.93%       65.46 ms      142.41 ms

Comparison:
concurrently         14.11
sequentially         14.11 - 1.00x slower

##### With input Small (100) #####
Name                   ips        average  deviation         median         99th %
sequentially        152.96        6.54 ms    ±37.52%        6.04 ms       12.30 ms
concurrently        127.97        7.81 ms    ±29.80%        7.08 ms       16.17 ms

Comparison:
sequentially        152.96
concurrently        127.97 - 1.20x slower

### Without warmup:

```
mix run benchmarks/issue_command_no_warmup.ex
```

### With compilation:
