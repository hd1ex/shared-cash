FROM nginx:alpine

ENV SERVER_USER="http"
RUN adduser -D -g "$SERVER_USER" "$SERVER_USER"

ENV APP_PATH=/srv/shared-cash
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

RUN mkdir -p /etc/nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY shared_cash_nginx.conf shared_cash_nginx.conf

RUN rm /etc/nginx/conf.d/default.conf && \
    mkdir -p /etc/nginx/sites-enabled/ && \
    mkdir -p /run/nginx && \
    ln -sf $(realpath shared_cash_nginx.conf) /etc/nginx/sites-enabled/
