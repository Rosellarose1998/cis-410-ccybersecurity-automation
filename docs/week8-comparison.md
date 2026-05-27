# Week 8 Comparison — On-Premise Docker vs Cloud Run

| Dimension | On-Premise Docker (Wks 3–5) | Cloud Run (Week 8) |
|---|---|---|
| Infrastructure setup | 3 VMs created, Docker installed on each | Managed serverless platform, no VM setup required |
| Deployment command | SSH → docker build → docker run | GitHub Actions → build → push → Cloud Run deploy |
| TLS / HTTPS | Not configured | HTTPS automatically enabled with .run.app URL |
| Scaling approach | Manual — redeploy or add VMs | Automatic scaling based on traffic |
| Port management | Ports 5000/5001/5002 per environment | Cloud Run manages ports automatically |
| Cost when idle | VM running 24/7 regardless of traffic | Scales to zero when idle, pay only when used |
| Rollback | Re-deploy previous image manually | Cloud Run revisions allow quick rollback |
| Secrets management | GitHub Secrets → env vars in workflow | OIDC authentication and IAM roles used securely |

## Reflection Questions

### Q1
The on-premise Docker approach required more manual steps because it involved creating and managing VMs, configuring Docker manually, connecting with SSH, building containers, and running containers on different ports. Cloud Run eliminated many of these steps by automatically handling infrastructure, HTTPS, scaling, and deployment through GitHub Actions and Cloud Run services.

### Q2
With on-premise Docker, identifying the running version required checking containers and images manually on the VM. In Cloud Run, each deployment uses a commit SHA tag, making it easy to identify exactly which code version is deployed in production through Cloud Run revisions and GitHub Actions logs.

### Q3
Scale-to-zero improves security because containers are not continuously running and exposed to potential attacks when no traffic exists. This reduces the attack surface since inactive services are automatically shut down until requests are received again.

### Q4
OIDC removed the need to store long-term SSH keys and static credentials inside GitHub Secrets. This reduced the risk of credential theft, leaked secrets, and unauthorized SSH access to production infrastructure.