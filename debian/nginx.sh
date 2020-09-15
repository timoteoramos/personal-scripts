#!/bin/bash

apt update
apt install -y nginx certbot python3-certbot-nginx
sed -i 's/worker_connections 768/worker_connections 65535/g' /etc/nginx/nginx.conf

cat << EOF >> /etc/nginx/nginx.conf

# Custom tweaks
worker_rlimit_nofile 1048576;
EOF

cat << EOF > /etc/nginx/conf.d/upload.conf
client_max_body_size 32M;
EOF

cat << EOF > /etc/nginx/snippets/proxy.conf
proxy_set_header Host \$host;
proxy_set_header X-Real-IP \$remote_addr;
proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto \$scheme;
proxy_set_header X-Forwarded-Host \$host;
proxy_set_header X-Forwarded-Port \$server_port;
EOF

cat << EOF > /etc/nginx/snippets/websocket.conf
proxy_http_version 1.1;
proxy_buffering off;
proxy_cache_bypass \$http_upgrade;
proxy_set_header Upgrade \$http_upgrade;
proxy_set_header Connection "upgrade";
EOF
