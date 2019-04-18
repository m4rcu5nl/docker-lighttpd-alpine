
[![Docker Pulls](https://img.shields.io/docker/pulls/m4rcu5/lighttpd.svg)](https://hub.docker.com/r/m4rcu5/lighttpd/) [![Build Status](https://travis-ci.org/m4rcu5nl/docker-lighttpd-alpine.svg?branch=master)](https://travis-ci.org/m4rcu5nl/docker-lighttpd-alpine) [![GitHub issues](https://img.shields.io/github/issues/m4rcu5nl/docker-lighttpd-alpine.svg)](https://github.com/m4rcu5nl/docker-lighttpd-alpine/issues)

![](files/docker-lighttpd.png)    
The default build of this image is really just a clean install of lighttpd on Alpine Linux. The only change I made is adding minimal configuration for ssl and include a self signed certificate. Further customization magic should happen during docker run. Copies of the lighttpd config files can be found in `./config/lighttpd`.

Run examples
----
```
docker run \
	--detach \
	--name lighttpd \
	--mount type=bind,source=/etc/localtime,destination=/etc/localtime,readonly=true \
	--mount type=bind,source=$PWD/htdocs,destination=/var/www/localhost/htdocs \
	--publish 8080:80 \
	--publish 8443:443 \
	m4rcu5/lighttpd:latest
```
The above will start a detached container named _lighttpd_ with a bind-mount for `/etc/localtime` to match the container's timezone with it's host and a bind-mount for a host dir as webroot. It publishes port the container's port 80 as the host's port 8080 and container port 443 as the hosts port 8443.    

```
docker run \
	--detach \
	--name lighttpd \
	--mount type=bind,source=/etc/localtime,destination=/etc/localtime,readonly=true \
	--mount type=bind,source=$PWD/htdocs,destination=/var/www/localhost/htdocs \
	--mount type=bind,source=$PWD/config/lighttpd,destination=/etc/lighttpd,readonly=true \
	--publish 8080:80 \
	--publish 8443:443 \
	m4rcu5/lighttpd:latest
```
Pretty much the same as the previous example, only it mounts lighttpd config files from the host filesystem for extra customization. If you do this, either provide a valid ssl certificate as *config/lighttpd/ssl/localhost.pem* or update *lighttpd.conf* and/or *ssl.conf* to match your project.
