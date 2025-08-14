## Quiby Infra

**Quiby Infra** is the infrastructure-as-code repository for the entire Quiby ecosystem.

It contains Docker Compose configurations, reverse proxy (Traefik) setup, monitoring stack, environment templates, and deployment scripts.

This repo serves as the single source of truth for:

* Service networking and environment variables
* Version management for all application images
* CI/CD workflows for automated deployments
* Bootstrap scripts for provisioning new servers

By centralizing configurations here, we ensure consistent, version-controlled deployments across all environments.
