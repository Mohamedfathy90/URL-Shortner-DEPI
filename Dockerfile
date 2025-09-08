# ----------------------------
# Stage 1: Build PHP extensions & composer dependencies
# ----------------------------
FROM php:8.2-fpm AS build

# Install system dependencies for build
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    unzip \
    zip \
    libonig-dev \
    libxml2-dev \
    libsqlite3-dev \
 && docker-php-ext-install pdo_sqlite mbstring bcmath \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Set workdir
WORKDIR /var/www

# Copy app source
COPY . .

# Install PHP dependencies (only production)
RUN composer install

# ----------------------------
# Stage 2: Final production image
# ----------------------------
FROM php:8.2-fpm

WORKDIR /var/www

# Copy PHP extensions & configs from build stage
COPY --from=build /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=build /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Copy application (including vendor from build stage)
COPY --from=build /var/www /var/www

# Expose port and start server
CMD php artisan serve --host=0.0.0.0 --port=8000
