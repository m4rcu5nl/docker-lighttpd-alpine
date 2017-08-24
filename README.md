docker-lighttpd-alpine
======================

Build
-----
`docker build -t lighttpd .`

Run
----
`docker run --name lighttpd -v /etc/localtime:/etc/localtime:ro -v $PWD/htdocs:/var/www/localhost/htdocs -p 8080:80 -d lighttpd:latest`
