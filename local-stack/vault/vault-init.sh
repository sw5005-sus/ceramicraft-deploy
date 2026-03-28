#!/bin/sh
# Vault dev-mode init script for local development.
# Runs once at startup to seed encryption keys into KV v2.
set -e

echo "Waiting for Vault to be ready..."
until vault status >/dev/null 2>&1; do
  sleep 1
done
echo "Vault is ready."

# Enable KV v2 secrets engine at 'secret/' (dev mode enables it by default,
# but this is idempotent)
vault secrets enable -path=secret -version=2 kv 2>/dev/null || true

# Seed encryption keys used by ceramicraft-secure
vault kv put secret/ceramicraft/sec_config \
  aes_key="b9df6ad09d303432404bdf5ac0f8c08dd7524fefe6103d89389696796e5bad90" \
  hmac_key="2e23817bcd1f0d47e3622df4022719d09d1bebaffdbfd21ec35473f3afd3963b"

echo "Vault init complete — sec_config seeded."
