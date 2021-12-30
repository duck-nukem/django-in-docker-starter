FROM nginx:alpine

COPY update_config.sh /usr/local/bin/update_config.sh
COPY nginx.conf.template /etc/nginx/conf.d/default.template
COPY static/ /var/www/
