FROM php:fpm-alpine

RUN apk update
RUN apk add git
RUN git clone https://tt-rss.org/git/tt-rss.git /var/www/html
RUN chown -R www-data.www-data /var/www/html/cache /var/www/html/feed-icons

COPY ttrss.sh /usr/local/bin/ttrss.sh
COPY nginx.conf /etc/nginx/conf.d/ttrss.conf

VOLUME /etc/nginx/conf.d
VOLUME /var/www/html

ENTRYPOINT ["ttrss.sh"]

