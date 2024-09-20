#MySQL component monitoring does not produce a picture

1. Check whether the IP monitored by MySQL is consistent with the filled in target IP
2. Check whether the IP of the created user is consistent with the filled in target IP
3. If MySQL is listening to a local IP, please use 10.0.0.1 when creating a user and avoid using loccalhost. i.e. `bk@10.0.0.1` instead of `bk@localhost`