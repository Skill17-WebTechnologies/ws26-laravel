# Laravel 12.61.1 — WSC2026

A real **Laravel 12.61.1** application (WorldSkills 2026 Web Technologies, TP17) backed by a
self-contained **SQLite** database — no database server required. On start it creates the
SQLite file, runs migrations, then serves.

## Run it

```bash
docker compose up --build
```

Then open **http://localhost**. There is no database service: the app uses a SQLite file
created inside the container at startup. Stop with `docker compose down`.

## Develop

The simplest loop is Docker: edit the source (see below), then rebuild:

```bash
docker compose up --build
```

Edit **routes/web.php and resources/views/** to change routes, controllers and views.

To run it natively instead you need **PHP 8.3** (with `pdo_sqlite`) and **Composer 2.9.5**.
Then:

```bash
composer install
touch database/database.sqlite
php artisan migrate
php artisan serve
```

## Stack

- PHP 8.3 / Composer 2.9.5
- Laravel 12.61.1
- SQLite (bundled, no server)
