# System Security & Hardening
# File: ~/.bashrc.d/sys_sec.sh

[ -f ~/.bashrc.d/logging_alerts.sh ] && . ~/.bashrc.d/logging_alerts.sh

# Check if Essential Security Services are Running
sec_check() {
    echo "=== Security Services Status ==="
    systemctl is-active nftables && echo "Firewall: Active" || echo "Firewall: Inactive"
    systemctl is-active fail2ban && echo "Fail2Ban: Active" || echo "Fail2Ban: Inactive"
    systemctl is-active apparmor && echo "AppArmor: Active" || echo "AppArmor: Inactive"
}

alias checksec='sec_check'

# Auto-Refresh Firewall Rules
fw_reload() {
    sudo systemctl restart nftables && echo "Firewall rules reloaded."
}

alias reloadfw='fw_reload'

# Live Log Monitoring
watchlogs() {
    sudo tail -f /var/log/auth.log
}

alias authlog='watchlogs'

# SSH Alerts
monitor_ssh_attempts() {
    sudo journalctl -u ssh --since "1 hour ago" | grep "Failed password" | while read line; do
        log_event "🚨 Failed SSH login detected: $line"
        alert_terminal "🚨 Unauthorized SSH Attempt!"
        #alert_email "Security Alert" "Failed SSH attempt detected!"
    done
}

alias sshalerts='monitor_ssh_attempts'
