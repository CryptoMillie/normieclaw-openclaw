FROM ghcr.io/openclaw/openclaw:main

USER root

RUN cat > /usr/local/bin/openclaw-start <<'SCRIPT'
#!/bin/sh

echo "=== ALL ENV VARS ==="
env | sort

echo "=== FINDING OPENCLAW ==="
find / -name "openclaw*" 2>/dev/null | grep -v proc | grep -v sys

echo "=== /app directory ==="
ls -la /app 2>/dev/null || echo "no /app"

echo "=== /usr/bin ==="
ls /usr/bin | grep -i claw 2>/dev/null || echo "nothing"

echo "=== PATH ==="
echo $PATH

echo "=== ORIGINAL ENTRYPOINT CHECK ==="
cat /proc/1/cmdline 2>/dev/null | tr '\0' ' ' || echo "cant read"

SCRIPT

RUN chmod +x /usr/local/bin/openclaw-start

ENTRYPOINT ["/usr/local/bin/openclaw-start"]
