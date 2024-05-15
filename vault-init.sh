#!/usr/bin/env sh

set -ex

unseal () {
vault operator unseal $(grep 'Key 1:' /vault/file/keys | awk '{print $NF}')
vault operator unseal $(grep 'Key 2:' /vault/file/keys | awk '{print $NF}')
vault operator unseal $(grep 'Key 3:' /vault/file/keys | awk '{print $NF}')
}

init () {
vault operator init > /vault/file/keys
touch /vault/file/vault-root-token
echo $(grep 'Initial Root Token:' /vault/file/keys | awk '{print $NF}') > /vault/file/vault-root-token

}

if [ -s /vault/file/keys ]; then
   unseal
else
   init
   unseal
fi

vault status > /vault/file/status

export VAULT_TOKEN=$(grep 'Initial Root Token:' /vault/file/keys | awk '{print $NF}')
vault secrets enable -path=dcloud -version=2 kv
vault kv put dcloud/attackiq username="$1" password="$2" key="$3"