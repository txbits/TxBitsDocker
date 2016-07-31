# TxBits Docker

This is an example Docker Compose deployment of TxBits.

DO NOT USE THIS DIRECTLY

It's not secure, it's not easily configurable and does not scale. I will be working more on improving it over time. Pull requests are welcome.

* [x] add containers for coins
* [ ] a script for generating/configuring secrets
* [ ] better non-root user isolation
* [ ] remove db admin permissions from frontend
* [ ] firewall everything from each other? or not and rely only on ssl?
* [ ] make this work on docker swarm with each service on a different machine; this might require putting the config templates into the docker images, but it would be nice if the config wasn't in docker images. Maybe there's some better way to distribute configs, like etcd...
* [ ] make config more complete (remove hardcoded localhost, etc.)
* [ ] remove implicit references to the "project" name?
* [ ] figure out how to scale automatically - do we have to not use nginx? should we use etcd?
* [ ] figure out how to deploy with swarm easily
* [ ] consider making the local spiped encryption sockets use unix domain sockets?
* [ ] set up automatic backups?
* [ ] figure out a good way to deploy on docker securely without allowing for container escapes
  * [ ] which distro?
  * [ ] which kernel?
  * [ ] apparmor?
  * [ ] seccomp?
  * [ ] selinux?
  * [ ] grsecurity?
* [ ] figure out swarm security
  * [ ] service to service encryption?
  * [ ] secrets distribution?
  * [ ] firewalls?
