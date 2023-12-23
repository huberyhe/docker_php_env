FROM php:7.2-fpm
LABEL maintainer="hyc171819@gmail.com"
LABEL version="1.0"
LABEL description="This text illustrates \
that label-values can span multiple lines."

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY resources/* /tmp/

RUN sed -i 's#http://deb.debian.org/#https://mirrors.tuna.tsinghua.edu.cn/#g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev zip unzip curl && \
    apt-get install -y build-essential libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev && \
    cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    pecl channel-update pecl.php.net && \
    pecl install /tmp/redis-6.0.2.tgz /tmp/xdebug-3.1.5.tgz && \
    rm -f /tmp/{redis-6.0.2.tgz,xdebug-3.1.5.tgz} && \
    docker-php-ext-install -j$(nproc) gd zip pdo_mysql opcache mysqli

RUN usermod -u 1000 www-data