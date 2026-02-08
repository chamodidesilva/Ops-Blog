#!/bin/sh
set -e

DB_PATH="/usr/local/var/flaskr-instance/flaskr.sqlite"

# Initialize DB only if it doesn't exist
if [ ! -f "$DB_PATH" ]; then
    echo "Database not found. Initializing..."
    flask --app flaskr init-db
else
    echo "Database already exists. Skipping init."
fi

# Start the app
exec flask --app flaskr run --debug --host=0.0.0.0
