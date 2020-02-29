FROM php:7.2-fpm

# install git
RUN echo -e "\n========================================"; \
echo " UPDATE apt-get and install basics"; \
echo "========================================"; \ 
apt-get update && \
apt-get install apt-utils -y && \
apt-get install -y --no-install-recommends git

#install some base extensions
RUN echo -e "\n========================================"; \
echo "INSTALL moduled with apt-get"; \
echo "========================================"; \
apt-get install -y libzip-dev zip \
libpng-dev exiftool libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev \
libicu-dev libpq-dev libxpm-dev libvpx-dev mariadb-client libxml2-dev

RUN echo -e "\n========================================"; \
echo "DO PHP Settings "; \
echo "========================================"; \
docker-php-ext-configure zip --with-libzip; \
docker-php-ext-install zip; 

RUN echo -e "\n========================================"; \
echo " INSTALL PHP extensions"; \
echo "========================================"; \
docker-php-ext-install -j$(nproc) \
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
RUN echo -e "\n========================================"; \
echo " INSTALL Imagick"; \
echo "========================================"; \
apt-get update && apt-get install -y \
        libmagickwand-dev --no-install-recommends \
        && pecl install imagick \
        && docker-php-ext-enable imagick

# Install Composer
RUN echo -e "\n========================================"; \
echo " INSTALL Composer"; \
echo "========================================"; \
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

RUN echo -e "\n========================================"; \
echo " INSTALL pimcore/demo-basic-twig"; \
echo "========================================"; \
COMPOSER_MEMORY_LIMIT=-1 composer create-project pimcore/demo-basic-twig pimcore; \
chown -R 1000:1000 pimcore; \
cd pimcore 

RUN echo "---------------------------------"; \
echo " Setup SQL Database"; \
echo "---------------------------------"; \
COMPOSER_MEMORY_LIMIT=-1 ./vendor/bin/pimcore-install --admin-username=admin --admin-password=admin --mysql-host-socket=mysql --mysql-username=pimcore --mysql-password=pimcore --mysql-database=pimcore --no-interaction; \
chown -R 1000:1000 var

RUN echo "---------------------------------"; \
echo " php: install web"; \
echo "---------------------------------"; \
php bin/console assets:install web