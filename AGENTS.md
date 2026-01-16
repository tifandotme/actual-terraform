# AGENTS.md - Guide for AI Agents Working with Infrastructure

This repo manages self-hosted Actual Budget on GCP using Terraform.

Always read these files at the start of conversation:

- main.tf
- variables.tf
- outputs.tf
- mise.toml

Never run terraform's `apply` or `destroy` commands

Always run `mise run check` after you reconfigure terraform.
