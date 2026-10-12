#!/usr/bin/env bash
set -euo pipefail

# Скидання правил
ufw --force reset

# 1. Політика за замовчуванням
ufw default deny incoming
ufw default allow outgoing

# 2. Блокування конкретної адреси першим правилом
ufw deny from 203.0.113.66

# 3. Обмеження частоти з'єднань на порт 2200/tcp з підмережі 203.0.113.0/24
ufw limit proto tcp from 203.0.113.0/24 to any port 2200

# 4. Увімкнення фаєрвола
ufw --force enable