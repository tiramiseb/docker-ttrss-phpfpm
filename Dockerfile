FROM php:fpm-alpine

RUN apk update && apk add git \
    && git clone https://tt-rss.org/git/tt-rss.git /var/www/html \
    && docker-php-ext-install mysqli \
    && rm /var/cache/apk/* \
    && chown -R www-data.www-data /var/www/html/cache /var/www/html/feed-icons /var/www/html/lock

COPY ttrss.sh /usr/local/bin/ttrss.sh
COPY nginx.conf /etc/nginx/conf.d/ttrss.conf

VOLUME /etc/nginx/conf.d
VOLUME /var/www/html

ENTRYPOINT ["ttrss.sh"]

