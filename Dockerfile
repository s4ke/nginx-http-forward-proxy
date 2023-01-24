FROM nginx:1.23.3

RUN mkdir -p /etc/nginx-forward/
RUN rm /etc/nginx/conf.d/default.conf

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./conf.d/default.conf /etc/nginx-forward/default.conf

ENV DNS_RESOLVER_IP=127.0.0.11
ENV DNS_RESOLVER_VALID=10s

CMD envsubst '$DNS_RESOLVER_IP, $DNS_RESOLVER_VALID' < /etc/nginx-forward/default.conf > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'