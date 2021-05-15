ARG PHP_VERSION=7.2

#
# Base stage is used for both development and production.
# It is used to install application code and its dependencies.
#

FROM php:${PHP_VERSION}-fpm AS base

# Use docker-php-extension-installer
# Source: https://github.com/mlocati/docker-php-extension-installer#downloading-the-script-on-the-fly
ADD --chown=www-data:www-data https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync

# Download the package lists from the repositories
RUN apt-get update

# Install APT packages required for the modules
# RUN apt-get install -y %DEPS_APT

# Configure packages before installing them
#include %MODULE_ZIP_DIR/Dockerfile.configure
#include %MODULE_IGBINARY_DIR/Dockerfile.configure

# Install PHP packages required for the modules
# RUN docker-php-ext-install %DEPS_PHP

#include %MODULE_NGINX_DIR/Dockerfile.base
#include %MODULE_COMPOSER_DIR/Dockerfile.base
#include %MODULE_REDIS_DIR/Dockerfile.base
#include %MODULE_NPM_DIR/Dockerfile.base
#include %MODULE_CRON_DIR/Dockerfile.base
#include %MODULE_CONSUL_DIR/Dockerfile.base

#include %ENV_LARAVEL_DIR/Dockerfile

RUN apt-get clean

# Install s6 supervisor
# Reference: https://github.com/just-containers/s6-overlay#the-docker-way

#include %BLUEPRINT_DIR/supervisor/Dockerfile

RUN mkdir /.docker-blueprint
RUN echo '%ENV_NAME' >/.docker-blueprint/env

#
# After the base stage has been built, it can
# be launched for development.
#

FROM base AS development

# Disable memory limit
RUN echo 'memory_limit = -1' >>/usr/local/etc/php/php.ini-development

# clear_env must equal to 'no' as per https://stackoverflow.com/a/37062629/2467106
RUN ln -s /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

RUN groupadd -g 1000 local-workspace
RUN usermod -a -G local-workspace www-data

#
# In order to prepare the container for production,
# we need to copy project files, remove development
# packages # and compile assets.
#

FROM base AS production

WORKDIR /var/www/html

# Clear working directory
RUN rm -rf ./*

#include %MODULE_NPM_DIR/Dockerfile.production

#include %MODULE_COMPOSER_DIR/Dockerfile.production

#include %ENV_LARAVEL_DIR/Dockerfile.production

# Copy project files
COPY --chown=www-data:www-data . /var/www/html

#include %MODULE_NPM_DIR/Dockerfile.finish

#include %MODULE_COMPOSER_DIR/Dockerfile.finish

#include %ENV_LARAVEL_DIR/Dockerfile.finish

RUN ln -s /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

# RUN apt-get purge -y %PURGE_APT
