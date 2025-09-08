FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libonig-dev \
    libxml2-dev \
    libsqlite3-dev \
    && docker-php-ext-install pdo_sqlite mbstring bcmath

# Set working directory
WORKDIR /var/www

# Copy project files
COPY . .

# Expose port and start server
CMD php artisan serve --host=0.0.0.0 --port=8000
