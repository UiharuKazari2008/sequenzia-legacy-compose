FROM ubuntu:18.04
MAINTAINER Alexandre Macedo <alexbmac@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install nano curl git nginx memcached supervisor php7.2-fpm php7.2-xml nginx git imagemagick mysql-server-5.7 php7.2-imagick php7.2-mysql unzip ffmpeg -y

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# nginx config
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf && \
    sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 500m/" /etc/nginx/nginx.conf && \
    echo "daemon off;" >> /etc/nginx/nginx.conf && \
    mkdir -p /var/www/html/public && \
    mkdir -p /var/www/html/log && \
    touch /var/www/html/log/access.log && \
    touch /var/www/html/log/error.log && \
    chown -R www-data:www-data /var/www/html && \
    mkdir -p /run/php/ && \
    sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/7.2/fpm/php.ini && \
    sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 500M/g" /etc/php/7.2/fpm/php.ini && \
    sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 550M/g" /etc/php/7.2/fpm/php.ini && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.2/fpm/php.ini && \
    sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php/7.2/fpm/pool.d/www.conf && \
    find /etc/php/7.2/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY default.nginx.conf /etc/nginx/sites-enabled/default
#COPY cert.key /etc/nginx/cert.key
#COPY cert.pem /etc/nginx/cert.pem

RUN git clone https://github.com/UiharuKazari2008/php-sequenzia --depth 1 && \
    cd php-sequenzia && \
    /usr/local/bin/composer update && \
    /usr/local/bin/composer install && \
    mkdir -p log tmp public && \
    chmod -R 0777 log tmp

ADD config.php /php-sequenzia/config/config.php
ADD database.yml /php-sequenzia/config/database.yml

EXPOSE 3000
CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

