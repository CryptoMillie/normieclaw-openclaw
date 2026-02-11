FROM ghcr.io/openclaw/openclaw:main

# Install jq for JSON manipulation
RUN apk add --no-cache jq

# Create entrypoint script that injects config at runtime
RUN cat > /entrypoint.sh <<'EOF'
#!/bin/sh
set -e

# Create OpenClaw directory
mkdir -p /root/.openclaw

# Create openclaw.json with LAN binding
cat > /root/.openclaw/openclaw.json <<CONFIG
{
  "gateway": {
    "mode": "local",
    "bind": "lan",
    "port": ${PORT:-18789},
    "auth": {
      "mode": "token",
      "token": "${OPENCLAW_GATEWAY_TOKEN}"
    }
  }
}
CONFIG

echo "✅ Config created:"
cat /root/.openclaw/openclaw.json

# Start OpenClaw gateway
exec openclaw gateway
EOF

# Make entrypoint executable
RUN chmod +x /entrypoint.sh

# Use our entrypoint
ENTRYPOINT ["/entrypoint.sh"]
