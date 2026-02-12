FROM ghcr.io/openclaw/openclaw:main

USER root

RUN cat > /usr/local/bin/openclaw-start <<'SCRIPT'
#!/bin/sh
set -e

# Write config with Railway's PORT and lan binding at runtime
mkdir -p /root/.openclaw
printf '{"gateway":{"bind":"lan","port":%s}}' "${PORT:-18789}" > /root/.openclaw/openclaw.json

echo "Config: $(cat /root/.openclaw/openclaw.json)"

# Find and run openclaw - check multiple locations
if command -v openclaw > /dev/null 2>&1; then
  exec openclaw gateway
elif [ -f /root/.bun/bin/openclaw ]; then
  exec /root/.bun/bin/openclaw gateway
else
  cd /app
  exec /root/.bun/bin/bun run start
fi
SCRIPT

RUN chmod +x /usr/local/bin/openclaw-start

ENTRYPOINT ["/usr/local/bin/openclaw-start"]
