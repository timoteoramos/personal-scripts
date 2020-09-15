#!/bin/ash

apk add nginx certbot certbot-nginx
mkdir /etc/nginx/sites-available
mkdir /etc/nginx/sites-enabled
mkdir /etc/nginx/snippets
mv /etc/nginx/conf.d/default.conf /etc/nginx/sites-available/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

cat << EOF > /etc/nginx/nginx.conf
# /etc/nginx/nginx.conf
user nginx;

# Set number of worker processes automatically based on number of CPU cores.
worker_processes auto;

# Enables the use of JIT for regular expressions to speed-up their processing.
pcre_jit on;

# Configures default error logger.                                                                                                                                                        [40/142]
error_log /var/log/nginx/error.log warn;

# Includes files with directives to load dynamic modules.
include /etc/nginx/modules/*.conf;

events {
    # The maximum number of simultaneous connections that can be opened by
    # a worker process.
    worker_connections 65535;
}

http {
    # Includes mapping of file name extensions to MIME types of responses
    # and defines the default type.
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    # Name servers used to resolve names of upstream servers into addresses.
    # It's also needed when using tcpsocket and udpsocket in Lua modules.
    #resolver 208.67.222.222 208.67.220.220;

    # Don't tell nginx version to clients.
    server_tokens off;

    # Timeout for keep-alive connections. Server will close connections after
    # this time.
    keepalive_timeout 65;

    # Sendfile copies data between one FD and other from within the kernel,
    # which is more efficient than read() + write().
    sendfile on;

    # Don't buffer data-sends (disable Nagle algorithm).
    # Good for sending frequent small bursts of data in real time.
    tcp_nodelay on;

    # Causes nginx to attempt to send its HTTP response head in one packet,
    # instead of using partial frames.
    #tcp_nopush on;

    # Path of the file with Diffie-Hellman parameters for EDH ciphers.
    #ssl_dhparam /etc/ssl/nginx/dh2048.pem;

    # Specifies that our cipher suits should be preferred over client ciphers.
    ssl_prefer_server_ciphers on;

    # Enables a shared SSL cache with size that can hold around 8000 sessions.
    ssl_session_cache shared:SSL:2m;

    # Enable gzipping of responses.
    #gzip on;

    # Set the Vary HTTP header as defined in the RFC 2616.
    gzip_vary on;

    # Enable checking the existence of precompressed files.
    #gzip_static on;

    # Specifies the main log format.
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';

    # Sets the path, format, and configuration for a buffered log write.
    access_log /var/log/nginx/access.log main;

    # Includes custom configs.
    include /etc/nginx/conf.d/*.conf;

    # Includes virtual hosts configs.
    include /etc/nginx/sites-enabled/*;
}
EOF

cat << EOF > /etc/nginx/conf.d/upload.conf
client_max_body_size 32M;
EOF

cat << EOF > /etc/nginx/modules/99-tweaks.conf
worker_rlimit_nofile 1048576;
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

rc-update add nginx
rc-service nginx restart
