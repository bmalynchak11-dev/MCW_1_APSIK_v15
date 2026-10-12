#!/usr/bin/env bash
set -euo pipefail

# Скидання наявних правил (за потреби для чистоти конфігурації)
ufw --force reset

# 1. Політика за замовчуванням
ufw default deny incoming
ufw default allow outgoing

# 2. SSH (22/tcp) лише з офісної підмережі 192.0.2.0/24
ufw allow from 192.0.2.0/24 to any port 22 proto tcp

# 3. Блокування конкретної адреси перед загальним дозволом для HTTPS
ufw deny from 198.51.100.77 to any port 443 proto tcp
ufw allow 443/tcp

# 4. PostgreSQL (5432/tcp) лише з підмережі застосунків 10.20.0.0/16
ufw allow from 10.20.0.0/16 to any port 5432 proto tcp

# 5. Увімкнення без запитання підтвердження
ufw --force enable