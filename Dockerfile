FROM alpine:3.9
LABEL maintainer="Marcus Meurs <mail@m4rcu5.nl>" \
      version="1.0.0"

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

# Copy lighttpd config files. At this point it is all default except
# including a custom ssl.conf in lighttpd.conf.
COPY config/lighttpd/*.conf /etc/lighttpd/

# Copy an example index.html to the default webroot to allow
# for demo/testing without needing mounts during `docker run`
COPY htdocs/index.html /var/www/localhost/htdocs/

# Check every minute if lighttpd responds within 1 second and update
# container health status accordingly.
HEALTHCHECK --interval=1m --timeout=1s \
  CMD curl -f http://localhost/ || exit 1

# Expose http(s) ports
EXPOSE 80 443

# Make configuration path and webroot a volume
VOLUME /etc/lighttpd/
VOLUME /var/www/

ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
