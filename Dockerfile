FROM alpine:3.5
LABEL maintainer="Marcus Meurs <mail@m4rcu5.nl>"

# Install packages
RUN apk update && \
    apk add --no-cache \
    lighttpd && \
    rm -rf /var/cache/apk/*

# Expose http port
EXPOSE 80

ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
