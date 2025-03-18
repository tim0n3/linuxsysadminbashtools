# Automation & Job Scheduling
# File: ~/.bashrc.d/cron_jobs.sh

# List All Cron Jobs for Current User
mycron() {
    crontab -l
}

alias cronlist='mycron'

# Create Quick Cron Jobs
setcron() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: setcron <schedule> <command>"
        return 1
    fi
    (crontab -l; echo "$1 $2") | crontab -
    echo "Cron job added: $1 $2"
}

# Schedule One-Time Jobs Using `at`
onetimer() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: onetimer <time> <command>"
        return 1
    fi
    echo "$2" | at "$1"
    echo "Scheduled '$2' to run at $1."
}

alias schedule='onetimer'
