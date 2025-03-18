# 🔧 Bash Admin Toolkit

## 🚀 Overview
This repository contains a modular and extensible **Bash configuration stack** designed for **server administration, monitoring, and automation**. Each module is stored in the `~/.bashrc.d/` directory and provides specialized functionality such as **system health monitoring, security hardening, logging, and alerting**.

## 📂 Structure
```
.bashrc.d/
│── automation.sh        # Task scheduling & backup automation
│── cron_jobs.sh         # Cron job & at command management
│── git_devops.sh        # Git workflow improvements
│── logging_alerts.sh    # Centralized logging & multi-method alerts
│── net_debug.sh         # Network debugging & performance monitoring
│── network_tools.sh     # Network utilities & connectivity enhancements
│── security_hardening.sh# Security & firewall hardening
│── sys_health.sh        # System performance monitoring & alerts
│── sys_sec.sh           # Security monitoring & SSH hardening
│── user_mgmt.sh         # User & access control enhancements
│── logging_guide.md     # Step-by-step guide for enabling logs & alerts
└── README.md            # Project documentation
```

## 🔧 Installation
```bash
git clone https://github.com/YOUR_USERNAME/ultimate-bash-admin.git ~/.bashrc.d
```
Add the following line to your `~/.bashrc` to enable the modules:
```bash
for file in ~/.bashrc.d/*.sh; do [ -r "$file" ] && source "$file"; done
```
Then reload your shell:
```bash
source ~/.bashrc
```

## ⚙️ Features
- **📊 System Health Monitoring:** CPU load, disk space, memory usage alerts.
- **🛡 Security Hardening:** SSH monitoring, firewall rule refresh, user access tracking.
- **📡 Network Tools:** Open port scanning, network interface analysis, bandwidth monitoring.
- **📜 Logging & Alerts:** Centralized logs with alerts via **Email, Telegram, Slack, Mailgun, and Uptime Kuma**.
- **⚡ Automation:** Task scheduling, backup automation, and quick cron job creation.
- **🐙 DevOps Enhancements:** Git branch auto-completion, quick deployments, and workflow shortcuts.

## 📌 Usage
### ✅ Example Commands
#### 🔍 **System Health Check**
```bash
health
checkdisk
checkload
```
#### 🔐 **Security & User Management**
```bash
sshfails
sudousers
logoutuser username
```
#### 📡 **Network Debugging**
```bash
netwatch
portscan example.com
trace example.com
```
#### 🔔 **Alerts & Logging**
```bash
alert_terminal "Test Alert!"
alert_email "Test Subject" "Test Email Message!"
alert_telegram "Test Telegram Alert!"
alert_webhook "Test Slack Alert!"
alert_kuma "Test Uptime Kuma Alert!"
```

## 🛠 Contributing
1. **Fork the repository**.
2. **Create a feature branch** (`git checkout -b new-feature`).
3. **Commit your changes** (`git commit -m "Added feature XYZ"`).
4. **Push to the branch** (`git push origin new-feature`).
5. **Create a pull request**.

## 📜 License
This project is licensed under the **MIT License**. See `LICENSE` for details.

---
