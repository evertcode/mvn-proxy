#!/bin/bash

# Genera credenciales en Base64
export AUTH_CREDENTIALS=$(echo -n "${REPO_USER}:${REPO_PASSWORD}" | base64)

# Reemplaza variables en la plantilla de NGINX
envsubst '${REPO_URL},${REPO_HOST},${AUTH_CREDENTIALS}' < /etc/nginx/templates/maven-proxy.conf.template > /etc/nginx/conf.d/default.conf

# Inicia NGINX
exec "$@"
