# Proxmox Scripts

This folder contains utility scripts for provisioning and bootstrapping Proxmox VMs.

## Scripts

### `create-vm.sh`

Creates a new Proxmox Ubuntu 24.04 VM by invoking the Proxmox community script.

Usage:

```bash
bash scripts/proxmox/create-vm.sh
```

The wrapper downloads and executes the community-maintained script from:

- `https://community-scripts.org/scripts/ubuntu2404-vm`

This script is intended to be a lightweight bootstrap helper; review the remote script before running it.

Example:

```bash
bash scripts/proxmox/create-vm.sh
```

If the community script accepts parameters, they may also be forwarded through this wrapper.

### `bootstrap-vm.sh`

Connects to a freshly provisioned VM over SSH and performs initial configuration.

Usage:

```bash
bash scripts/proxmox/bootstrap-vm.sh <vm-ip-or-hostname> [ssh-user]
```

Arguments:

- `vm-ip-or-hostname` - target VM SSH address
- `ssh-user` - SSH user name (default: ssh config)

Environment variables:

- `SSH_KEY` - optional private key path for SSH authentication

What it does:

- sets strict shell options for the remote session
- updates packages on Debian/Ubuntu or RHEL/CentOS systems
- installs `qemu-guest-agent`, `cloud-init`, `curl`, and `sudo`
- enables the `qemu-guest-agent` service

Example:

```bash
SSH_KEY=~/.ssh/id_rsa bash scripts/proxmox/bootstrap-vm.sh 192.168.1.100 ubuntu
```

## Notes

- Review the scripts before running them and adapt storage, networking, and package selection to your environment.
- These scripts are intended as starting points for automation; extend them with your own configuration, user setup, and service installation logic.
