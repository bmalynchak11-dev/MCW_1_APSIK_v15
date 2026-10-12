#!/usr/bin/env bash
set -euo pipefail

# 1. Створення каталогу .ssh з правами 700
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# 2. Генерація ключа ed25519 без парольної фрази
ssh-keygen -t ed25519 -N "" -C "bastion@lab" -f "$HOME/.ssh/id_ed25519"
chmod 600 "$HOME/.ssh/id_ed25519"
chmod 644 "$HOME/.ssh/id_ed25519.pub"

# 3. Формування .ssh/authorized_keys
pub_key=$(cat "$HOME/.ssh/id_ed25519.pub")
echo "from=\"203.0.113.0/24\",no-port-forwarding,no-X11-forwarding $pub_key" > "$HOME/.ssh/authorized_keys"
chmod 600 "$HOME/.ssh/authorized_keys"