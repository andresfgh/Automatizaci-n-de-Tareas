# Automatizaci-n-de-Tareas
Este script de Bash automatiza tareas de mantenimiento en Ubuntu: realiza copias de seguridad, elimina logs antiguos y actualiza paquetes del sistema. Puede ejecutarse manualmente o programarse con `cron`, facilitando el mantenimiento regular del sistema sin intervención del usuario.
# 📌 Configuración

```
BACKUP_DIR="/home/andres/backups"  # 📂 Carpeta donde se guardarán los backups
SOURCE_DIR="/home/andres/Documentos/UNAB"  # 📁 Carpeta que queremos respaldar
LOG_FILE="/var/log/script_backup.log"  # 📝 Archivo donde se guardarán los registros del script
DAYS_TO_KEEP=7  # ⏳ Número de días antes de eliminar logs antiguos

```

# 📝 Función para registrar mensajes en el log
```
log_message() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}
```

# 🗄️ Crear Backup
```
log_message "Iniciando copia de seguridad..."
tar -czf "$BACKUP_DIR/backup_$(date +'%Y%m%d').tar.gz" "$SOURCE_DIR"
log_message "Copia de seguridad completada. ✅"
```

# 🧹 Eliminar logs antiguos (más de 7 días)
```
log_message "Eliminando logs antiguos..."
sudo find /var/log -name "*.log" -type f -mtime +$DAYS_TO_KEEP -exec rm -f {} \;
log_message "Limpieza de logs finalizada. 🗑️"
```

# 🔄 Actualizar paquetes del sistema
```
log_message "Iniciando actualización de paquetes..."
sudo apt-get update -y
```

# 📌 Si se quiere instalar automáticamente los paquetes, se puede usar:

```
sudo apt-get upgrade -y
log_message "Actualización de paquetes completada. ⬆️✅"
```

# 🎯 Finalización
```
log_message "Script finalizado. 🎉"
```
