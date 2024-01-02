#!/bin/bash
CONFIG_FILE="/usr/share/nginx/html/assets/config.js"
INDEX_FILE="/usr/share/nginx/html/index.html"

# Check if BASE_URL is set
if [ -z "$BASE_URL" ]; then
    echo "Error: BASE_URL is not set."
    exit 1
fi
# creates a config.js
echo "window._env_ = { \"BASE_URL\": \"$BASE_URL\" };" > "$CONFIG_FILE"

if grep -q '<script type="module" src="/assets/config.js"></script>' "$INDEX_FILE"; then
    echo "Line already exists in index.html. Exiting..."
    exec "$@"
    exit 0
fi

sed -i "8i \ \ \ \ <script type=\"module\" src=\"./assets/config.js\"></script>" "$INDEX_FILE"

exec "$@"