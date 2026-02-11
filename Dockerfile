FROM ghcr.io/openclaw/openclaw:main

# Create entrypoint script that injects config at runtime
RUN cat > /entrypoint.sh <<'SCRIPT'
#!/bin/sh
set -e

# Create OpenClaw directory
mkdir -p /root/.openclaw

# Get PORT (Railway sets this dynamically)
PORT_VALUE=${PORT:-18789}

# Create openclaw.json with LAN binding (pure shell, no jq needed)
cat > /root/.openclaw/openclaw.json <<EOF
{
  "gateway": {
    "mode": "local",
    "bind": "lan",
    "port": $PORT_VALUE,
    "auth": {
      "mode": "token",
      "token": "${OPENCLAW_GATEWAY_TOKEN}"
    }
  }
}
EOF

echo "✅ OpenClaw config created:"
cat /root/.openclaw/openclaw.json

# Start OpenClaw gateway
exec openclaw gateway
SCRIPT

# Make entrypoint executable
RUN chmod +x /entrypoint.sh

# Use our entrypoint
ENTRYPOINT ["/entrypoint.sh"]
