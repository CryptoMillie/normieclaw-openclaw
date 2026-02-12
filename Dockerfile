FROM ghcr.io/openclaw/openclaw:main

USER root

RUN cat > /usr/local/bin/openclaw-start <<'SCRIPT'
#!/bin/sh
mkdir -p /root/.openclaw
printf '{"gateway":{"bind":"lan","port":%s}}' "${PORT:-18789}" > /root/.openclaw/openclaw.json
echo "Starting on port ${PORT:-18789}"
exec openclaw gateway
SCRIPT

RUN chmod +x /usr/local/bin/openclaw-start

ENTRYPOINT ["/usr/local/bin/openclaw-start"]
