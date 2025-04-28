docker build -t working-internal-dns .

docker run --name dns-server -p 5353:53/udp -d working-internal-dns

dig @127.0.0.1 -p 5353 internal.example.com