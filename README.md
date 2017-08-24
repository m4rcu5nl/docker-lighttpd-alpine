[![Build Status](https://travis-ci.org/m4rcu5nl/docker-lighttpd-alpine.svg?branch=master)](https://travis-ci.org/m4rcu5nl/docker-lighttpd-alpine) [![GitHub issues](https://img.shields.io/github/issues/m4rcu5nl/docker-lighttpd-alpine.svg)](https://github.com/m4rcu5nl/docker-lighttpd-alpine/issues)

docker-lighttpd-alpine
======================
The default build of this image is really just a clean install of lighttpd on Alpine Linux. Customization magic should happen during docker run. I should not be making configuration choices for you. Copies of the default lighttpd config files can be found in `./config/lighttpd`.

Run example
----
```
docker run -d --name lighttpd \
	--mount type=bind,source=/etc/localtime,destination=/etc/localtime,readonly=true \
	--mount type=bind,source=$PWD/htdocs,destination=/var/www/localhost/htdocs \
	-p 8080:80 m4rcu5/lighttpd:latest
```
The above will start a detached container named _lighttpd_ with a bind-mount for `/etc/localtime` to match the container's timezone with it's host and a bind-mount for a host dir as webroot. It publishes port the container's port 80 as the host's port 8080.
