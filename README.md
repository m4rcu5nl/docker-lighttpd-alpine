[![Build Status](https://travis-ci.org/m4rcu5nl/docker-lighttpd-alpine.svg?branch=master)](https://travis-ci.org/m4rcu5nl/docker-lighttpd-alpine) [![GitHub issues](https://img.shields.io/github/issues/m4rcu5nl/docker-lighttpd-alpine.svg)](https://github.com/m4rcu5nl/docker-lighttpd-alpine/issues)

docker-lighttpd-alpine
======================

Build
-----
`docker build -t lighttpd .`

Run
----
`docker run --name lighttpd -v /etc/localtime:/etc/localtime:ro -v $PWD/htdocs:/var/www/localhost/htdocs -p 8080:80 -d lighttpd:latest`
