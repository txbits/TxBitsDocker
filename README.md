# TxBits Docker

This is an example Docker Compose deployment of TxBits.

Usage:

```
make up
make db_init
```

DO NOT USE THIS DIRECTLY

It's not secure, it's not easily configurable and does not scale. I will be working more on improving it over time. Pull requests are welcome.

* [x] add containers for coins
* [ ] remove db admin permissions from frontend
* [ ] a script for generating/configuring secrets
* [ ] configure the database to use volume defined in the base dockerfile
* [ ] switch whatever we can to alpine
* [ ] consider separating the configure and build targets for bitcoind/litecoind
* [ ] better non-root user isolation
* [x] get rid of `--with-incompatible-bdb` and `--disable-hardening` flags
* [ ] build custom images for db and lb that include the config files instead of bind mounting them
* [ ] firewall everything from each other? or not and rely only on secrets? ssl? one network per connection?
* [ ] make config more complete (remove hardcoded localhost, etc.)
* [ ] make this work on docker 1.12 swarm, service discovery, routing mesh, health checks, scaling, etc.
* [ ] set up automatic backups?
* [ ] figure out a good way to deploy on docker securely without allowing for container escapes
  * [ ] which distro?
  * [ ] which kernel?
  * [ ] apparmor?
  * [ ] seccomp?
  * [ ] selinux?
  * [ ] grsecurity?
* [ ] automatically detect if docker escapes are possible
