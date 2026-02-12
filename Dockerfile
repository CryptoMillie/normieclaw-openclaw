FROM ghcr.io/openclaw/openclaw:main

USER root

RUN echo "IyEvYmluL3NoCm1rZGlyIC1wIC9yb290Ly5vcGVuY2xhdwpwcmludGYgJ3siZ2F0ZXdheSI6eyJiaW5kIjoibGFuIiwicG9ydCI6JXN9fScgIiR7UE9SVDotMTg3ODl9IiA+IC9yb290Ly5vcGVuY2xhdy9vcGVuY2xhdy5qc29uCmVjaG8gIlN0YXJ0aW5nIG9uIHBvcnQgJHtQT1JUOi0xODc4OX0iCmV4ZWMgL3Jvb3QvLmJ1bi9iaW4vb3BlbmNsYXcgZ2F0ZXdheQo=" | base64 -d > /usr/local/bin/openclaw-start && chmod +x /usr/local/bin/openclaw-start

ENTRYPOINT ["/usr/local/bin/openclaw-start"]
