# Use the official PHP image with Apache
FROM php:7.4-apache
EXPOSE 80
# Install necessary PHP extensions and enable Apache modules
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    zlib1g-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo pdo_mysql mysqli \
    && docker-php-ext-install zip \
    && a2enmod rewrite \
    && a2enmod headers

# copy contents into directory
COPY . /var/www/html

# Set appropriate permissions
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Set working directory
WORKDIR /var/www/html