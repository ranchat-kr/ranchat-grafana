#!/bin/sh

sh -euc |
cat <<EOF > /etc/nginx/nginx.conf
user  nginx;
worker_processes  5;  ## Default: 1

events {
  worker_connections   1000;
}

http {
  upstream grafana {
    server grafana:3000;
  }

  upstream loki-server {
    server loki:3100;
  }

  server {
    listen             80;

    location = /health {
      return 200 'OK';
      auth_basic off;
    }

    location ~ /(.*) {
      proxy_http_version 1.1;
      proxy_set_header Upgrade \$http_upgrade;
      proxy_set_header Connection "Upgrade";
      proxy_set_header Host \$http_host;
      proxy_pass http://grafana;
    }

    location = /loki/api/v1/push {
      proxy_pass       http://loki-server\$request_uri;
    }

    location = /loki/api/v1/tail {
      proxy_pass       http://loki-server\$request_uri;
      proxy_set_header Upgrade \$http_upgrade;
      proxy_set_header Connection "upgrade";
    }

    location ~ /loki/api/.* {
      proxy_pass       http://loki-server\$request_uri;
    }
  }
}
EOF
/docker-entrypoint.sh nginx -g "daemon off;"