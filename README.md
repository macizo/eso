ESO – Puppet Control Repository
Overview

This repository is a Puppet control repository used to manage and enforce system configuration, security baselines, and user management across Linux servers in a structured and repeatable way.

It follows standard Puppet control-repo practices and is designed for on-premise, production environments, with a strong focus on:

System hardening

User and SSH access management

Service management

Compliance and consistency

This project demonstrates infrastructure-as-code, Linux system administration, and platform reliability skills.

Architecture

The repository is structured according to Puppet best practices:

.
├── Puppetfile
├── environment.conf
├── hiera.yaml
├── data/                  # Hiera data (node / role configuration)
├── manifests/             # Site-wide manifests
├── site/                  # Site-specific profiles & roles
└── modules/               # Puppet modules (internal & third-party)

Key Components

Hiera (data/ + hiera.yaml)
Separates configuration data from code, allowing clean overrides per environment, role, or node.

Modules/
Includes both:

Well-known upstream modules (stdlib, concat, ssh, sudo, systemd, selinux, etc.)

Custom or extended modules for organization-specific needs

What This Repository Manages

This control repo is used to manage:

🔐 User & Access Management

System users and SSH users

SSH key distribution

Privilege management via sudo

Consistent user policies across hosts

🛡️ Security & Hardening

Auditd configuration

PAM configuration

NSSwitch and authentication policies

⚙️ System Configuration

Kernel parameters (sysctl)

Cron jobs

Log rotation

Systemd service definitions

File permissions and ownership

📊 Observability & Services

Prometheus exporters

Custom systemd units

Service lifecycle management

Example Use Case

A typical workflow:

Define node or role data in Hiera

Apply profiles from site/ manifests

Puppet enforces:

Correct users and SSH keys

Security baselines

Required services and configurations

Systems remain consistent, auditable, and reproducible

Design Principles

This repository was built with the following principles in mind:

Stability over cleverness
Avoid unnecessary complexity in favor of predictable behavior.

Separation of code and data
Logic lives in modules; configuration lives in Hiera.

Idempotency and repeatability
Systems converge safely regardless of starting state.

Production-first mindset
Designed for long-lived servers in regulated or sensitive environments.

Skills Demonstrated

This project showcases experience with:

Linux system administration

Puppet (control repo, Hiera, modules)

Infrastructure as Code (IaC)

Security hardening and compliance

User and access management

Service management with systemd

Operating production, on-premise environments

Notes for Reviewers

This repository reflects real-world infrastructure management, not a minimal demo.
The focus is on maintainability, clarity, and operational safety, similar to environments found in:

Enterprises

Regulated industries

Mission-critical platforms

License

Internal / educational use.
Third-party modules retain their respective licenses.
