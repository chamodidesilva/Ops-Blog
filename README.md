<div align="center">
<h3 align="center">Flask Blog App</h3>
  <p>A DevOps Anchor Project</p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Current Capabilites</a></li>
      </ul>
      <ul>
        <li><a href="#built-with">Roadmap</a></li>
      </ul><!-- ABOUT THE PROJECT -->
## About The Project
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
    <li><a href="#license">App Structure</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This project uses a minimal Flask application as the workload for practicing and demonstrating modern DevOps workflows. The focus of this repository is on DevOps tooling, automation, and infrastructure. 
The project will evolve through multiple stages, including containerization, CI/CD, testing, deployment to Kubernetes and integration with AWS.

### Current Capabilites
- Basic Flask app displaying a hello-world page
- App containerized with Docker
- Prometheus set up to monitor the Flask app
- Prometheus and app containers orchestrated with Docker compose
- CI workflow setup with no tests added yet

<!-- GETTING STARTED -->
## Getting Started

Follow this section to set up the app with current capabilites on your local dev environment

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

- [ ] CD pipeline setup
  - [ ] Automated tests
- [ ] Deploy to Kubernetes
- [ ] Add prometheus metrics
- [ ] Add grafana dashboards
- [ ] Use IaC for provisioning
- [ ] Integrate with AWS

## App Structure
You can view the app workload structure from [this](https://flask.palletsprojects.com/en/stable/tutorial/) Flask tutorial on which this project is based on

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.
