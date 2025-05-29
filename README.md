# Azure VM Monitoring

[![Terraform](https://img.shields.io/badge/IaC-Terraform-blueviolet?style=flat&logo=terraform)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Cloud-Azure-0078D4?style=flat&logo=microsoft-azure)](https://azure.microsoft.com/)
[![Monitoring](https://img.shields.io/badge/Monitoring-Enabled-green?style=flat&logo=datadog)](https://learn.microsoft.com/en-us/azure/azure-monitor/)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](LICENSE)

## Overview

This project provisions a monitored Linux Virtual Machine in Microsoft Azure using Terraform. It configures full-stack monitoring via Log Analytics Workspace and sets up alerting with an action group that sends an email on high CPU usage.

---

## Architecture

![Azure Diagram](./assets/azure-diagram.png)

---

## Components

- **Azure Linux VM** (Ubuntu 20.04 LTS)
- **Virtual Network and Subnet**
- **Network Interface + Public IP**
- **Log Analytics Workspace**
- **Boot Diagnostics**
- **Azure Monitor + Alerts**
- **Email Action Group (alert threshold: CPU > 70%)**

---

## File Structure

```
azure-vm-monitoring/
├── terraform/
│   ├── assets/
│   │   ├── azure-diagram.png
│   │   └── Azure-welcome-nginx.png
│   ├── user-data/
│   │   └── cloud-init.yaml
│   ├── main.tf
│   ├── monitoring.tf
│   ├── network.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── random.tf
│   ├── storage.tf
│   ├── terraform.tfvars
│   ├── variables.tf
│   ├── versions.tf
│   └── vm.tf
├── .gitignore
├── LICENSE
└── README.md
```

---

## Prerequisites

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- Azure CLI authenticated with `az login`
- SSH key pair (`~/.ssh/id_rsa.pub` used in this setup)

---

## How to Deploy

1. **Clone this repository**

   ```bash
   git clone https://github.com/your-username/azure-vm-monitoring.git
   cd azure-vm-monitoring/terraform
   ```

2. **Initialize Terraform**

   ```bash
   terraform init
   ```

3. **Review the execution plan**

   ```bash
   terraform plan
   ```

4. **Apply the configuration**

   ```bash
   terraform apply
   ```

5. **Monitor in Azure**

   - Navigate to Azure Portal → Log Analytics → Logs
   - Run sample KQL queries:
     ```kusto
     Perf | where ObjectName == "Processor" | sort by TimeGenerated desc | limit 10
     Heartbeat | sort by TimeGenerated desc | limit 10
     ```

---

## Alert Configuration

This setup includes:

- A metric alert for CPU > 70% (5-minute window)
- Action group that sends email to: `ac42213@gmaail.com`

---

## Cleanup

To remove all resources:

```bash
terraform destroy
```

---

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

---

## Author

**Roberto-A-Cardenas** — [GitHub](https://github.com/Roberto-A-Cardenas)

