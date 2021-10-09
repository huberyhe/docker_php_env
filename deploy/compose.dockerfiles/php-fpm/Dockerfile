FROM php:7.2-fpm
LABEL maintainer="hyc171819@gmail.com"
LABEL version="1.0"
LABEL description="This text illustrates \
that label-values can span multiple lines."

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
	    zip unzip \ 
	    curl

RUN apt-get install -y build-essential libssl-dev zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd zip pdo_mysql opcache mysqli \
    && pecl install redis xdebug && docker-php-ext-enable redis xdebug

RUN echo "" >> /usr/local/etc/php/php.ini
RUN usermod -u 1000 www-data