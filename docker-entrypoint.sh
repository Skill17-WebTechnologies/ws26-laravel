#!/usr/bin/env bash
set -e
cd /app
[ -f .env ] || cp .env.example .env

# Point Laravel at the bundled MySQL 8.4 service (artisan serve forwards .env to its subprocess)
sed -i \
  -e 's#^DB_CONNECTION=.*#DB_CONNECTION=mysql#' \
  -e 's@^# *DB_HOST=.*@DB_HOST=db@' \
  -e 's@^# *DB_PORT=.*@DB_PORT=3306@' \
  -e 's@^# *DB_DATABASE=.*@DB_DATABASE=laravel@' \
  -e 's@^# *DB_USERNAME=.*@DB_USERNAME=laravel@' \
  -e 's@^# *DB_PASSWORD=.*@DB_PASSWORD=laravel@' \
  .env
grep -q '^DB_HOST=' .env || printf 'DB_HOST=db\nDB_PORT=3306\nDB_DATABASE=laravel\nDB_USERNAME=laravel\nDB_PASSWORD=laravel\n' >> .env

php artisan key:generate --force --no-interaction || true

echo "Waiting for database + running migrations..."
for i in $(seq 1 40); do
  if php artisan migrate --force --no-interaction >/tmp/migrate.log 2>&1; then echo "migrations applied"; break; fi
  echo "  db not ready yet ($i)"; sleep 3
done

exec php artisan serve --host 0.0.0.0 --port 80
