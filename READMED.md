# Proxy NGINX para Maven con Java 7

Este proyecto configura un proxy inverso usando **NGINX** para permitir que entornos con **Java 7** y **Maven 3.5** se conecten a repositorios Maven HTTPS modernos que requieren TLS 1.2 y autenticación básica.

## 🚀 Características

- **Proxy TLS 1.2**: Convierte conexiones HTTP de Maven/Java 7 a HTTPS con TLS 1.2.
- **Autenticación Básica**: Maneja credenciales de repositorios privados de forma segura.
- **Dockerizado**: Fácil despliegue con Docker Compose.
- **Configuración Flexible**: Adaptable a distintos repositorios y puertos.

## 📋 Requisitos Previos

- Docker ([Instalación](https://docs.docker.com/get-docker/))
- Docker Compose ([Instalación](https://docs.docker.com/compose/install/))
- Credenciales de acceso al repositorio remoto (usuario y contraseña).

## 🛠️ Configuración Rápida

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/maven-nginx-proxy.git
cd maven-nginx-proxy
```

### 2. Configurar variables de entorno

```yaml
REPO_URL: "https://repo.example.com" # URL del repositorio con autenticación
REPO_HOST: "repo.example.com" # Host del repositorio
REPO_USER: "tu_usuario" # Reemplaza con tu usuario
REPO_PASSWORD: "tu_password" # Reemplaza con tu contraseña
```

### 3. Construir y desplegar el contenedor

```bash
docker-compose up -d
```

### 4. Verificar el contenedor

```bash
docker-compose ps
```

### 5. Configurar el proxy en Maven

```xml
<settings>
  <mirrors>
    <mirror>
      <id>nginx-proxy</id>
      <url>http://localhost:8080</url>
      <mirrorOf>central</mirrorOf>
    </mirror>
  </mirrors>
</settings>
```

### 6. Verificar la configuración

```bash
# Verificar la conexión al repositorio
mvn dependency:get -Dartifact=org.example:example-artifact

# Ver logs del contenedor
docker-compose logs nginx-proxy
```

### Seguridad

- No exponer el puerto 8080 públicamente.
- Usar variables de entorno o un gestor de secretos (ej: Docker Secrets) para credenciales en entornos productivos.
- Rotar contraseñas periódicamente.

## 🚨 Solución de Problemas

### Errores comunes

- **401 Unauthorized**: Credenciales incorrectas. Verificar `REPO_USER` y `REPO_PASSWORD`.
- **502 Bad Gateway**: Repositorio inaccesible. Validar conectividad desde el contenedor: `docker-compose exec nginx-proxy curl -v https://repo.example.com`.
- **SSL Handshake Failed**: TLS no compatible. Asegurar que `proxy_ssl_protocols` esté configurado como `TLSv1.2`.

### Soluciones

- **401 Unauthorized**: Verificar credenciales en `REPO_USER` y `REPO_PASSWORD`.
- **502 Bad Gateway**: Validar conectividad desde el contenedor: `docker-compose exec nginx-proxy curl -v https://repo.example.com`.
- **SSL Handshake Failed**: Asegurar que `proxy_ssl_protocols` esté configurado como `TLSv1.2`.

## 📝 Licencia

Este proyecto está bajo licencia MIT.

## 📝 Nota

Este proyecto es un ejemplo básico y puede necesitar adaptaciones para entornos de producción.

## 📝 Contribución

Contribuciones son bienvenidas. Por favor, abra un Pull Request.
