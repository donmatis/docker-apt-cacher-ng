# Docker Ubuntu 18.04 Apt-Cacher-NG

A simple approach to ubuntu 18.04 running apt-cacher-ng.

_Heavily based on https://github.com/sameersbn/docker-apt-cacher-ng_

---

For docker swarm you can use the example file, then on hosts add the file `/etc/apt/apt.conf.d/02proxy` or any name you want using `01` or `02` in the front, with the following contents:

```sh
Acquire::http { Proxy "http://docker-swarm-node-hostname:3142"; }
```
