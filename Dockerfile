FROM ghcr.io/openclaw/openclaw:main

# Switch to root to install our custom entrypoint
USER root

# Create custom entrypoint script in /usr/local/bin
RUN cat > /usr/local/bin/openclaw-start <<'SCRIPT'
#!/bin/sh
set -e

# Determine home directory (works for any user)
: ${HOME:=/root}

# Create OpenClaw directory
mkdir -p "$HOME/.openclaw"

# Get PORT (Railway sets this dynamically)  
PORT_VALUE=${PORT:-18789}

# Create openclaw.json with LAN binding
cat > "$HOME/.openclaw/openclaw.json" <<EOF
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

echo "✅ OpenClaw config created at $HOME/.openclaw/openclaw.json"
cat "$HOME/.openclaw/openclaw.json"

# Start OpenClaw gateway
exec openclaw gateway
SCRIPT

# Make it executable
RUN chmod +x /usr/local/bin/openclaw-start

# Use our custom entrypoint
ENTRYPOINT ["/usr/local/bin/openclaw-start"]
