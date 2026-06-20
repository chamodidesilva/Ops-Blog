<div align="center">
    <picture>
        <img src="docs/opsblog-logo.png" alt="Project Logo" width="400">
    </picture>
    
[![CI](https://img.shields.io/github/actions/workflow/status/chamodidesilva/Ops-Blog/app-ci.yaml?style=flat-square&label=CI)](https://github.com/chamodidesilva/Ops-Blog/actions/workflows/app-ci.yaml)
![Release](https://img.shields.io/github/v/release/chamodidesilva/Ops-Blog?style=flat-square)
![Last Commit](https://img.shields.io/github/last-commit/chamodidesilva/Ops-Blog?style=flat-square)
![Pull Requests](https://img.shields.io/github/issues-pr/chamodidesilva/Ops-Blog?style=flat-square)
![Issues](https://img.shields.io/github/issues/chamodidesilva/Ops-Blog?style=flat-square)
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#project-overview">Project Overview</a>
      <ul>
        <li><a href="#tech-stack">Tech Stack</a></li>
        <li><a href="#application-capabilities">Application Capabilities</a></li>
        <li><a href="#the-devops-and-cloud-evolution">The DevOps and Cloud Evolution</a></li>
      </ul>
    </li>
    <li>
      <a href="#cloud-infrastructure-architecture">Cloud Infrastructure Architecture</a>
      <ul>
        <li><a href="#high-level-components">High Level Components</a></li>
      </ul>
    </li>
    <li><a href="#iac-deployment">IaC Deployment</a></li>
    <li><a href="#devops-automation-and-git-workflow">DevOps Automation and Git Workflow</a>
      <ul>
        <li><a href="#automated-pipelines">Automated Pipelines</a></li>
        <li><a href="#git-strategy">Git Strategy</a></li>
      </ul>
    </li>
    <li><a href="#live-demo-on-demand-provisioning">Live Demo: On-Demand Provisioning</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

## Project Overview

**Ops Blog** is a DevOps-focused learning and showcase project designed to implement, test, and evolve real-world DevOps, Infrastructure as Code (IaC), and Cloud Native workflows. 
To keep the project focused on DevOps practices and operational aspects of software delivery rather than application development, the application tier uses a customized version of the [official Flask blog tutorial](https://flask.palletsprojects.com/en/stable/tutorial/). 
The core value of this repository lies entirely in how this standard workload is containerized, secured, automated, and orchestrated across cloud environments.

### Tech Stack
* **App Tier:** Python, Flask, SQLite
* **Infrastructure & Orchestration:** AWS (ECS Fargate, ALB, EFS), Terraform
* **CI/CD & Security:** GitHub Actions, Trivy, Docker, AWS OIDC

### Application Capabilities

- User authentication with register, login and logout
- Blog posts: display, create, update and delete
- SQLite database with persistent storage

### The DevOps and Cloud Evolution

This project is structured chronologically through major releases to demonstrate a practical journey from local development to cloud-native scalability:

* **v0.1.0 (Local Containerization):** Dockerizing the application, managing multi-container states with Docker Compose, and securing persistent local volumes.
* **v1.0.0 (Cloud Native Infrastructure - Current/Stable):** Transitioning the architecture completely to AWS using Terraform, abstracting networks, automating GitOps provisioning pipelines, and isolating computing layers using serverless containers.

---

## Cloud Infrastructure Architecture

The application is deployed on AWS using a structured Infrastructure-as-Code footprint managed via Terraform.

<div align="center">
    <picture>
        <img src="docs/aws-infra.png" alt="Architecture Diagram">
    </picture>
</div>

### High Level Components:
* **DNS Routing & Network Security:** A domain name (**opsblog.site**) for this app is registered in an external domain registrar and DNS service provider and connects to an **Application Load Balancer (ALB)** in AWS that manages external HTTP/HTTPS traffic and has a public SSL certificate attached via **Amazon Certificate Manager**. While the workload lives in a public subent intentionally for enabling outbound traffic bypassing the need for a NAT gateway, the network paths are strictly isolated using linked, stateful **Security Groups**.
* **Identity Management:** IAM roles are created for cross-service access and OIDC federation. ECS utilizes task execution and task roles to pull ECR images, SSM Parameter Store secrets, EFS read/writes and CloudWatch log injections. 
* **Compute:** **AWS ECS Fargate** processes application workloads in serverless containers and **Fargate Spot** capacity provider strategy ensures further cost savings. 
* **State & Persistence:** The SQLite database is attached securely to an **Amazon EFS (Elastic File System)** volume, guaranteeing container data survival across rapid tasks updates and secure connections to the file system is achieved through an Access Point. 
* **Monitoring:** an **Amazon CloudWatch** log group with a retention rule collects logs sent from ECS tasks for quick task failure troubleshooting visibility
* **Secret Management:** AWS Systems Manager's Parameter Store securely and cost effectively stores the application's session keys.

### Dynamic Infrastructure Provisioning

As this is a showcase project and does not serve production traffic, the core infrastructure is kept in a cost-optimized baseline state. Infrastructure follows a cost-conscious design, keeping only essential AWS resources running while ephemeral components are provisioned on-demand to minimize idle cost, reflecting **FinOps** best practices.

The following components remain deployed and **continuously available**:

* ECS cluster and task definitions
* Networking (VPC, subnets, routing)
* Security configurations (Security Groups, IAM roles and policies)
* Persistent storage (EFS)
* Container registry (ECR)
* DNS configuration

The **application delivery layer** is not kept running by default and is provisioned on demand. This includes:

* Application Load Balancer (ALB)
* Target groups and listeners
* ECS service (service scheduler layer)

## IaC Resource Provisioning

Terraform code is organized by AWS infrastructure category (e.g., networking, configuration, file systems, load balancing, and containers) for easier maintenance, while Terraform state is managed remotely in Amazon S3.

Terraform configuration is designed to conditionally destroy resources to adhere to the cost-concious design. The conditional behaviour is implemented using the **count** meta argument paired with the variable, **`environment_active`**. The default behaviour is to spin up all resources and it can be changed by setting the variable to false to destroy selected resources. 

---

## DevOps Automation and Git Workflow  

### Automated Pipelines

Pipelines are setup to trigger only on pull request creation and synchronization and **dorny/paths-filter** action is utilized to detect changes in file paths and selectively trigger the specific pipeline/jobs. 

* **`app-ci.yaml`:** Triggered on pull requests created for application code/Dockerfile related changes. Automatically executes code linting, code validation, vulnerability scanning via **Trivy**, logs securely into AWS using secure **OIDC**, builds the optimized Docker images, tags and pushes them cleanly to Amazon ECR.
* **`infra-pipeline.yaml`:** Automates the Terraform code execution and triggers for changes to the **terraform/** directory. Validates configurations, triggers misconfiguration scans, logs securely into AWS, generates execution plan files, and applies changes seamlessly inside AWS environment. 

### Git Strategy
* **Branching Strategy:** Maintained via a clean `main` / `develop` / `feature/*` workflow. 
* **Standards:** Adheres to [Conventional Commit](https://www.conventionalcommits.org/en/v1.0.0/) formatting rules and [Conventional Branching](https://conventionalbranch.org/) structures to maintain consistency in naming.

---

## Request a Demo

Reach out through **chamodidesil@gmail.com** to request a live application demonstration at `https://opsblog.site`. 

## Contributing

If you have any suggestions to make this project better, please fork the repo and open a pull request. 

For major changes, please open an issue first to discuss what you would like to change.

## License
This project uses the [MIT](https://github.com/chamodidesilva/Ops-Blog/blob/main/LICENSE) license.

## Contact
* Via email at **chamodidesil@gmail.com**
* Via social at **[LinkedIn](https://www.linkedin.com/in/chamodi-de-silva/)**
