#!/usr/bin/env bash

set -euo pipefail

# See https://community-scripts.org/scripts/ubuntu2404-vm
SCRIPT_URL="https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/vm/ubuntu2404-vm.sh"

echo "Running Proxmox community Ubuntu 24.04 VM creation script from: $SCRIPT_URL"

bash -c "$(curl -fsSL "$SCRIPT_URL")" -- "$@"
