#!/bin/bash

# Cross-Platform Package Manager Functions and Aliases for Debian, RHEL, Arch, and SUSE

#set -e  # Exit script if any command fails

LOG_FILE="$HOME/package_manager.log"
log() {
    local TIMESTAMP="$(date +'%Y-%m-%d %H:%M:%S')"
    echo "$TIMESTAMP $1" | tee -a "$LOG_FILE"
}

# Detect the best available package manager
for manager in apt dnf yum pacman zypper; do
    if command -v "$manager" &>/dev/null; then
        PKG_MANAGER="$manager"
        break
    fi
done

# Prioritize DNF over YUM on RHEL-based systems
if [[ "$PKG_MANAGER" == "yum" && "$(command -v dnf)" ]]; then
    PKG_MANAGER="dnf"
fi

if [[ -z "$PKG_MANAGER" ]]; then
    log "[ERROR] Unsupported package manager. Exiting."
    exit 1
fi

echo "Package Manager Detected: $PKG_MANAGER"
echo "Logging output to: $LOG_FILE"

echo "Available Commands:"
echo "  updatebasesystem - Update system packages without installing new ones"
echo "  fullupgrade - Perform a full system upgrade"
echo "  check-upgrades - List pending package upgrades"
echo "  backup-before-upgrade - Backup list of installed packages"
echo "  cleanup-system - Remove unused dependencies and clean cache"
echo "  whichpkg <file> - Find which package owns a given file"
echo "  biggest-packages - List the largest installed packages"

updatebasesystem() {
    log "[INFO] Updating system packages without installing new packages..."
    {
        case "$PKG_MANAGER" in
            apt) sudo apt update && sudo apt upgrade --without-new-pkgs --no-install-recommends -y ;;
            dnf|yum) sudo $PKG_MANAGER upgrade --security -y ;;
            pacman) sudo pacman -Syu --needed --noconfirm ;;
            zypper) sudo zypper refresh && sudo zypper update --no-recommends ;;
        esac
    } | tee -a "$LOG_FILE"
    log "[INFO] Update completed."
}

fullupgrade() {
    log "[INFO] Performing full system upgrade for $PKG_MANAGER..."
    {
        case "$PKG_MANAGER" in
            apt) sudo apt update && sudo apt full-upgrade -y ;;
            dnf|yum) sudo $PKG_MANAGER upgrade -y ;;
            pacman) sudo pacman -Syu --noconfirm ;;
            zypper) sudo zypper update -y ;;
        esac
    } | tee -a "$LOG_FILE"
    log "[INFO] Full system upgrade completed."
}

check-upgrades() {
    log "[INFO] Checking for pending upgrades..."
    case "$PKG_MANAGER" in
        apt) cmd="apt list --upgradable 2>/dev/null | grep -v 'Listing...'" ;;
        dnf|yum) cmd="sudo $PKG_MANAGER check-update" ;;
        pacman) cmd="pacman -Qu" ;;
        zypper) cmd="zypper list-updates" ;;
    esac
    eval "$cmd" | tee -a "$LOG_FILE"
    log "[INFO] Upgrade check completed."
}

backup-before-upgrade() {
    BACKUP_FILE="$HOME/package_list_backup_$(date +%Y%m%d_%H%M%S).list"
    log "[INFO] Backing up installed package list to $BACKUP_FILE..."
    case "$PKG_MANAGER" in
        apt) dpkg --get-selections | awk '{print $1}' > "$BACKUP_FILE" ;;
        dnf|yum) rpm -qa > "$BACKUP_FILE" ;;
        pacman) pacman -Qqe > "$BACKUP_FILE" ;;
        zypper) zypper se --installed-only > "$BACKUP_FILE" ;;
    esac
    log "[INFO] Backup completed: $BACKUP_FILE"
}

cleanup-system() {
    log "[INFO] Cleaning up unused dependencies and cache..."
    case "$PKG_MANAGER" in
        apt) sudo apt autoremove -y && sudo apt autoclean ;;
        dnf|yum) sudo $PKG_MANAGER autoremove -y ;;
        pacman) [[ -n "$(pacman -Qdtq)" ]] && sudo pacman -Rns $(pacman -Qdtq) --noconfirm ;;
        zypper) sudo zypper clean --all ;;
    esac
    log "[INFO] Cleanup completed."
}

whichpkg() {
    log "[INFO] Checking which package owns file: $1"
    case "$PKG_MANAGER" in
        apt) dpkg -S "$1" 2>/dev/null || log "[WARN] File not owned by any package." ;;
        dnf|yum) sudo $PKG_MANAGER provides "$1" ;;
        pacman) pacman -Qo "$1" ;;
        zypper) zypper wp "$1" ;;
    esac
}

biggest-packages() {
    log "[INFO] Displaying top 10 largest installed packages..."
    case "$PKG_MANAGER" in
        apt) dpkg-query -W --showformat='${Installed-Size;10}\t${Package}\n' | sort -nr | head -10 ;;
        dnf|yum) sudo $PKG_MANAGER repoquery --installed --qf "%{size} %{name}" | sort -nr | head -10 ;;
        pacman) sudo pacman -Qi | awk '/^Installed Size/ {print $4" "$5" "$3}' | sort -nr | head -10 ;;
        zypper) rpm -qa --queryformat '%{SIZE} %{NAME}\n' | sort -nr | head -10 ;;
    esac
}

log "[INFO] Package management script loaded for $PKG_MANAGER."

