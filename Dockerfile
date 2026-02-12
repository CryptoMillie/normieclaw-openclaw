FROM ghcr.io/openclaw/openclaw:main

USER root

# Write config at build time - Railway always uses 8080
RUN mkdir -p /root/.openclaw && \
    echo '{"gateway":{"bind":"lan","port":8080,"controlUi":{"enabled":true,"allowInsecureAuth":true},"auth":{"mode":"token","token":"normieclaw2026"}}}' > /root/.openclaw/openclaw.json && \
    chmod 444 /root/.openclaw/openclaw.json

# NO ENTRYPOINT OVERRIDE - original handles the binary
