FROM php:7.2-fpm

# install git
RUN apt-get update && \
    apt-get install -y --no-install-recommends git

#install some base extensions
RUN apt-get install -y \
        zlib1g-dev \
        zip \
        libpng-dev \
        exiftool \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libicu-dev \
        libpq-dev \
        libxpm-dev \
        libvpx-dev \
        mysql-client \
        libxml2-dev

RUN docker-php-ext-install -j$(nproc) \
   zip \
   exif \
   gd \
   bcmath \
   intl \
   pcntl \
   mysqli \
   pdo \
   pdo_mysql \
   pdo_pgsql \
   mbstring \
   soap \
   opcache \
   iconv

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version