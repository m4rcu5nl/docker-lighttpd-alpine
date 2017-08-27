FROM alpine:3.5
LABEL maintainer="Marcus Meurs <mail@m4rcu5.nl>"

# Install packages
RUN apk update && \
    apk add --no-cache \
    lighttpd \
    openssl \
    curl && \
    rm -rf /var/cache/apk/*

# Expose http(s) ports
EXPOSE 80 443

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
