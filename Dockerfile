FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates wget curl unzip python3  iproute2 iptables && \
    curl -fsSL -o /tmp/linux.zip \
        "https://github.com/alexTvirus/gooox/releases/download/1.1/linux-x86_64.zip" && \
    mkdir -p /tmp/et-extract && \
    unzip /tmp/linux.zip -d /tmp/et-extract && \
    mkdir -p /opt/linux && \
    cp /tmp/et-extract/linux-x86_64/core /opt/linux/ && \
    cp /tmp/et-extract/linux-x86_64/cli /opt/linux/ && \
    chmod +x /opt/linux/core /opt/linux/cli && \
    rm -rf /tmp/linux.zip /tmp/et-extract && \
    apt-get purge -y curl unzip && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app/www && echo "OK" > /app/www/index.html

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7860
ENTRYPOINT ["/entrypoint.sh"]