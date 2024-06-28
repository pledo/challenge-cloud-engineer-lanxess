### Run a springboot API using Terraform for IaC and Kubernetes as application platform.

---

## Architecture Diagram:

- Cloud provider: AWS
- Network: VPC
  - Subnets: 
    - Public: Ingress Controller and other future public solutions
    - Private: Kubernetes nodes groups 
    - DataBase:  RDS and some data solutions
    - Intra: Control Plane and other sensitive applicatinos.

- EKS:
  - Addons: Kube-proxy, CoreDNS, VPC CNI, EBS CSI
  - ALB Ingress Controller: Easy AWS services integrations: WAF, SSL ...
  - AWS Secrets Manager integration: EBS CSI, External Secrets Operator
  - Karpenter: Nodes scaling
  - HPA: Pods Horizontal AutoScaling
  - Linkerd2: ServiceMesh

- Monitoring and Logs:
  - Grafana Loki: Logs management
  - Prometheus: Metrics 
  - Grafana: Visualization
  - Linkerd2Viz: ServiceMesh visualization stack.

- CI/CD:
  - CD - GitOps: ArgoCD
  - CI: Github Actions

IaC:
  - Terraform
  - Helm


![image] (docs/springboot-diagram-aws.png)  

---
> ### Improvements:
>
>- **Availability:**
>   - pod budget disruption to mitigate involuntary disruptions
>   - HPA by default: Pods scaling, ensure elasticity based on cpu, mem, latency and rps at least.
>    - Keda: Use custom metrics.
>   - Karpenter: Nodes scaling


>**Security:**
> 
>>**- K8:**
>    - Network policies
>    - Kube-Bench*:  Check deployments configuration
>    - Checkob: static code analysis tool
>    - kube-hunter: Searchs for security gaps on K8 clusters
>    - Kyverno: Policy management and enforcement
>    - RBAC, user access management
>    - Secrets Management: Install External Secrets Operator

>>  **Network:**
>    - VPN
>    - WAF


>>  **CI/CD: SAST, DAST:**

>>- **AWS: SSL Certificate**
>>- **SSL Certificate: CertManager + Let'sEncrypt**

> **GitOps - ArgoCD:** 
>  - Ingress
>  - SSL configuration
>  - Vault/SecretsManager for ArgoCD Password

> **ServiceMesh:**
>> Linkerd2 + LinkerdViz via Terraform (Helm provider)
