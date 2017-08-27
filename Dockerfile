FROM alpine:3.5
LABEL maintainer="Marcus Meurs <mail@m4rcu5.nl>"

# Install packages
RUN apk update && \
    apk add --no-cache \
    lighttpd \
    openssl \
    curl && \
    rm -rf /var/cache/apk/*

# Create lighttpd ssl directory and generate self signed cert
RUN mkdir /etc/lighttpd/ssl/ && \
	openssl req -x509 -newkey rsa:4096 -keyout /tmp/key.pem -out /tmp/cert.pem -days 365 -subj '/CN=localhost' -nodes -sha256 && \
	cat /tmp/key.pem /tmp/cert.pem > /etc/lighttpd/ssl/localhost.pem && \
	rm /tmp/key.pem /tmp/cert.pem && \
	chmod 400 /etc/lighttpd/ssl/localhost.pem

COPY config/lighttpd/*.conf /etc/lighttpd/

#
# ToDo: fine tune configuration instead of bulk copy config files.
# Also see if self signed cert can be generated during build
#

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

# Expose http(s) ports
EXPOSE 80 443

ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
