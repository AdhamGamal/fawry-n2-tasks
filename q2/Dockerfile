# Base image
FROM ubuntu:24.04

# Install dnsmasq
RUN apt update && apt install -y dnsmasq

# Expose DNS port
EXPOSE 53/udp

# Start dnsmasq in foreground mode
CMD ["dnsmasq", "--no-daemon", "--log-queries", "--address=/internal.example.com/127.0.0.1"]