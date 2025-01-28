# Firefly Docker Image with Trend Micro Artifact Scanning

This repository demonstrates how to **build** a Docker image and **secure** it using **Trend Micro Artifact Scan** integrated with **GitHub Actions**. It shows:

- **Random file generation** in the Docker image to ensure each build produces a unique digest.  
- **Multiple scan jobs** (vulnerabilities, malware, secrets, SBOM).  
- **Fail-fast** strategy if issues are found, preventing the image from being pushed to Docker Hub.  
- **Integration** with GitHub Actions for an automated CI/CD pipeline.

---

## Table of Contents

- [Overview](#overview)  
- [Repository Structure](#repository-structure)  
- [Prerequisites](#prerequisites)  
- [Setup & Usage](#setup--usage)  
- [Pipeline Overview](#pipeline-overview)  
- [Customizing](#customizing)  
- [Contributing](#contributing)  
- [License](#license)

---

## Overview

1. **Docker Image**  
   - A Dockerfile that uses either **Ubuntu** or **Alpine** as a base.  
   - Creates a random file with `$RANDOM` so that each build yields a different image digest.

2. **Trend Micro Artifact Scan**  
   - Scans the image for **vulnerabilities, malware, secrets**, and optionally **generates an SBOM**.  
   - Fails the pipeline on critical findings.

3. **GitHub Actions Workflow**  
   - A multi-job pipeline: **Build** → **Scans** → **(Push if clean)**.  
   - Each scan job uploads logs as **artifacts** (even on failure) for troubleshooting.

4. **Fail on Issues**  
   - If vulnerabilities, malware, or secrets are detected, the **push** step does not occur, ensuring the compromised image is never released.

---

## Repository Structure

```text
.
├── Dockerfile
├── .github/
│   └── workflows/
│       └── docker-build-push.yml
├── README.md
└── LICENSE
```
- **Dockerfile**: Defines how the Docker image is built, including a step to generate a random file.
- **docker-build-push.yml**: GitHub Actions workflow that orchestrates building the image, scanning, and pushing.
- **README.md**: Documentation (this file).
- **LICENSE**: GPLv3 license file.

---

## Prerequisites

1. **Docker Hub Account**  
   - Create (or use) a repository named `fafiorim/firefly` (or change references to your own Docker Hub username/repo).

2. **Trend Micro Artifact Scan Subscription**  
   - Obtain a **TMAS API key** to run the scans.

3. **GitHub Secrets**  
   - **DOCKER_USERNAME**: Your Docker Hub username  
   - **DOCKER_PASSWORD**: Your Docker Hub password or token  
   - **TMAS_API_KEY**: Trend Micro Artifact Scan API key  

Store these under **Settings → Secrets & variables → Actions** in your repository.

---

## Setup & Usage

1. **Clone** or **fork** this repository.

2. **Configure Dockerfile**  
   - By default, it uses Ubuntu (or Alpine).  
   - Updates packages, installs minimal tools, and creates a random file with `$RANDOM`.

3. **Edit Workflow**  
   - `.github/workflows/docker-build-push.yml` references `fafiorim/firefly`.  
   - Change to match your Docker Hub repo if needed.

4. **Commit & Push**  
   - Once you push to **main**, GitHub Actions triggers automatically.

5. **Monitor the Workflow**  
   - Go to **Actions** → select the latest run.  
   - Observe the multi-job pipeline:
     1. **build**  
     2. **vulnerabilities-scan**  
     3. **sbom-scan**  
     4. **malware-scan**  
     5. **secrets-scan**  
     6. **push-image** (only if the above checks pass)

6. **Check Artifacts**  
   - Even if a scan fails, logs and JSON results (e.g., `vulnerability-scan-results.json`) are available as artifacts.

7. **Visit Docker Hub**  
   - If all scans pass, your image is pushed to Docker Hub (e.g., `fafiorim/firefly:latest`).

---

## Pipeline Overview

1. **Build Job**  
   - Builds the Docker image, saves it as `firefly.tar`.

2. **Vulnerability Scan**  
   - Checks critical vulnerabilities. Fails pipeline if any found.

3. **SBOM Scan**  
   - Generates an SBOM (`--saveSBOM`).  
   - Doesn’t fail the pipeline by default, but you can customize.

4. **Malware Scan**  
   - Identifies known malwares. If found, pipeline fails.

5. **Secrets Scan**  
   - Looks for secrets (e.g., API keys in container layers). Fails on detection.

6. **Push**  
   - Depends on the success of vulnerabilities, malware, and secrets scans.

---

## Customizing

- **Base Image**: Switch `FROM ubuntu:latest` to `FROM alpine:latest` or any other distro in the Dockerfile.  
- **Fail on Additional Criteria**: If you want SBOM scanning or certain severity thresholds to block the pipeline, add the logic and pass it into the final push job’s `needs:`.  
- **Parallel vs. Sequential**: Each scan job runs after the build in **parallel**. If you need sequential checks, adjust their `needs:` relationships.  
- **Different Docker Registry**: Swap out Docker Hub for another registry like AWS ECR or GCR. Just update the login and push steps.

---

## Contributing

1. [Fork](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo) the project  
2. Create a new branch (`git checkout -b feature/my-feature`)  
3. Commit your changes (`git commit -m 'Add my feature'`)  
4. Push to the branch (`git push origin feature/my-feature`)  
5. Open a Pull Request

We welcome bug reports, new ideas, and improvements to the scanning logic or workflow steps.

---

## License

This project is licensed under the terms of the **GNU General Public License v3.0 (GPLv3)**. See the [LICENSE](LICENSE) file for details.

---

**Happy scanning!** If you have any questions or find any issues, please open an **issue** or contact **Trend Micro** for Artifact Scan support.
