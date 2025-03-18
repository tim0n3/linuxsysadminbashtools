# User & Access Control Enhancements
# File: ~/.bashrc.d/user_mgmt.sh

# List All Sudo Users
sudo_users() {
    grep -Po '^sudo.+:\K.*$' /etc/group | tr ',' '\n'
}

alias sudousers='sudo_users'

# Show Recent User Logins
recent_logins() {
    last -a | head -n 10
}

alias lastlogins='recent_logins'

# Force Log Out Specific Users
kick_user() {
    if [ -z "$1" ]; then
        echo "Usage: kick_user <username>"
        return 1
    fi
    sudo pkill -u "$1"
    echo "User $1 has been logged out."
}

alias logoutuser='kick_user'
