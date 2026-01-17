# DevOps Technical Test

## 1. Project Overview

This project implements a **fully automated Dev/Test cloud infrastructure** on **Microsoft Azure**, designed to deploy and manage a containerized **FastAPI application** running on **Azure Kubernetes Service (AKS)** with a **PostgreSQL database**.

The solution follows modern **DevOps and Cloud best practices**, focusing on:

- Infrastructure as Code (IaC)
- CI/CD automation
- Security by design
- Cost awareness
- Clear operational documentation

---

## 2. Technology Stack

| Layer                    | Technology                       |
| ------------------------ | -------------------------------- |
| Cloud Provider           | Microsoft Azure                  |
| Application              | FastAPI (Python)                 |
| Containerization         | Docker                           |
| Orchestration            | Azure Kubernetes Service (AKS)   |
| Database                 | Azure PostgreSQL Flexible Server |
| Infrastructure as Code   | Terraform                        |
| CI/CD                    | GitHub Actions                   |
| Secrets Management       | Azure Key Vault                  |
| Identity                 | Azure Managed Identity           |
| Bastion Host             | Azure VM (Private)               |
| Configuration Management | Puppet                           |

---

## 3. High-Level Architecture

```
Internet
   |
   v
Azure Application Gateway
   |
   v
AKS Cluster (FastAPI Pods)
   |
   v
PostgreSQL Flexible Server
   ^
   |
Bastion Host (Private VM)
 - Puppet
 - Admin Tools (phpMyAdmin)
```

### Network Design

- Single **VNet**
- Isolated subnets:
  - AKS subnet
  - Database subnet
  - Bastion subnet

- No public access to database or bastion host
- Access via **Azure Bastion**

---

## 4. Application Design

### FastAPI Application

- REST API built with FastAPI
- Containerized using Docker (multi-stage build)
- Example endpoints:
  - `/health` – Liveness probe
  - `/ready` – Readiness probe
  - `/version` – Application version

### Database

- Azure PostgreSQL Flexible Server
- Automated backups enabled
- Explicit maintenance window
- Network access restricted to AKS subnet only

---

## 5. Kubernetes (AKS)

The application is deployed to AKS using Kubernetes manifests.

### Key Features

- Deployment with rolling updates
- Kubernetes Service for internal exposure
- Liveness and Readiness Probes
- PodDisruptionBudget to ensure availability
- NetworkPolicy restricting database access

---

## 6. Bastion Host

The Bastion Host is a **private virtual machine**, used only for administrative purposes.

### Characteristics

- No public IP address
- Access via Azure Bastion
- Managed using **Puppet**

### Puppet Responsibilities

- Administrative user management
- Docker installation
- phpMyAdmin deployment (as a container)
- Basic audit logging configuration

> The bastion host **does not host the database** and **does not interfere with application execution**.

---

## 7. Security Considerations

- **Azure Key Vault**
  - Stores database credentials and sensitive configuration

- **Managed Identity**
  - AKS and Terraform authenticate without static secrets

- **No secrets in Git**
- **No secrets in Kubernetes manifests**
- Network segmentation and restrictive NSGs

---

## 8. CI/CD Pipeline

CI/CD is implemented using **GitHub Actions**, separated by responsibility.

### Pipelines

1. **Infrastructure Pipeline**
   - Terraform fmt
   - Terraform validate
   - Terraform plan
   - Terraform apply (manual approval)

2. **Application Pipeline**
   - Build Docker image
   - Run tests
   - Push image to container registry
   - Cache Docker layers

3. **Deployment Pipeline**
   - Deploy to AKS
   - Rolling update strategy
   - Manual approval for protected environments

---

## 9. Rollback Strategy

### Application Rollback

- Kubernetes rollout undo:

  ```
  kubectl rollout undo deployment fastapi-app
  ```

### Infrastructure Rollback

- Terraform state-based rollback
- Re-apply previous version from Git

### Database

- Restore from automated PostgreSQL backups if required

---

## 10. Cost Awareness (Dev/Test)

Approximate monthly cost (Azure – Dev/Test environment):

| Resource                   | Estimated Cost        |
| -------------------------- | --------------------- |
| AKS (2× small nodes)       | ~ USD 60              |
| PostgreSQL Flexible Server | ~ USD 35              |
| Bastion VM                 | ~ USD 15              |
| Azure Bastion              | ~ USD 35              |
| Networking & Logs          | ~ USD 10              |
| **Total**                  | **~ USD 175 / month** |

The architecture is intentionally designed to be **cost-efficient**, while remaining **production-ready**.

---

## 11. Developer Guide

### Local Development

1. Build the image:

   ```
   docker build -t fastapi-app .
   ```

2. Run locally:

   ```
   docker run -p 8000:8000 fastapi-app
   ```

### Testing

- Unit tests executed during CI pipeline
- Health endpoints used by Kubernetes probes

---

## 12. Administrator Guide

- Access infrastructure via Azure Portal
- Bastion Host access through Azure Bastion
- User management via Puppet manifests
- Database access restricted to internal network only

---

## 13. Future Improvements

- Enable HA for PostgreSQL (Production)
- Separate AKS node pools per workload
- Add monitoring with Azure Monitor / Prometheus
- Blue/Green or Canary deployments

---

## 14. Conclusion

This project demonstrates a **complete DevOps lifecycle**, from infrastructure provisioning to application deployment, with strong emphasis on **security**, **automation**, and **operational clarity**.

It is intentionally designed to be **simple enough for Dev/Test**, yet **robust enough to scale into production**.

---
