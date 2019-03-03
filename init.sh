#!/bin/sh -xe

htpasswd -Bbn ${USER} ${PASSWD} > /etc/nginx/htpasswd
sed -i 's/client_max_body_size 1m;/client_max_body_size 100m;/g' /etc/nginx/nginx.conf

cat << EOF > /etc/nginx/conf.d/default.conf
server {
  client_max_body_size 100M;
  listen 80;
  auth_basic "SOME";
  auth_basic_user_file "/etc/nginx/htpasswd";
  location / {
    proxy_pass ${PROXY_PASS};
  }
  resolver ${RESOLVER};
}
EOF

echo DEBUG
echo ${USER}
echo ${PROXY_PASS}

mkdir -p /run/nginx/;
nginx -g daemon\ off\;

