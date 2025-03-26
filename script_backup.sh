#!/bin/bash

# Configuración
BACKUP_DIR="/home/andres/backups"
SOURCE_DIR="/home/andres/Documentos/UNAB"
LOG_FILE="/var/log/script_backup.log"
DAYS_TO_KEEP=7

# Función de log
log_message() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Crear backup
log_message "Iniciando copia de seguridad..."
tar -czf "$BACKUP_DIR/backup_$(date +'%Y%m%d').tar.gz" "$SOURCE_DIR"
log_message "Copia de seguridad completada."

# Limpiar logs antiguos (más de 7 días)
log_message "Eliminando logs antiguos..."
sudo find /var/log -name "*.log" -type f -mtime +$DAYS_TO_KEEP -exec rm -f {} \;
log_message "Limpieza de logs finalizada."

# Actualizar paquetes del sistema
log_message "Iniciando actualización de paquetes..."
sudo apt-get update -y
# si se quiere instalar automáticamente los paquetes podria utilizar 
# sudo apt-get upgrade -y
log_message "Actualización de paquetes completada."

log_message "Script finalizado."
