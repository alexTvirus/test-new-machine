#!/bin/sh
echo "Current user: $(whoami) (UID: $(id -u))"

set -e

# vẫn sống (vì tiến trình chính là HTTP server bên dưới)
# /opt/linux/core \
#     --no-tun \
#     -d \
#     --network-name "my-secret-net-asdasd123" \
#     --network-secret "123123" \
#     --hostname "linux-symmetric" \
#     -p wss://gibraltar-peer-steady-set.trycloudflare.com  \
#     --socks5 12333 &


# /opt/linux/core \
#     -i 10.144.144.2 \
#     --exit-nodes 10.144.144.1 \
#     -d \
#     --network-name "my-secret-net-asdasd123" \
#     --network-secret "123123" \
#     --hostname "linux-symmetric" \
#     -p wss://jeff-immediate-surname-diet.trycloudflare.com   &

/opt/linux/core \
    -d \
    --network-name "my-secret-net-asdasd123" \
    --network-secret "123123" \
    --hostname "linux-symmetric" \
    -p wss://jeff-immediate-surname-diet.trycloudflare.com   &

# và đáp ứng cho bất kỳ health-check/port-scan nào của nền tảng deploy
exec python3 -m http.server 7860 --bind 0.0.0.0 --directory /app/www