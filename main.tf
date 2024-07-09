
resource "vault_mount" "kvv2" {
  path = "secret"
  type = "kv"
  options = {
    version = "2"
  }
  description = "This is an example KV Version 2 secret engine mount"
}

resource "vault_kv_secret_backend_v2" "example" {
  mount        = vault_mount.kvv2.path
  cas_required = false
}

resource "vault_policy" "nexus_access" {
  name = "nexus-deploy-access"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/nexus/*" {
  capabilities = ["list","read"]
}
path "secret/metadata/nexus/*" {
  capabilities = ["list","read"]
}
EOF
}
