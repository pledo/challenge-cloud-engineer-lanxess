Setup:
1. Create a new repository using any public VCS for hosting the IaC code

2. Use the sample spring boot app from [here](https://github.com/docker/awesome-compose/tree/master/spring-postgres)

3. Please expose liveness health endpoints for this app while deploying using configs [here] (https://www.baeldung.com/spring-liveness-readiness-probes)

Guidelines:

1. Use Infrastructure as Code (IaC), preferably Terraform, to provision the necessary Azure or AWS components and set up a database. The implementation does not need to be deployed, but should be designed for testing purposes.

2. Use any GitOps framework to deploy the application.

3. You can think about all possible solutions that support the (scalability, resiliency and security) of the system.

4. Add basic logging/monitoring capabilities
Basic Documentation (README.md) and architecture diagram

5. Commit often, it's good to see small commits that build up to the result of your test, instead of one final commit with all the code.


#### ToDo List:
1. ~~Create the repository~~ https://github.com/pledo/challenge-cloud-engineer-lanxess.git

2. ~~Run the given sample app locally with docker compose~~

3. ~~Config the health check endpoing.~~
```sh
livenessProbe:
  httpGet:
    path: /
    port: 8080
    initialDelaySeconds: 3
    periodSeconds: 3

readinessProbe:
  httpGet:
    path: /
    port: 8080
    initialDelaySeconds: 3
    periodSeconds: 3
```

4. Create application k8 manifests, using Kustomize to build the k8 objects.
    - deployment.yaml
    - service.yaml
    - ingress.yaml
    - hpa.yaml
    - argocd-application-sample-app.yaml

