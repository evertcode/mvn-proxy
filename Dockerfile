FROM nginx:1.20-alpine

# Instala herramientas para manejar variables
RUN apk add --no-cache bash gettext

# Copia configuración y script de entrada
COPY conf.d/maven-proxy.conf /etc/nginx/templates/maven-proxy.conf.template
COPY entrypoint.sh /entrypoint.sh

# Permisos de ejecución
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
