#!/bin/bash

# Genera credenciales en Base64
AUTH_CREDENTIALS=$(echo -n "${REPO_USER}:${REPO_PASSWORD}" | base64)

# Reemplaza variables en el archivo de configuración usando sed
sed -i \
  -e "s|REPO_URL_PLACEHOLDER|${REPO_URL}|g" \
  -e "s|REPO_HOST_PLACEHOLDER|${REPO_HOST}|g" \
  -e "s|AUTH_CREDENTIALS_PLACEHOLDER|${AUTH_CREDENTIALS}|g" \
  /etc/nginx/conf.d/default.conf

# Inicia NGINX
exec "$@"
