# DevSecOps Pipeline

A CI/CD pipeline with security scanning embedded at every stage.
Seven security gates run automatically on every push.
Critical vulnerabilities block the pipeline before anything reaches production.

## Pipeline Stages

| Stage | Tool | What It Checks | Blocks On |
|---|---|---|---|
| SAST | Semgrep | Source code vulnerabilities, secrets in code | HIGH/CRITICAL findings |
| Dependency Scan | npm audit | Known CVEs in npm packages | CRITICAL vulnerabilities |
| IaC Scan | Checkov | Terraform misconfigurations | HIGH/CRITICAL misconfigs |
| Build | Docker Buildx | Builds image only if above stages pass | Build failure |
| Image Scan | Trivy | OS and package CVEs in container image | CRITICAL CVEs |
| Security Report | Custom | Consolidates all findings into summary | N/A (informational) |
| Deploy | Simulated | Runs only if all security gates pass | Any upstream failure |

## Security Tools

Semgrep: SAST scanning against OWASP Top 10, Node.js security rules, secret detection
npm audit: Dependency vulnerability scanning against the npm advisory database
Checkov: IaC scanning against 1000+ security and compliance checks for Terraform
Trivy: Container image scanning for OS-level CVEs and vulnerable packages

## Proven Behaviors

- Added lodash 4.17.15 (HIGH CVE) - pipeline blocked at dependency scan stage
- Build never started - no vulnerable image was created
- Checkov caught missing S3 access logging and cross-region replication
- Accepted risks documented in .checkov.yaml with reviewer and date

## Key Design Decisions

- Parallel stages: SAST and dependency scan run simultaneously to save time
- Fail fast: build only starts if security scans pass
- Accepted risks: .checkov.yaml documents intentional suppressions with justification
- Alpine base image: minimises CVE surface area vs Debian-based images
- Non-root container: application runs as appuser, not root

## Repository Structure

.github/workflows/pipeline.yaml   # Main pipeline definition
app/                               # Node.js application
docker/Dockerfile                  # Hardened container image
terraform/main.tf                  # Sample IaC for scanning
.checkov.yaml                      # Accepted risk suppressions

## Author

Oluwaferanmi David Adeoye
adeoyeoluwaferanmi@gmail.com
