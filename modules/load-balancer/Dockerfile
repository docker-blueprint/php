FROM nginx:1.19

COPY --from=hashicorp/consul-template /consul-template /usr/bin/

RUN rm /etc/nginx/conf.d/default.conf

COPY conf.d/* /etc/nginx/conf.d/

# Install s6 supervisor
# Reference: https://github.com/just-containers/s6-overlay#the-docker-way
ADD "https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64.tar.gz" /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /

COPY supervisor/ /etc/

ENTRYPOINT ["/init"]
