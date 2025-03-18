# Logging & Alerts Integration
# File: ~/.bashrc.d/logging_alerts.sh

LOG_FILE="$HOME/.admin_log"

log_event() {
    local message="$1"
    echo "$(date "+%Y-%m-%d %H:%M:%S") - $message" >> "$LOG_FILE"
}

alert_terminal() {
    echo -e "\e[1;31m[ALERT] $1\e[0m"
}

# Email Alerts (Requires mailutils or mailx installed)
alert_email() {
    local subject="$1"
    local message="$2"
    echo "$message" | mail -s "$subject" admin@example.com
}

# Webhook Alerts (e.g., Slack/Discord)
alert_webhook() {
    local message="$1"
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" "https://hooks.slack.com/services/your-webhook-url"
}

alert_kuma() {
    local kuma_url="http://your-uptime-kuma-instance/api/push/{monitor_id}?status=down&msg=$1"
    curl -X GET "$kuma_url"
}

alert_telegram() {
    local bot_token="your_bot_token"
    local chat_id="your_chat_id"
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$bot_token/sendMessage" -d chat_id="$chat_id" -d text="$message"
}

alert_mailgun() {
    local api_key="your_api_key"
    local domain="your_domain"
    local subject="$1"
    local message="$2"
    curl -s --user "api:$api_key" \
        https://api.mailgun.net/v3/$domain/messages \
        -F from="Admin Alert <alert@$domain>" \
        -F to="admin@example.com" \
        -F subject="$subject" \
        -F text="$message"
}

# Example Usage
# log_event "System boot detected."
# alert_terminal "High CPU Load Detected!"
# alert_email "Security Alert" "Failed SSH login attempt detected."
# alert_webhook "Disk Usage Exceeded 90%!"
# alert_kuma "Server Unreachable!"
# alert_telegram "Disk Space Low!"
# alert_mailgun "Service Crash Detected" "MySQL service has stopped."

