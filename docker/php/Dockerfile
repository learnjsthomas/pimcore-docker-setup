FROM php:7.2-fpm

# install git
RUN echo "\n========================================"
RUN echo "UPDATE apt-get and install basics"
RUN echo "========================================\n"
RUN apt-get update && \
        apt-get install apt-utils && \
        apt-get install -y --no-install-recommends git

#install some base extensions
RUN echo "\n========================================"
RUN echo "INSALL moduled with apt-get"
RUN echo "========================================\n"
RUN apt-get install -y \
        libzip-dev \
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
        mariadb-client \
        libxml2-dev
RUN echo "\n========================================"
RUN echo "DO PHP Settings "
RUN echo "========================================\n"
RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install zip

RUN echo "\n========================================"
RUN echo " INSTALL PHP extensions"
RUN echo "========================================\n"
RUN docker-php-ext-install -j$(nproc) \
        zip \
        exif \
        bcmath \
        intl \
        pcntl \
        mysqli \
        pdo \
        gd \
        pdo_mysql \
        pdo_pgsql \
        mbstring \
        soap \
        opcache \
        iconv

# Install Imagick
RUN echo "\n========================================"
RUN echo " INSTALL Imagick"
RUN echo "========================================\n"
RUN apt-get update && apt-get install -y \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
	&& docker-php-ext-enable imagick

# Install Composer
RUN echo "\n========================================"
RUN echo " INSTALL Composer"
RUN echo "========================================\n"
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version