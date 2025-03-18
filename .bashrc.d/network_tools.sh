# Network Tools & Connectivity Enhancements
# File: ~/.bashrc.d/network_tools.sh

# Show active network interfaces and their IPs
netinfo() {
    ip -o -4 addr show | awk '{print $2, $4}'
}

alias mynet='netinfo'

# Port Scan Helper
checkport() {
    nc -zv $1 $2 2>&1 | grep -q succeeded && echo "Port $2 on $1 is open" || echo "Port $2 on $1 is closed"
}

alias port='checkport'

# Traceroute Shortcut
tracenet() {
    traceroute $1
}

alias trace='tracenet'

# Show Active Connections
alias netconns='ss -tupna'

# Flush DNS Cache
alias dnsflush='sudo systemd-resolve --flush-caches'

# Speed Test
alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'

