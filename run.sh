#!/usr/bin/with-contenv bashio

CONFIG_PATH=/data/config.yaml
COMPANY_PATH=/data/company.json

# Create default config if not exists
if [ ! -f "$CONFIG_PATH" ]; then
  bashio::log.info "Creating default config..."
  cat > "$CONFIG_PATH" <<EOF
port: 8099
company:
  name: ""
  street: ""
  city: ""
EOF
fi

# Symlink config into app dir
ln -sf "$CONFIG_PATH" /app/config.yaml
ln -sf "$COMPANY_PATH" /app/company.json 2>/dev/null || true

cd /app
bashio::log.info "Starting WARP3 Ladeabrechnung..."
exec node server.js
