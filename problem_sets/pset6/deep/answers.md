# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

TODO
### Reasons to adopt
This form of partitioning avoids partition underutilization and partition overutilization by enforcing even data distribution.

### Reasons not to adopt
Poor time locality, as time-range queries (for example, queries from midnight to 1 a.m) need to access all the boats.

Also is more difficult to backup / restore data of a single time range without touching all the servers.


## Partitioning by Hour

TODO
### Reasons to adopt
A single partition (boat), is required in order to search
for data by hours (or by a range of hours that falls (range) in the same boat).

### Reasons not to adopt
Data is stored in an imbalanced form, as most boats are underutilized while a single boat captures majority of the data (overutelized boat).

It is likely a boat becomes a bottleneck (slower due to overutilization) during the peak hour (from midnight to 1 a.m).

## Partitioning by Hash Value

TODO
### Reasons to adopt
The data is distributed evenly, avoiding overutelization or underutelization of partitions (boats).

It is always possible to know the hash value associated with a specific timestamp (deterministic placement).

### Reasons not to adopt
Time-range queries (for example, queries from midnight to 1 a.m) need to access all the boats (poor time locality).
