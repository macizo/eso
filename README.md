# ESO – Puppet Control Repository

## Overview

This repository is a **Puppet control repository** used to manage and enforce **system configuration, security baselines, and access control** across Linux servers in a structured and repeatable way.

It follows standard Puppet control-repo practices and is designed for **on-premise, production environments**, with a strong focus on:

- Infrastructure as Code (IaC)
- System hardening and compliance
- User and SSH access management
- Stability and maintainability

This project demonstrates a **Linux / platform engineering mindset**, where reliability and clarity are prioritized over unnecessary complexity.

---

## Why this project exists

This repository exists to demonstrate how I approach managing Linux systems at scale:

- Treating configuration as versioned code
- Enforcing consistent and auditable system state
- Keeping infrastructure predictable and easy to reason about
- Designing for long-lived, production systems

It reflects real-world operational practices rather than a minimal or synthetic demo.

---

## Repository structure

The repository follows Puppet best practices:

```text
.
├── Puppetfile
├── environment.conf
├── hiera.yaml
├── data/                  # Hiera data (node / role configuration)
├── manifests/             # Site-wide manifests
├── site/                  # Site-specific roles and profiles
└── modules/               # Puppet modules (internal & third-party)

```

## Key components

### Puppetfile

Defines and pins module dependencies to ensure reproducible environments.

### Hiera

Implemented using `hiera.yaml` and the `data/` directory.

Responsibilities include:

- Separation of configuration data from code
- Clean overrides per node, role, or environment
- Reduction of duplication across manifests

### Modules

The `modules/` directory contains:

- Well-known upstream Puppet modules
- Site-specific modules and extensions

---

## What this repository manages

### User and access management

- System users and SSH users
- SSH key distribution
- Privilege management using sudo
- Consistent access policies across hosts

### Security and hardening

- Auditd configuration
- PAM configuration
- NSSwitch and authentication policies

### System configuration

- Kernel parameters (sysctl)
- Cron jobs
- Log rotation
- File permissions and ownership
- Systemd service definitions

### Services and observability

- Prometheus exporters
- Custom systemd units
- Service lifecycle management

---

## Example workflow

A typical workflow using this control repository:

1. Define node- or role-specific configuration in Hiera
2. Apply roles and profiles from the `site/` manifests
3. Puppet enforces:
   - Correct users and SSH keys
   - Security baselines
   - Required services and configurations
4. Systems converge to a known, auditable, and repeatable state

---

## Design decisions

The following design choices were made intentionally:

- Preference for simple, predictable manifests over complex logic
- Strong separation between code and data using Hiera
- Minimal customization unless there is a clear operational benefit
- Emphasis on idempotency and safe convergence
- Stability and clarity prioritized over feature density

These decisions reflect experience operating production systems, where maintainability and reliability are critical.

---

## Scope and limitations

This repository focuses on **core system configuration and security baselines**.

The following areas are intentionally out of scope:

- Application-level configuration
- Environment-specific secrets
- Runtime application deployments
- One-off host customizations

These concerns are better handled by deployment tooling or application teams, allowing this repository to remain responsible for stable and repeatable system state.

---

## Possible future improvements

If this repository were to be extended further, potential improvements could include:

- Explicit role and profile examples for specific server types
- Continuous integration validation of Puppet syntax and catalog compilation
- Automated compliance checks against defined security baselines

These improvements were intentionally not implemented to keep the repository focused and easy to review.

---

## Skills demonstrated

This project demonstrates experience with:

- Linux system administration
- Puppet (control repositories, Hiera, and modules)
- Infrastructure as Code (IaC)
- Security hardening and compliance
- User and access management
- Systemd and service management
- Operating production on-premise environments

---

## Notes for reviewers

This repository reflects real-world infrastructure management rather than a toy project.

The emphasis is on:

- Maintainability
- Predictability
- Operational safety

This approach is representative of enterprise and regulated environments.

---

## License

Internal or educational use only.

Third-party modules retain their respective licenses.

