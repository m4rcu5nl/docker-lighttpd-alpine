FROM alpine:3.5

RUN apk update && \
    apk add --no-cache \
    lighttpd \
    bash && \
    rm -rf /var/cache/apk/*

ADD lighttpd.conf /etc/lighttpd/lighttpd.conf

EXPOSE 80
VOLUME /var/www/localhost/htdocs

ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
