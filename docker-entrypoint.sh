#!/usr/bin/env bash
set -e
cd /app
[ -f .env ] || cp .env.example .env

# SQLite only — no external database server. Force the driver regardless of what
# .env shipped with (artisan serve forwards .env to its subprocess).
if grep -q '^DB_CONNECTION=' .env; then
  sed -i 's#^DB_CONNECTION=.*#DB_CONNECTION=sqlite#' .env
else
  echo 'DB_CONNECTION=sqlite' >> .env
fi

# Laravel needs the SQLite file to exist before migrating.
mkdir -p database
[ -f database/database.sqlite ] || touch database/database.sqlite

# Use an injected APP_KEY if provided, otherwise generate one when .env has none.
if [ -n "${APP_KEY:-}" ]; then
  sed -i "s#^APP_KEY=.*#APP_KEY=${APP_KEY}#" .env
elif ! grep -q '^APP_KEY=.\+' .env; then
  php artisan key:generate --force --no-interaction || true
fi

# Apply the schema to the SQLite file (instant — local file, no server to wait for).
php artisan migrate --force --no-interaction || true

exec php artisan serve --host 0.0.0.0 --port 80
