FROM ghcr.io/openclaw/openclaw:main

USER root

RUN cat > /usr/local/bin/openclaw-start <<'SCRIPT'
#!/bin/sh
set -e

: ${HOME:=/root}
mkdir -p "$HOME/.openclaw"

PORT_VALUE=${PORT:-18789}
TOKEN_VALUE=${OPENCLAW_GATEWAY_TOKEN}

# Use printf to avoid heredoc variable substitution issues
printf '{\n  "gateway": {\n    "mode": "local",\n    "bind": "lan",\n    "port": %s,\n    "auth": {\n      "mode": "token",\n      "token": "%s"\n    }\n  }\n}\n' "$PORT_VALUE" "$TOKEN_VALUE" > "$HOME/.openclaw/openclaw.json"

echo "✅ OpenClaw config written:"
cat "$HOME/.openclaw/openclaw.json"

exec openclaw gateway --token "$TOKEN_VALUE"
SCRIPT

RUN chmod +x /usr/local/bin/openclaw-start

ENTRYPOINT ["/usr/local/bin/openclaw-start"]
