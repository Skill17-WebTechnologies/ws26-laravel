# Laravel 12.61.1 — WSC2026 app (SQLite)

```bash
docker compose up --build
```

Open **http://localhost**. On start it ensures an app key, creates a SQLite database file
(`database/database.sqlite`), runs migrations, then serves. No database server is used in any
environment. Pinned: PHP 8.3 / Composer 2.9.5, laravel/framework 12.61.1.
