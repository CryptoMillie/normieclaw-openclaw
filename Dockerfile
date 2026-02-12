FROM ghcr.io/openclaw/openclaw:main

USER root

# Write base config at build time - Railway always uses PORT 8080
# No chmod lock - OpenClaw needs to write its own auth token on first boot
RUN mkdir -p /root/.openclaw && \
    echo '{"gateway":{"bind":"lan","port":8080,"controlUi":{"enabled":true,"allowInsecureAuth":true}}}' > /root/.openclaw/openclaw.json

# NO ENTRYPOINT OVERRIDE - original handles the binary
