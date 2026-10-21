# 🚀 14-Month Cloud DevOps Engineer Roadmap

![ShellCheck CI](https://github.com/hitesh-dangi/14-Month-DevOps-Roadmap/actions/workflows/shellcheck.yml/badge.svg)
![OS](https://img.shields.io/badge/OS-Ubuntu%20WSL2-E95420?logo=ubuntu&logoColor=white)
![Shell](https://img.shields.io/badge/Scripting-Bash%20%26%20Python-4EAA25?logo=gnu-bash&logoColor=white)

Welcome to my central Cloud & DevOps engineering ledger. This repository is not a tutorial graveyard—it is an active codebase of **32+ production-grade automation scripts**, security auditors, and network diagnostic tools built from scratch using strict error handling (`set -euo pipefail`).

---

## 🗺️ The Roadmap Architecture

| Phase | Domain Focus | Key Automation Scripts & Capstones | Status |
| :--- | :--- | :--- | :--- |
| **[Phase 1](./Phase_01_Linux_and_Bash)** | **Linux & Bash Scripting Mastery** | `sysops_sentinel.sh`, `server_medic.sh`, `disk_janitor.sh`, `security_auditor.sh`, `log_parser.sh`, `malicious_ip_filter.sh` | ✅ **Completed** |
| **[Phase 2](./Phase_02_Networking_Security)** | **Networking & Security Automation** | `network_inspector.sh`, `dns_inspector.sh`, `port_scanner.sh`, `ssh_manager.sh`, `ssh_config_gen.sh`, `ufw_firewall.sh` | 🟢 **In Progress** |
| **Phase 3** | **Python for Cloud & OS Automation** | Log rotation parsers, `psutil` threshold alerting, REST API health monitors | ⏳ **Upcoming** |
| **Phase 4** | **Cloud Architecture (AWS)** | IAM, EC2, Custom VPC (Public/Private Subnets), S3 Lifecycle, ALB, `boto3` | ⏳ **Upcoming** |
| **Phase 5** | **IaC, Containers & CI/CD** | Docker, Terraform, GitHub Actions, Kubernetes | ⏳ **Upcoming** |

---

## 🖥️ Sample Execution Output (Phase 2 Diagnostics)

```text
$ ./Phase_02_Networking_Security/01_IP_and_Connectivity/network_inspector.sh
[INFO] Checking active network interfaces and routing table...
[OK] Default Gateway reachable (0% packet loss)
[OK] DNS Resolution verified via 8.8.8.8
[OK] Listening TCP Sockets audited via ss -tulnp
```

---

## 🛠️ Current Tech Stack
* **Operating System:** Ubuntu Linux (WSL2)
* **Automation & Scripting:** Bash (`set -euo pipefail`), `grep`, `awk`, `sed`, Cron
* **Networking & Security:** TCP/IP, DNS (`dig`), Socket Diagnostics (`ss`/`netstat`), Ed25519 SSH Key Management, UFW/Iptables
* **Version Control & CI:** Git, GitHub, GitHub Actions (Automated ShellCheck Linting)

> *"Complex infrastructure is just a bunch of simple scripts working together."*
