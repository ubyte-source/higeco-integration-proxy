FROM amd64/alpine:3.14

ENV STARTUP_COMMAND_RUN_NGINX="nginx"

RUN apk update && \
    apk add --no-cache nginx && \
    rm -rf /var/cache/apk/*

COPY wrapper.sh /
COPY nginx.conf /etc/nginx/nginx.conf

RUN adduser -D -g www www && \
    chown -R www:www /var/lib/nginx && \
    chmod +x wrapper.sh

RUN rm -Rf /etc/nginx/sites-enabled && \
    rm -Rf /etc/nginx/sites-available

USER www

ENTRYPOINT /wrapper.sh