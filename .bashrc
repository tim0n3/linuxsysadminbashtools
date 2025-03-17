# Ultimate Bashrc for Server Administration & Troubleshooting
# Author: tim0n3
# Version: 1.2

# Load Modular Bash Extensions if available
if [ -d "$HOME/.bashrc.d" ]; then
    for file in $HOME/.bashrc.d/*.sh; do
        [ -r "$file" ] && source "$file"
    done
fi

# 1️⃣ System Info & Performance Monitoring
alias sysinfo='echo "CPU: $(lscpu | grep "Model name" | cut -d":" -f2)" && free -h && df -h'
alias top10mem='ps aux --sort=-%mem | head -11'
alias top10cpu='ps aux --sort=-%cpu | head -11'
alias iostat='iostat -x 1 5'
alias netstatp='netstat -tulnp'
alias diskusage='df -hT | grep -v tmpfs'
alias meminfo='grep -E "MemTotal|MemFree|Buffers|Cached" /proc/meminfo'

# 2️⃣ Enhanced Navigation & Shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias h='history | tail -20'
alias bd='cd ~'
alias dirs='dirs -v'

dirstack() { pushd "$1" > /dev/null; }
popdir() { popd > /dev/null; }

# 3️⃣ Advanced Aliases & Functions
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias pkgl='dpkg -l | grep'
alias yuml='yum list installed | grep'
alias pacl='pacman -Q | grep'

# Quick file size lookup
fs() { du -sh "$1"; }

# 4️⃣ Security & Logging Enhancements
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE="&:ls:cd:cd -:pwd:exit:date:* --help"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias shutdown='sudo shutdown -h now'
alias reboot='sudo reboot'
alias lock='vlock'

# Log all executed commands with timestamps
export PROMPT_COMMAND='history -a; history -w; echo "$(date "+%Y-%m-%d %T") $(whoami) $(history 1)" >> ~/.bash_exec_log'

# Load Modular Scripts
mkdir -p ~/.bashrc.d
[ -f ~/.bashrc.d/sys_monitoring.sh ] && source ~/.bashrc.d/sys_monitoring.sh
[ -f ~/.bashrc.d/network_tools.sh ] && source ~/.bashrc.d/network_tools.sh
[ -f ~/.bashrc.d/security_hardening.sh ] && source ~/.bashrc.d/security_hardening.sh
[ -f ~/.bashrc.d/git_devops.sh ] && source ~/.bashrc.d/git_devops.sh
[ -f ~/.bashrc.d/automation.sh ] && source ~/.bashrc.d/automation.sh

# 5️⃣ Network & Connectivity Tools
alias myip='curl -s ifconfig.me'
alias ports='netstat -tulanp'
alias pingtest='ping -c 5 8.8.8.8'
alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'
alias whoison='who -Hu'
alias connections='ss -tupna'
alias dnsflush='sudo systemd-resolve --flush-caches'

# 6️⃣ SSH & Remote Management Enhancements
alias sshr='ssh -o ServerAliveInterval=60 -o ServerAliveCountMax=2'
alias sshkey='ssh-keygen -t rsa -b 4096'
alias sshconfig='vim ~/.ssh/config'
alias rsyncp='rsync -avh --progress'

# 7️⃣ Automation & Scripting Helpers
mkcd() { mkdir -p "$1" && cd "$1"; }
cleanup_logs() { find /var/log -type f -name "*.log" -mtime +7 -delete; }
backup_home() { tar -czf ~/backup_$(date +%F).tar.gz ~; }

# 8️⃣ Custom Prompt & Visual Enhancements
#export PS1='\[\e[1;32m\]\u@\h \[\e[1;34m\]\w \[\e[1;31m\]\$\[\e[0m\] '

## Show Git branch in prompt if inside a Git repository
#parse_git_branch() {
#  git branch 2>/dev/null | grep '*' | sed 's/* //'
#}
#export PS1='\[\e[1;32m\]\u@\h \[\e[1;34m\]\w\[\e[31m\]$(parse_git_branch)\[\e[0m\] \$ '

## Function to get current Git branch (if in a Git repo)
#parse_git_branch() {
#  git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null
#}

# Define a beautiful Bash prompt with icons
#export PS1='\[\e[1;36m\]⏱ \t \[\e[1;32m\]\u@\h \[\e[1;34m\] \w \[\e[1;33m\] $(parse_git_branch)\[\e[0m\]\n\$ '


## Function to get current Git branch (if in a Git repo)
#parse_git_branch() {
#  git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null
#}
#
## Define a stylish & polished Bash prompt
#export PS1='
#\[\e[1;36m\]⏰ \t  \[\e[1;32m\]\u@\h \[\e[1;34m\]❖ \w\[\e[1;33m\] ⫸ $(parse_git_branch)\[\e[0m\]
#\[\e[1;37m\]❯ \[\e[0m\]'
#

## Function to get current Git branch (if in a Git repo)
#parse_git_branch() {
#  git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null
#}
#
## Define a soft-colored, developer-friendly Bash prompt
#export PS1='
#\[\e[38;5;117m\]⏰ \t  \[\e[38;5;72m\]\u@\h \[\e[38;5;110m\]❖ \w\[\e[38;5;180m\] ⫸ $(parse_git_branch)\[\e[0m\]
#\[\e[38;5;250m\]❯ \[\e[0m\]'

## Function to get current Git branch (if in a Git repo)
#parse_git_branch() {
#  git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null
#}
#
## Define a low-contrast, night-friendly Bash prompt
#export PS1='
#\[\e[38;5;109m\]⏰ \t  \[\e[38;5;65m\]\u@\h \[\e[38;5;67m\]❖ \w\[\e[38;5;179m\] ⫸ $(parse_git_branch)\[\e[0m\]
#\[\e[38;5;244m\]❯ \[\e[0m\]'

## Function to get current Git branch (if in a Git repo)
#parse_git_branch() {
#  git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null
#}
#
## Dynamic User/Root Styling
#if [[ $EUID -eq 0 ]]; then
#  # Root User Colors (Red for Warning)
#  USER_COLOR="\[\e[38;5;124m\]"  # Muted Red
#  PROMPT_SYMBOL="\[\e[38;5;160m\]#"  # Bright Red for Root
#else
#  # Normal User Colors
#  USER_COLOR="\[\e[38;5;65m\]"  # Muted Green
#  PROMPT_SYMBOL="\[\e[38;5;244m\]❯"  # Soft Gray
#fi
#
## Stylish, Night-Friendly Prompt with Root Differentiation
#export PS1='
#\[\e[38;5;109m\]⏰ \t  '"$USER_COLOR"'\u@\h \[\e[38;5;67m\]❖ \w\[\e[38;5;179m\] ⫸ $(parse_git_branch)\[\e[0m\]
#'"$PROMPT_SYMBOL"' \[\e[0m\]'

## Function to get current Git branch (if in a Git repo)
#parse_git_branch() {
#  git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null
#}
#
## Detect user type and set colors
#if [[ $EUID -eq 0 ]]; then
#  # Root User: Bold, Blinking Red
#  USER_COLOR="\[\e[5;1;91m\]"  # Blinking, bold red
#  PROMPT_SYMBOL="\[\e[5;1;91m\]#"  # Blinking, bold red `#`
#else
#  # Normal User: Rose-Pine Inspired Colors
#  USER_COLOR="\[\e[38;5;147m\]"  # Soft Lavender
#  PROMPT_SYMBOL="\[\e[38;5;250m\]❯"  # Soft White
#fi
#
## Rose-Pine styled prompt
#export PS1='
#\[\e[38;5;244m\][\[\e[38;5;109m\]⏳ \t \[\e[38;5;244m\]][\[\e[38;5;147m\] \u from  \h\[\e[38;5;244m\]]
#[\[\e[38;5;181m\] \w\[\e[38;5;244m\]][\[\e[38;5;179m\] $(parse_git_branch)\[\e[38;5;244m\]]
#\[\e[38;5;244m\]╰─'"$PROMPT_SYMBOL"' \[\e[0m\]'

## Function to get current Git branch (if in a Git repo)
#parse_git_branch() {
#  git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null
#}
#
## Function to check last command status
#last_cmd_status() {
#  if [[ $? -eq 0 ]]; then
#    echo -e "\e[38;5;76m✅"  # Green check for success
#  else
#    echo -e "\e[38;5;196m❌"  # Red cross for failure
#  fi
#}
#
## Get System Information (WSL Safe)
#get_system_info() {
#  echo -e "\e[38;5;109m🔥 $(sensors | grep 'temp' | awk '{print $2}')  \e[38;5;147m👥 $(who | wc -l) users  \e[38;5;181m📡 $(ip route get 1.1.1.1 | awk '{print $7}')"
#}
#
## Detect user type and set colors
#if [[ $EUID -eq 0 ]]; then
#  # Root User: Bold, Blinking Red
#  USER_COLOR="\e[5;1;91m"  # Blinking, bold red
#  PROMPT_SYMBOL="\e[5;1;91m#"  # Blinking, bold red `#`
#else
#  # Normal User: Rose-Pine Inspired Colors
#  USER_COLOR="\e[38;5;147m"  # Soft Lavender
#  PROMPT_SYMBOL="\e[38;5;250m❯"  # Soft White
#fi
#
## Rose-Pine styled prompt with system info & status indicator
#export PS1='
#\[\e[38;5;244m\][\[\e[38;5;109m\]🕒 \t \[\e[38;5;244m\]][\[\e[38;5;147m\]👤 \u from 💻 \h\[\e[38;5;244m\]]
#[\[\e[38;5;181m\]📁 \w\[\e[38;5;244m\]][\[\e[38;5;179m\]🌱 $(parse_git_branch)\[\e[38;5;244m\]]
#$(get_system_info)
#\e[38;5;244m╰─$(last_cmd_status) '"$PROMPT_SYMBOL"' \e[0m'
# Function to get current Git branch (if in a Git repo)
parse_git_branch() {
  git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null
}

# Store the last command exit status before each prompt
update_exit_status() {
  EXIT_STATUS=$?
}

# Function to check last command status (reads EXIT_STATUS)
last_cmd_status() {
  if [[ $EXIT_STATUS -eq 0 ]]; then
    echo -e "\e[38;5;76m✅"  # Green check for success
  else
    echo -e "\e[38;5;196m❌"  # Red cross for failure
  fi
}

# Get System Information (WSL Safe)
get_system_info() {
  echo -e "\e[38;5;109m🔥 $(sensors | grep 'temp' | awk '{print $2}')  \e[38;5;147m👥 $(who | wc -l) users  \e[38;5;181m📡 $(ip route get 1.1.1.1 | awk '{print $7}')"
}

# Detect user type and set colors
if [[ $EUID -eq 0 ]]; then
  # Root User: Bold, Blinking Red
  USER_COLOR="\e[5;1;91m"  # Blinking, bold red
  PROMPT_SYMBOL="\e[5;1;91m#"  # Blinking, bold red `#`
else
  # Normal User: Rose-Pine Inspired Colors
  USER_COLOR="\e[38;5;147m"  # Soft Lavender
  PROMPT_SYMBOL="\e[38;5;250m❯"  # Soft White
fi

# Run update_exit_status before each prompt
PROMPT_COMMAND="update_exit_status"

# Rose-Pine styled prompt with system info & status indicator
export PS1='
\[\e[38;5;244m\][\[\e[38;5;109m\]🕒 \t \[\e[38;5;244m\]][\[\e[38;5;147m\]👤 \u from 💻 \h\[\e[38;5;244m\]]
[\[\e[38;5;181m\]📁 \w\[\e[38;5;244m\]][\[\e[38;5;179m\]🌱 $(parse_git_branch)\[\e[38;5;244m\]]
$(get_system_info)
\e[38;5;244m╰─$(last_cmd_status) '"$PROMPT_SYMBOL"' \e[0m'


# Apply Changes
#. ~/.bashrc
