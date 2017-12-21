# Tiny Tiny TSS with PHP-FPM on Docker

A ready-to-use Docker image is available [on the docker hub](https://hub.docker.com/r/smaccagnoni/ttrss-phpfpm/). Use `smaccagnoni/ttrss-phpfpm` as the image name when running a Docker container.

This image provides Tiny Tiny RSS with PHP-FPM, based on a lightweight Alpine image. Its goals are:

* to provide an image as light as possible
* to be able to use it with NginX instead of Apache

*YOU NEED AN EXTERNAL WEBSERVER AND AN EXTERNAL SQL DATABASE.*

## NginX configuration

This image provides an NginX configuration, which works with the nginx:alpine image. Just use VolumesFrom, and NginX has access to its configuration and its web root.

This configuration assumes the Tiny Tiny TSS PHP-FPM container is reachable through name "ttrss" (which can be enforced with a link).

### Upgrades

The entrypoint automatically pulls the last revision from the Tiny Tiny RSS Git repository at each container start. To upgrade Tiny Tiny RSS, simply restart the container.

## Tiny Tiny RSS configuration

Tiny Tiny RSS configuration must be provided with environment variables. All environment variables that exist in the `config.php` file are used for Tiny Tiny RSS configuration. See [the config.php template file](https://git.tt-rss.org/git/tt-rss/src/master/config.php-dist) to know the complete list of these parameters.

Usually, at least the following ones are needed:

* `DB_HOST`: Database hostname
* `DB_USER`: Database username
* `DB_NAME`: Database name
* `DB_PASS`: Database password
* `SELF_URL_PATH`: URL on which Tiny Tiny RSS is accessed

## Database configuration

The database and username must exist and must be initialized before starting the container.

In MySQL, execute the following SQL commands:

```
CREATE DATABASE <DB_NAME> CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';"
GRANT ALL ON <DB_NAME>.* TO '<DB_USER>' IDENTIFIED BY '<DB_PASS>';"
```

You also need to initialize the database content. When migrating from another server, simply export the database and import it here. For a new installation, use the schema for your database server (MySQL or PostgreSQL) at https://git.tt-rss.org/git/tt-rss/src/master/schema.
