# AWS DevSecOps Pipeline & Infrastructure-as-Code Guardrails

## 🚀 Architectural Overview
This repository implements a modular, shift-left security enforcement architecture inside a continuous integration (CI) development lifecycle. The objective is to stop misconfigured cloud assets from ever reaching an active AWS environment. 

By running static application security testing (SAST) and compliance-as-code validation frameworks on every incoming code change, the infrastructure platform enforces a hard-fail checkpoint against high and critical structural vulnerabilities.

## 🛠️ Integrated Security Stack & Guardrails
* **Automation Platform:** GitHub Actions Workflows
* **Infrastructure-as-Code Configuration Engine:** Terraform Core
* **Control Plane Static Analyzer:** Checkov Security Scanner
* **Filesystem & Secret Detection Engine:** Aqua Security Trivy Scanner

## 🔒 Implemented Security Boundaries & Policy Checks
The automation pipeline scans for and enforces strict guardrail boundaries across code configurations, tracking three primary criteria:
1. **IAM Boundary Enforcements:** Checks for wildcard `*` structural policy definitions to ensure strict alignment with the Principle of Least Privilege (PoLP).
2. **Data-at-Rest Encryption Mandates:** Hard-fails any Amazon S3 bucket definitions missing explicit KMS server-side encryption (SSE) rules or public access blocks.
3. **Network Perimeter Security Controls:** Scans Amazon VPC security groups to block wide-open ingress boundaries (e.g., exposing port 22/SSH or 3389/RDP to `0.0.0.0/0`).

## 📈 Deployment Lifecycle Execution Logs
The pipeline logic operates across a two-tier evaluation framework:

### 1. The Intercepted Control State (Policy Breach Failure)
When code violating security baselines is delivered via a Pull Request (such as a wide-open security group configuration), Checkov intercepts the deployment stream, returns a non-zero exit code, and completely locks down the repository merge button.

### 2. The Remediation Control State (Validated Deployment Success)
Upon modifying configuration templates to enforce explicit asset encryption boundaries and narrow network parameters, the security runner clears the validation gates with a green verification confirmation, authorizing deployment into production.
