# System Security & Hardening
# File: ~/.bashrc.d/sys_sec.sh

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

