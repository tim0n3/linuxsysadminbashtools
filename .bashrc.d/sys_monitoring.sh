# System Monitoring & Performance Tools
# File: ~/.bashrc.d/sys_monitoring.sh

# Live System Overview
top_syswatch() {
    echo "CPU Load: $(uptime | awk -F'load average:' '{ print $2 }')"
    free -h
    df -hT | grep -v tmpfs
    iostat -x
}

alias syswatch='top_syswatch'

# Disk Usage Alert
disk_alert() {
    local usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$usage" -ge 80 ]; then
        echo "Warning: Root disk usage is at $usage%! Consider cleaning up space."
    fi
}

alias checkdisk='disk_alert'

# Background Jobs Tracker
alias bg_jobs='jobs -l'

# Live Memory Leak Monitor
memleak_watch() {
    watch -n 1 "ps aux --sort=-%mem | head -10"
}

alias memwatch='memleak_watch'

# Auto-load on bash session
export PROMPT_COMMAND="disk_alert"
