

#### ToDo List:
1. ~~Create the repository~~ https://github.com/pledo/challenge-cloud-engineer-lanxess.git

2. ~~Run the given sample app locally with docker compose~~

3. ~~Config the health check endpoing.~~
```sh

livenessProbe:
  httpGet:
    path: /
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 3
  failureThreshold: 3
  successThreshold: 1
  timeoutSeconds 1

readinessProbe:
  httpGet:
    path: /
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 3
  failureThreshold: 3
  successThreshold: 1
  timeoutSeconds: 1

```
4. ~~Create application k8 manifests, using Kustomize to build the k8 objects.~~
    - ~~deployment.yaml~~
    - ~~service.yaml~~
    - ~~ingress.yaml~~
    - ~~hpa.yaml~~
    - ~~argocd-application-sample-app.yaml~~
5. ~~Create ArgoCD application structure: application file~~
6. ~~Create DockerHub repo~~
7. ~~Run K8 manifests locally with Minikubels~~
8. ~~Configure github actions file: build~~
9. ~~Confirgure GHA: deploy job~~
10. ~~Configure ArgoCD server locally, validate the cicd flow~~
11. ~~Create VPC structure~~
12. ~~Create EKS cluster: With addons kube-proxy, coredns, vpc cni, ebs csi, *external secrets~~
13. ~~Configure ALB ingress controller~~
14. ~~Prometheus + Grafana + Grafana Loki (Logs)~~
15. ~~ArgoCD~~
16. *Linkerd2, Linkerd2Viz
17. *Karpenter: Nodes scaling, Fargate
18. HPA with latency and rps metrics

```sh
* nice to have
```

### Improvements:

- Availability:
  - pod budget disruption to mitigate involuntary disruptions
  - HPA by default: Pods scaling, ensure elasticity based on cpu, mem, latency and rps at least.
    - Keda: Use custom metrics.
  - Karpenter: Nodes scaling


Security:
  - K8:
    - Network policies
    - Kube-Bench*:  Check deployments configuration
    - Checkob: static code analysis tool
    - kube-hunter: Searchs for security gaps on K8 clusters
    - Kyverno: Policy management and enforcement
    - RBAC, user access management
    - Secrets Management: Install External Secrets Operator
  
  - Network:
    - VPN
    - WAF

  - CI/CD: SAST, DAST

- AWS: SSL Certificate
- SSL Certificate: CertManager + Let'sEncrypt

- ArgoCD: 
  - Ingress
  - SSL configuration
  - Vault/SecretsManager for ArgoCD Password

- Linkerd2 + LinkerdViz via Terraform (Helm provider)
