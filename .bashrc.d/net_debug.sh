# Network Performance & Debugging
# File: ~/.bashrc.d/net_debug.sh

# Test MTU Size and Network Latency
mtu_test() {
    ping -M do -s 1472 -c 4 8.8.8.8
}

alias testmtu='mtu_test'

# Scan Open Ports Dynamically
portscan() {
    if [ -z "$1" ]; then
        echo "Usage: portscan <IP/Hostname>"
        return 1
    fi
    sudo nmap -vvv -sS -T4 $1
}

alias scan='portscan'

# Live Network Bandwidth Monitor
netmon() {
    sudo iftop -i $(ip route | awk '/default/ { print $5 }')
}

alias netwatch='netmon'
