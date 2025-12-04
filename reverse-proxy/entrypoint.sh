#!/bin/sh
set -e

# Get the UID and GID of the 'nginx' user inside the container
NGINX_UID=$(id -u nginx)
NGINX_GID=$(id -g nginx)

# Log directory path
LOG_DIR="/var/log/nginx"

# Ensure all log subdirectories exist inside the mounted volume path
SERVICE_LOG_DIRS="whodb postgres"
for service_log_dir in $SERVICE_LOG_DIRS; do
  mkdir -p "${LOG_DIR}/${service_log_dir}"
done

# Change ownership of the mounted directory and its contents
chown -R "${NGINX_UID}":"${NGINX_GID}" "${LOG_DIR}"

# Execute the main command
exec /docker-entrypoint.sh "$@"
