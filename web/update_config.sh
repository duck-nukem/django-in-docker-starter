envsubst '$APP_HOST' < /etc/nginx/conf.d/default.template > /etc/nginx/nginx.conf
nginx -g 'daemon off;'
