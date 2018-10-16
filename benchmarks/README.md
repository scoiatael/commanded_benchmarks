## Setup

* Initialize EventStore
```
mix do event_store.create, event_store.init
```

## System

```
CPU Information: Intel(R) Core(TM) i7-5557U CPU @ 3.10GHz
Number of Available Cores: 4
Available memory: 16 GB
Elixir 1.7.3
Erlang 21.1.1

```

### With warmup:

```
mix run benchmarks/issue_command_warmup.ex
```

##### With input Big (10k) #####
Name                  ips        average  deviation         median         99th %
with warmup          2.76      362.68 ms    ±14.60%      374.77 ms      552.73 ms

##### With input Middle (1k) #####
Name                  ips        average  deviation         median         99th %
with warmup         15.70       63.69 ms    ±11.40%       61.94 ms      103.34 ms

##### With input Small (100) #####
Name                  ips        average  deviation         median         99th %
with warmup        140.50        7.12 ms    ±24.55%        6.68 ms       12.72 ms

### Without warmup:

```
mix run benchmarks/issue_command_no_warmup.ex
```

##### With input Big (10k) #####
Name                     ips        average  deviation         median         99th %
without events          3.30      302.86 ms     ±6.91%      304.86 ms      352.54 ms
with events             1.64      609.10 ms   ±322.52%      390.70 ms    16323.44 ms

Comparison:
without events          3.30
with events             1.64 - 2.01x slower

##### With input Middle (1k) #####
Name                     ips        average  deviation         median         99th %
without events         16.07       62.22 ms     ±2.98%       61.90 ms       69.53 ms
with events            14.63       68.34 ms   ±205.37%       62.18 ms       72.28 ms

Comparison:
without events         16.07
with events            14.63 - 1.10x slower

##### With input Small (100) #####
Name                     ips        average  deviation         median         99th %
with events           148.13        6.75 ms    ±64.98%        6.56 ms        8.55 ms
without events        148.01        6.76 ms    ±11.55%        6.61 ms        8.89 ms

Comparison:
with events           148.13
without events        148.01 - 1.00x slower

