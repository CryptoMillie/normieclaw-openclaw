FROM ghcr.io/openclaw/openclaw:main

USER root

# Write config at build time AND make it immutable so app can't overwrite it
RUN mkdir -p /root/.openclaw && \
    echo '{"gateway":{"bind":"lan"}}' > /root/.openclaw/openclaw.json && \
    chmod 444 /root/.openclaw/openclaw.json

# No ENTRYPOINT override - original runs correctly
