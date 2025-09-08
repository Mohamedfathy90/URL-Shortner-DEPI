# ----------------------------
# Stage 1: Build PHP extensions & Composer deps
# ----------------------------
FROM php:8.2-fpm-alpine AS build

# Install system dependencies (only required for building)
RUN apk add --no-cache \
    git \
    curl \
    unzip \
    zip \
    libpng-dev \
    libxml2-dev \
    oniguruma-dev \
    sqlite-dev \
    autoconf \
    g++ \
    make

# Install PHP extensions
RUN docker-php-ext-install pdo_sqlite mbstring bcmath

# Install Composer (from official image)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# Copy app source
COPY . .

# Install dependencies (production only)
RUN composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist


# ----------------------------
# Stage 2: Final runtime image
# ----------------------------
FROM php:8.2-fpm-alpine

WORKDIR /var/www

# Copy PHP extensions from build stage
COPY --from=build /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=build /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Copy only necessary app files + vendor from build stage
COPY --from=build /var/www /var/www

# Fix permissions for Laravel
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Expose port and start server
CMD php artisan serve --host=0.0.0.0 --port=8000
