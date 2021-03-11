ADD "https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64.tar.gz" /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /

# COPY %BLUEPRINT_DIR/supervisor /etc
# COPY %MODULE_CRON_DIR/supervisor/ /etc/
# COPY %MODULE_NGINX_DIR/supervisor/ /etc/
# COPY %MODULE_CONSUL_DIR/supervisor/ /etc/

#include %ENV_LARAVEL_DIR/supervisor/Dockerfile

ENTRYPOINT ["/init"]
