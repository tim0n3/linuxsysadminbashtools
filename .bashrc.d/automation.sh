# Automation & Task Scheduling
# File: ~/.bashrc.d/automation.sh

# Backup Home Directory
backup_home() {
    tar -czf ~/backup_$(date +%F).tar.gz ~
    echo "Backup completed: ~/backup_$(date +%F).tar.gz"
}

alias backup='backup_home'

# Timed Execution of Commands
runlater() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: runlater <command> <time>"
        return 1
    fi
    (sleep $2 && eval "$1") &
    echo "Scheduled '$1' to run in $2 seconds."
}

# Auto-Sync Files Across Servers
autosync() {
    rsync -avh --progress ~/git/ user@remote:/sync-folder/
    echo "Sync completed!"
}

alias syncfiles='autosync'

# Borg Backups over wg-vpn
backup_system() {

        BACKUP_SERVER="borg@10.10.0.1"
        BACKUP_PATH="/home/borg/backups/$(hostname)"
        EXCLUDE="--exclude /proc --exclude /sys --exclude /dev --exclude /run --exclude /tmp --exclude /mnt --exclude /media --exclude /lost+found --exclude /home/tim/.cache --exclude /home/tim/.local"
        TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)  # Format: YYYY-MM-DD_HH-MM-SS

        # Backup directories
        borg create --stats --progress $BACKUP_SERVER:$BACKUP_PATH::${TIMESTAMP}-dotfiles \
                /home/tim/.config /home/tim/.* /home/tim/git /etc $EXCLUDE

        # Prune old backups
        borg prune -v --list $BACKUP_SERVER:$BACKUP_PATH \
                --keep-daily=8 --keep-weekly=6 --keep-monthly=1
}

alias backups='backup_system'
