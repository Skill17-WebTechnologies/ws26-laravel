# Laravel 12.61.1 — WSC2026

A real **Laravel 12.61.1** application (WorldSkills 2026 Web Technologies, TP17) with a bundled
**MySQL 8.4** database. On start it waits for the database and runs a migration.

## Run it

```bash
docker compose up --build
```

Then open **http://localhost:8000**. The database is a `db` service (MySQL 8.4) and its data
persists in a Docker volume. Stop with `docker compose down` (add `-v` to also drop the DB).

## Develop

The simplest loop is Docker: edit the source (see below), then rebuild:

```bash
docker compose up --build
```

Edit **routes/web.php and resources/views/** to change routes, controllers and views.

To run it natively instead you need **PHP 8.3**, **Composer 2.9.5** and a local **MySQL 8.4** (only needed for the native workflow; Docker bundles MySQL for you). Then:

```bash
composer install
php artisan serve
```

(point the app at your own MySQL and create the `laravel` database first).

## Stack

- PHP 8.3 / Composer 2.9.5
- Laravel 12.61.1
- MySQL 8.4
