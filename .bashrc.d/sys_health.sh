# System Health & Alerts
# File: ~/.bashrc.d/sys_health.sh

# Live System Health Summary
syshealth() {
    echo "=== System Health Overview ==="
    echo "Uptime: $(uptime -p)"
    echo "CPU Load: $(uptime | awk -F'load average:' '{ print $2 }')"
    echo "Memory Usage:"
    free -h
    echo "Disk Usage:"
    df -hT | grep -v tmpfs
    echo "Zombie Processes: $(ps aux | awk '{ if ($8 == "Z") { print } }' | wc -l)"
}

alias health='syshealth'

# Load Average Alert
load_alert() {
    local load=$(awk '{print $1}' /proc/loadavg)
    local threshold=5.0  # Adjust based on server capacity
    if (( $(echo "$load > $threshold" | bc -l) )); then
        echo "⚠️ High Load Alert: Load average is $load"
    fi
}

alias checkload='load_alert'

# Check for Zombie Processes
_zombies() {
        ps aux | awk '$8 == "Z"' | wc -l
}

alias zombies="_zombies"
