<div align="center">
    <a href="https://php.net">
        <img
            alt="PHP"
            src="https://www.php.net/images/logos/new-php-logo.svg"
            width="150">
    </a>
</div>

# **PHP** Docker Blueprint

This is a **PHP** blueprint for [docker-blueprint](https://github.com/docker-blueprint/core).
It is based on [PHP FPM docker image](https://hub.docker.com/_/php) and includes a number of generic [modules](https://github.com/docker-blueprint/php/tree/master/modules)
such as PHP extensions, a package manager ([Composer](https://getcomposer.org/)) and databases (MySQL, Redis, etc).

# Usage

Create a new application or create an environment for an existing project
using `new` command:

```
docker-blueprint new php
```

You can specify a different version of PHP using environment variable:

```
PHP_VERSION=7.2 docker-blueprint new php
```

This will automatically update build arguments used in the `Dockerfile` and
replace the default values in `docker-blueprint.yml` file.
