<div align="center">
<h3 align="center">Flask Blog App</h3>
  <p>A DevOps Anchor Project</p>
  [![Docker][docker-shield]][docker-url]
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#current-features">Current Features</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#app-structure">App Structure</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This project uses a minimal Flask application as the practice workload for designing, implementing and demonstrating modern DevOps workflows. The focus of this repository is on DevOps tooling, automation, and infrastructure. 
The project will evolve through multiple stages, as displayed in the <a href="#roadmap">Roadmap</a>. 
The application workload is based on the <a href="https://flask.palletsprojects.com/en/stable/tutorial/">official Flask blog tutorial</a> structure and intentionally paused at initial application factory creation to layer the DevOps practices on top of the workload.

### Current Features
#### Application
- Minimal Flask app endpoint returning a message
- Custom Prometheus metric tracking the endpoint in a containerized setup
- Docker compose orchestrating application and monitoring containers
#### CI/CD
- CI workflow with Flake8 linting and Pytest unit testing for the endpoint
- CD workflow deploying the Flask application to a Kubernetes cluster on a Gihub-hosted runner, which acts as the current staging environment
#### Kubernetes
- Kubernetes manifest for the Flask app deployment
- Deployment to a single node Minikube cluster
- Service created to expose the app
#### Git Workflow
- Branching strategy: main/staging/feature* 
- Branch naming follows <a href="https://conventional-branch.github.io/">Conventional Branch</a>
- Commit naming follows <a href="https://www.conventionalcommits.org/en/v1.0.0/">Conventional Commits</a>

<!-- GETTING STARTED -->
## Getting Started

Follow this section to set up the app with current features on your local dev environment

### Prerequisites

- Have Docker, Docker compose installed

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/chamodidesilva/devops-anchor-project.git
   ```
2. Run docker compose
   ```sh
   docker compose up
   ```
3. To tear down the resources, on a new terminal run,
   ```sh
   docker compose down
   ```
<!-- USAGE EXAMPLES -->
## Usage
You can explore the working endpoint in your browser: http://127.0.0.1:5000/hello
Or use the terminal,
```sh
curl http://127.0.0.1:5000/hello
```
To view prometheus UI, open it in the browser with: http://127.0.0.1:9090

<!-- ROADMAP -->
## Roadmap

### Foundations (*Completed*)
- [x] Current features
### Kubernetes
- [ ] Transition to a multi-service Kubernetes cluster (app, database, monitoring)
### Observability
- [ ] Add Prometheus to the Kubernetes cluster
- [ ] Prometheus integrated in a containerized setup
- [ ] Deploy Grafana for metrics visualization
#### Cloud & GitOps
- [ ] Migrate cluster from Minikube to AWS EKS
- [ ] Use Cloudformation to spin up resources
#### Application Expansion
- [ ] Complete the Flask blog app
- [ ] Add  SQLite database
- [ ] Implement authentication and blog features
- [ ] Expand testing (integration, smoke tests)
- [ ] Scale CI/CD workflows with application growth

## App Structure
You can view the appication structure from official Flask blog tutorial's <a href="https://flask.palletsprojects.com/en/stable/tutorial/layout/">project layout</a>.

## Contributing

If you have any suggestions to make this project better, please fork the repo and open a pull request. For major changes, please open an issue first
to discuss what you would like to change.

## Contact
Email: chamodidesil@gmail.com

## Acknowledgments
Resources that helped me throughout this project and may support you on yours.
- https://flask.palletsprojects.com/en/stable/tutorial/
- https://medium.com/@fenari.kostem/monitoring-your-web-app-with-prometheus-and-grafana-a-step-by-step-guide-8286dae606c7
- https://dev.to/camptocamp-ops/testing-application-monitoring-locally-with-a-docker-composition-47hn
- https://www.freecodecamp.org/news/learn-continuous-integration-delivery-and-deployment/
- https://kubernetes.io/docs/tasks/
