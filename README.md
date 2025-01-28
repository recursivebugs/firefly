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
