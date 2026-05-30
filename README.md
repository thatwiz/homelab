# homelab

This repository contains bootstrap scripts and tools for building one-off and repeatable homelab environments.

## Goals

- Automate Proxmox VM creation
- Automate post-creation VM bootstrap tasks
- Provide a single place for homelab provisioning helpers

## Structure

- `scripts/proxmox/`
  - `create-vm.sh` - create a new Proxmox VM from an ISO
  - `bootstrap-vm.sh` - run initial configuration and package installation on a fresh VM

## Getting started

### Prerequisites

- A Proxmox host with CLI access (`qm`, `pvesh`)
- SSH access to the Proxmox host and the target VM
- ISO image uploaded to Proxmox storage
- Bash shell

### Create a VM

```bash
bash scripts/proxmox/create-vm.sh 110 myvm local-lvm local:iso/ubuntu-24.04-server.iso
```

### Bootstrap a VM after install

```bash
bash scripts/proxmox/bootstrap-vm.sh 192.168.1.50
```

## Notes

- These scripts are intentionally lightweight and portable.
- Customize settings using environment variables if needed.
- Review the scripts before use and adapt `PVE_NODE`, `PVE_BRIDGE`, `PVE_STORAGE`, and networking settings for your environment.
