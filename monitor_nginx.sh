#!/bin/bash

SERVICE_NAME="nginx"
CHECK_URL="http://localhost"
LOG_FILE="/home/ubuntu/aws-linux-monitoring-project/logs/monitor.log"
WAIT_TIME=5

write_log() {
    LEVEL="$1"
    MESSAGE="$2"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$LEVEL] $MESSAGE" >> "$LOG_FILE"
}

check_dependencies() {
    command -v systemctl >/dev/null 2>&1 || { write_log "ERROR" "systemctl not found"; exit 1; }
    command -v curl >/dev/null 2>&1 || { write_log "ERROR" "curl not found"; exit 1; }
}

check_service_exists() {
    systemctl list-unit-files | grep -q "^$SERVICE_NAME.service"
}

restart_service() {
    write_log "WARNING" "$SERVICE_NAME is not healthy. Restarting service..."
    sudo systemctl restart "$SERVICE_NAME"
    sleep "$WAIT_TIME"

    if systemctl is-active --quiet "$SERVICE_NAME"; then
        write_log "INFO" "$SERVICE_NAME restarted successfully"
    else
        write_log "ERROR" "$SERVICE_NAME could not be restarted"
        exit 2
    fi
}

check_http_response() {
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$CHECK_URL")

    if [ "$HTTP_CODE" = "200" ]; then
        write_log "INFO" "$SERVICE_NAME is responding correctly with HTTP $HTTP_CODE"
    else
        write_log "WARNING" "$SERVICE_NAME returned HTTP $HTTP_CODE"
        restart_service
    fi
}

check_dependencies

if ! check_service_exists; then
    write_log "ERROR" "Service $SERVICE_NAME does not exist"
    exit 3
fi

if systemctl is-active --quiet "$SERVICE_NAME"; then
    write_log "INFO" "$SERVICE_NAME is active"
    check_http_response
else
    write_log "WARNING" "$SERVICE_NAME is inactive"
    restart_service
fi

exit 0
