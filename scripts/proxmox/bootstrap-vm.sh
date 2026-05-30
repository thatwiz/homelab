#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
  cat <<EOF
Usage: bootstrap-vm.sh <vm-ip-or-hostname> [ssh-user]

Example:
  bootstrap-vm.sh 192.168.1.100 ubuntu

You can also configure ssh config to set the user and key for the target host:
in ~/.ssh/config:
Host ubuntu-server
  HostName ubuntu-server
  User myuser

After which you can simply run:
  bootstrap-vm.sh ubuntu-server
EOF
  exit 1
fi

TARGET=$1
SSH_USER=${2:-}
SSH_KEY=${SSH_KEY:-}

SSH_OPTS=("-o" "StrictHostKeyChecking=accept-new" "-o" "UserKnownHostsFile=/dev/null")
if [[ -n "$SSH_KEY" ]]; then
    SSH_OPTS+=("-i" "$SSH_KEY")
fi

if [[ -n "$SSH_USER" ]]; then
    echo "Bootstrapping VM: $TARGET"
else
    echo "Bootstrapping VM: $TARGET as $SSH_USER"
fi

remote_exec() {
    if [[ -n "$SSH_USER" ]]; then
        ssh "${SSH_OPTS[@]}" "$SSH_USER@$TARGET" "$1"
    else
        ssh "${SSH_OPTS[@]}" "$TARGET" "$1"
    fi
}


# Mostly pulled from https://github.com/community-scripts/ProxmoxVE/discussions/272

# Add Guest Agent
remote_exec 'set -euo pipefail && \
  if command -v apt-get >/dev/null 2>&1; then \
    sudo apt-get update -y && \
    sudo apt-get upgrade -y && \
    sudo apt-get install -y qemu-guest-agent && \
    sudo systemctl enable qemu-guest-agent --now; \
  elif command -v yum >/dev/null 2>&1; then \
    sudo yum makecache fast && \
    sudo yum update -y && \
    sudo yum install -y qemu-guest-agent && \
    sudo systemctl enable qemu-guest-agent --now; \
  else \
    echo "Unsupported package manager on target." >&2 && exit 3; \
  fi'

# Install Docker
remote_exec 'set -euo pipefail && \
  if command -v curl >/dev/null 2>&1; then \
    sh <(curl -sSL https://get.docker.com)
  else \
    echo "Curl is not available on target." >&2 && exit 3; \
  fi'


cat <<EOF
Bootstrap complete.
Next steps:
  - verify SSH access
  - configure users, firewall, and networking as needed
  - install additional homelab services
EOF
