# TxBits Docker

This is an example Docker Compose deployment of TxBits.

DO NOT USE THIS DIRECTLY

It's not secure, it's not easily configurable and does not scale. I will be working more on improving it over time. Pull requests are welcome.

* [ ] a script for generating/configuring secrets
* [ ] remove admin permissions from frontend
* [ ] firewall everything from each other - iptables?
* [ ] test with docker swarm
* [ ] make config more complete (remove hardcoded localhost, etc.)
* [ ] remove implicit references to the "project" name
* [ ] add containers for coins
* [ ] figure out how to scale automatically - do we have to not use nginx?
* [ ] figure out how to deploy with swarm easily
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
