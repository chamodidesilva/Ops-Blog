<div align="center">
<h3 align="center">Ops Blog</h3>
  <p>End-to-end DevOps automation for a Flask blog application</p>

![Last Commit](https://img.shields.io/github/last-commit/chamodidesilva/Ops-Blog)
![Repo Size](https://img.shields.io/github/repo-size/chamodidesilva/Ops-Blog)
![Pull Requests](https://img.shields.io/github/issues-pr/chamodidesilva/Ops-Blog)
![Issues](https://img.shields.io/github/issues/chamodidesilva/Ops-Blog)
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
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This project uses a minimal Flask application as the practice workload for designing, implementing and demonstrating modern DevOps workflows. The focus of this repository is on DevOps tooling, automation, and infrastructure. 
The project will evolve through multiple stages, as shown in the <a href="#roadmap">roadmap</a>. 
The application workload is based on the <a href="https://flask.palletsprojects.com/en/stable/tutorial/">official Flask blog tutorial</a> structure and intentionally paused at initial application factory creation to layer the DevOps practices on top of the workload.

### Current Features

[![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)](https://flask.palletsprojects.com/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)](https://prometheus.io/)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)](https://github.com/features/actions)

#### Application
- Minimal Flask app endpoint returning a message
- Custom Prometheus metric tracking the endpoint in a containerized setup
- Prometheus integrated in a containerized setup
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
   git clone https://github.com/chamodidesilva/Ops-Blog.git
   ```
2. Run docker compose
   ```sh
   docker compose up -d
   ```
3. Tear down the resources
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
View the Prometheus UI in the browser with: http://127.0.0.1:9090

Execute the below query which shows the number of requests hitting the /hello endpoint
```
hello_request_count_total
```
<!-- ROADMAP -->
## Roadmap

### Foundation (*Completed*)
- [x] <a href="#current-features">Current features</a>
### Kubernetes
- [ ] Transition to a multi-service Kubernetes cluster (app, database, monitoring)
### Observability
- [ ] Add Prometheus to the Kubernetes cluster
- [ ] Deploy Grafana for metrics visualization
#### Cloud & GitOps
- [ ] Migrate cluster from Minikube to AWS EKS
- [ ] Use Cloudformation to spin up resources
#### Application Expansion
- [ ] Complete the Flask blog app workload
- [ ] Add  SQLite database
- [ ] Implement authentication and blog features
- [ ] Expand testing (integration, smoke tests)
- [ ] Scale CI/CD workflows with application growth

## App Structure
You can view the appication structure from official Flask blog tutorial's <a href="https://flask.palletsprojects.com/en/stable/tutorial/layout/">project layout</a>.

## Contributing

If you have any suggestions to make this project better, please fork the repo and open a pull request. 

For major changes, please open an issue first
to discuss what you would like to change.

## License
This project uses the [MIT](https://github.com/chamodidesilva/Ops-Blog/blob/main/LICENSE) license.

## Contact
Email: chamodidesil@gmail.com

## Acknowledgments
Resources that helped me throughout this project and may support you on yours.
* [Flask tutorial](https://flask.palletsprojects.com/en/stable/tutorial/)
* [Add Prometheus and Grafana monitoring to a web app](https://medium.com/@fenari.kostem/monitoring-your-web-app-with-prometheus-and-grafana-a-step-by-step-guide-8286dae606c7)
* [Local application monitoring testing with Docker Compose](https://dev.to/camptocamp-ops/testing-application-monitoring-locally-with-a-docker-composition-47hn)
* [The CI/CD handbook](https://www.freecodecamp.org/news/learn-continuous-integration-delivery-and-deployment/)
* [Kubernetes](https://kubernetes.io/docs/tasks/)
* [Choose an Open Source License](https://choosealicense.com)
