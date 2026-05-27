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