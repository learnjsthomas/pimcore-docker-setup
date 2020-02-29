FROM php:7.2-fpm

# Install git
RUN echo -e "\n========================================"; \
echo " UPDATE apt-get and install basics"; \
echo "========================================"; \ 
apt-get update && \
apt-get install apt-utils -y && \
apt-get install -y --no-install-recommends git
# Install some base extensions
RUN echo -e "\n\n\n\n\n========================================"; \
echo "INSTALL moduled with apt-get"; \
echo "========================================"; \
apt-get install -y libzip-dev zip \
libpng-dev exiftool libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev \
libicu-dev libpq-dev libxpm-dev libvpx-dev mariadb-client libxml2-dev
# Do some php settings
RUN echo -e "\n\n\n\n\n========================================"; \
echo " Do some php settings "; \
echo "========================================"; \
docker-php-ext-configure zip --with-libzip;
# Install php extensions
RUN echo -e "\n\n\n\n\n========================================"; \
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
RUN echo -e "\n\n\n\n\n========================================"; \
echo " INSTALL Imagick"; \
echo "========================================"; \
apt-get update && apt-get install -y \
        libmagickwand-dev --no-install-recommends \
        && pecl install imagick \
        && docker-php-ext-enable imagick
# Install Composer
RUN echo -e "\n\n\n\n\n========================================"; \
echo " INSTALL Composer"; \
echo "========================================"; \
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version
