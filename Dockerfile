FROM ghcr.io/openclaw/openclaw:main

USER root

RUN cat > /usr/local/bin/openclaw-start <<'SCRIPT'
#!/bin/sh
set -e

echo "=== DEBUG ==="
echo "TOKEN=$OPENCLAW_GATEWAY_TOKEN"
echo "PORT=$PORT"

# Find the openclaw binary wherever it lives
OPENCLAW_BIN=$(which openclaw 2>/dev/null || find / -name "openclaw" -type f -perm /111 2>/dev/null | grep -v proc | head -1)
echo "Binary: $OPENCLAW_BIN"

if [ -z "$OPENCLAW_BIN" ]; then
  echo "ERROR: openclaw binary not found"
  exit 1
fi

if [ -z "$OPENCLAW_GATEWAY_TOKEN" ]; then
  echo "ERROR: OPENCLAW_GATEWAY_TOKEN is empty"
  exit 1
fi

exec "$OPENCLAW_BIN" gateway --token "$OPENCLAW_GATEWAY_TOKEN"
SCRIPT

RUN chmod +x /usr/local/bin/openclaw-start

ENTRYPOINT ["/usr/local/bin/openclaw-start"]
