FROM nginx:1.23-alpine

# Copia configuración y script de entrada
COPY entrypoint.sh /entrypoint.sh
COPY conf.d/maven-proxy.conf /etc/nginx/templates/maven-proxy.conf.template

# Permisos de ejecución
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
