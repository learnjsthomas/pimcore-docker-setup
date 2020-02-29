FROM php:7.2-fpm

# install git
RUN     echo "\n========================================" && \
        echo "UPDATE apt-get and install basics" && \
        echo "========================================\n" && \
        apt-get update && \
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

RUN echo -e "\n========================================"
RUN echo -e " INSTALL PHP extensions"
RUN echo -e "========================================\n"
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
RUN echo -e "\n========================================"
RUN echo -e " INSTALL Imagick"
RUN echo -e "========================================\n"
RUN apt-get update && apt-get install -y \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
	&& docker-php-ext-enable imagick

# Install Composer
RUN echo -e "\n========================================"
RUN echo -e " INSTALL Composer"
RUN echo -e "========================================\n"
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

RUN echo -e "\n========================================"
RUN echo -e " INSTALL pimcore/demo-basic-twig"
RUN echo -e "========================================\n"
RUN COMPOSER_MEMORY_LIMIT=-1 composer create-project pimcore/demo-basic-twig pimcore
RUN chown -R 1000:1000 pimcore
RUN cd pimcore 
RUN echo -e "---------------------------------"
RUN echo -e " Setup SQL Database"
RUN echo -e "---------------------------------"
RUN COMPOSER_MEMORY_LIMIT=-1 ./vendor/bin/pimcore-install --admin-username=admin --admin-password=admin --mysql-host-socket=mysql --mysql-username=pimcore --mysql-password=pimcore --mysql-database=pimcore --no-interaction
RUN chown -R 1000:1000 var
RUN echo -e "---------------------------------"
RUN echo -e " php: install web"
RUN echo -e "---------------------------------"
RUN php bin/console assets:install web