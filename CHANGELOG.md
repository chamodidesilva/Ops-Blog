# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

### Removed

## [1.0.0] - 2026-06-22

### Added

#### AWS Infrastructure

- Amazon ECS deployment using AWS Fargate
- Application Load Balancer (ALB) for HTTP traffic routing
- Amazon EFS integration for persistent application storage
- Amazon ECR repository for container image storage
- Amazon VPC networking components for network level resource isolation
- Amazon VPC Security Group rules for restricting access to public subnet resources
- AWS IAM roles for cross-service resource access
- AWS SSM Parameter Secret key-pair for Flask session secret
- AWS ACM storing external DNS registrar issued SSL certificate
- AWS CloudWatch log group for storing ECS task logs 

#### IaC

- Organized Terraform files per AWS infrastructure category
- Setup remote state management with AWS S3 
- Dynamically provision a selected set of resources that do not cost to stay idle using a variable switch

#### CI/CD Pipeline

- Authenticate with AWS securely via OIDC federation using IAM roles
- **`orchestrator.yaml`** to generate decision logic to call app-ci or infra-cd workflows using **`workflow_call`** triggers
- Utilize **`dorny/paths-filter`** to detect changes based on file paths
- **`app-ci.yaml`** to automates application code change integrations
- **`infra-cd.yaml`** to automate Infrastructure as Code change integrations and deployments
- Utilize a **`.trivyignore`** file to intentionally bypass specific vulnerabilities

### Changed

- Migrated application deployment from local Docker Compose to AWS ECS
- Replaced local container orchestration with managed AWS infrastructure
- Updated project architecture to support cloud-native deployment
- Updated Github Workflows to separately automate app delivery and infrastructure deployment concerns
- Updated Flask application title to OpsBlog

### Removed

- Docker compose local orchestration of the containerized application with a Docker volume

## [0.1.0] - 2026-01-08

### Added

- User authentication system with register, login, and logout functionality
- Blog post management with full CRUD operations (create, read, update, delete)
- SQLite database integration
- Containerized application with Docker and Docker compose for orchestration
- Docker named volume for data persistence
- CI pipeline running linting, tests, coverage and build steps
- Documentation:
    - Docs folder - ci-cd-pipeline documentation
    - README.md file
    - This CHANGELOG.md file
    - gitignore and dockerignore files

