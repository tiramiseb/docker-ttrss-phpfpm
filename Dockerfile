FROM php:fpm-alpine

RUN apk update && apk add git \
    && git clone https://tt-rss.org/git/tt-rss.git /var/www/html \
    && docker-php-ext-install pcntl pdo_mysql \
    && rm /var/cache/apk/* \
    && chown -R www-data.www-data /var/www/html/cache /var/www/html/feed-icons /var/www/html/lock \
    && sed -i '/www-data/s|/bin/false|/bin/sh|' /etc/passwd

COPY ttrss.sh /usr/local/bin/ttrss.sh
COPY nginx.conf /etc/nginx/conf.d/ttrss.conf

VOLUME /etc/nginx/conf.d
VOLUME /var/www/html

ENTRYPOINT ["ttrss.sh"]

