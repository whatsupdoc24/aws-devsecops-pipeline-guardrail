# AWS DevSecOps Pipeline Guardrail

A hands-on DevSecOps project demonstrating automated security checks for AWS Terraform infrastructure using GitHub Actions, Checkov, and Trivy.

## Project Overview

This repository implements a GitHub Actions security gate that scans Terraform infrastructure as code (IaC) for security misconfigurations before changes are merged.

The pipeline uses two security tools:

- **Checkov:** Evaluates Terraform resources against cloud security policies.
- **Trivy:** Performs filesystem-based security scanning, including Terraform misconfiguration checks.

Both scanners execute independently so that a Checkov failure does not prevent Trivy from reporting its findings.

## Verified Security Scan Results

The following results were observed in GitHub Actions workflow runs on the `run-pipeline-scan` branch.

### Checkov

An earlier verified Checkov scan reported:

- 15 passed checks
- 8 failed checks
- 0 skipped checks
- Exit code: 1

Findings included missing S3 versioning, access logging, lifecycle configuration, KMS encryption controls, and other infrastructure security requirements.

### Trivy

A verified Trivy scan reported:

- 1 HIGH-severity Terraform misconfiguration
- 0 CRITICAL-severity findings
- Rule: `AWS-0132`
- Finding: S3 bucket encryption does not use a customer-managed KMS key
- Exit code: 1

Trivy identified the finding in `terraform/main.tf`.

These results demonstrate that the security gate can identify infrastructure misconfigurations and fail a CI job when configured security policies are violated.

## Security Gate Behavior

The GitHub Actions workflow supports pull request checks targeting `main` and manual execution.

The workflow is designed to:

1. Check out repository code.
2. Install the Python environment and Checkov.
3. Scan Terraform using Checkov.
4. Run Trivy even if Checkov reports violations.
5. Fail when applicable security findings violate configured enforcement rules.

## Scope and Limitations

This is a source-code security testing project. The verified scans ran against Terraform configuration files in GitHub Actions.

The results do not establish that the infrastructure was deployed to AWS, that every possible security issue was detected, or that a production environment was assessed.

The Terraform examples are used to demonstrate security controls and automated detection.

## Technologies

AWS, Terraform, GitHub Actions, Checkov, Trivy, YAML, Python

## Security Outcome

Demonstrated automated detection and CI enforcement of Terraform security misconfigurations using two complementary security scanning tools.
