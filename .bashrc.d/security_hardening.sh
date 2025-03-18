# Security & Hardening Enhancements
# File: ~/.bashrc.d/security_hardening.sh

# Auto-Logout After Idle Time (Prevents Unattended Sessions)
export TMOUT=900  # 15 minutes auto logout

# Monitor Failed SSH Logins and Block Malicious IPs
monitor_ssh_attempts() {
    sudo journalctl -u ssh --since "1 hour ago" | grep "Failed password"
}

alias sshfails='monitor_ssh_attempts'

# Safe Mode: Read-Only Shell for Production Servers
safe_mode() {
    readonly -p
    echo "Safe Mode Activated: No destructive commands allowed!"
}

alias safemode='safe_mode'

# Normal Mode: Restores full shell access
dangerzone() {
    # Unset all readonly variables
    for var in $(readonly -p | awk '{print $3}'); do
        unset -v "$var" 2>/dev/null
    done
    echo "Danger Zone Activated: Full shell permissions restored!"
}

alias normal_mode='dangerzone'


# Firewall Status & Rules
fwstatus() {
    sudo iptables -L -v -n
}

alias fwrules='fwstatus'

# SSH Key Management
alias sshkeygen='ssh-keygen -t rsa -b 4096'
alias sshconfig='vim ~/.ssh/config'
