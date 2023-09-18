resource "vault_jwt_auth_backend" "awesomeci_oidc" {
  description        = "AwesomeCICD OIDC Integration"
  path               = "jwt"
  oidc_discovery_url = "https://oidc.circleci.com/org/efc130dc-284f-4533-964e-844f5c173860"
  bound_issuer       = "https://oidc.circleci.com/org/efc130dc-284f-4533-964e-844f5c173860"
}

resource "vault_mount" "kvv2" {
  path = "secret"
  type = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = "This is an example KV Version 2 secret engine mount"
}
resource "vault_kv_secret_backend_v2" "example" {
  mount                = vault_mount.kvv2.path
  max_versions         = 5
  delete_version_after = 12600
  cas_required         = false
}

resource "vault_policy" "nexus_access" {
  name = "dev-team"

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

resource "vault_policy" "boa-dev" {
  name = "boa-dev-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/boa-dev" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/boa-dev" {
  capabilities = ["list","read"]
}
EOF
}


resource "vault_policy" "boa_prod" {
  name = "boa-prod-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/boa-prod" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/boa-prod" {
  capabilities = ["list","read"]
}
EOF
}


resource "vault_policy" "fieldguide_prod" {
  name = "ieldguide-prod-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/guidebook" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/guidebook" {
  capabilities = ["list","read"]
}
EOF
}

resource "vault_policy" "fieldguide_dev" {
  name = "ieldguide-dev-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/guidebook-dev" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/guidebook-dev" {
  capabilities = ["list","read"]
}
EOF
}


resource "vault_jwt_auth_backend_role" "boa_dev" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "boa-dev-deploy"
  token_policies = ["nexus-deploy-access", "boa-dev-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "[\"7cf67bf2-cf99-4cc7-8ae5-a0daf86ae02b\"]"
    "oidc.circleci.com/project-id"  = "788dd296-2fca-4718-82f8-07db1637a58e"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

resource "vault_jwt_auth_backend_role" "boa_prod" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "boa-prod-deploy"
  token_policies = ["nexus-deploy-access", "boa-prod-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "[\"7cf67bf2-cf99-4cc7-8ae5-a0daf86ae02b\"]"
    "oidc.circleci.com/project-id"  = "788dd296-2fca-4718-82f8-07db1637a58e"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

resource "vault_jwt_auth_backend_role" "fieldguide_prod" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "fieldguide-prod-deploy"
  token_policies = ["nexus-deploy-access", "fieldguide-prod-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "[\"7cf67bf2-cf99-4cc7-8ae5-a0daf86ae02b\"]"
    "oidc.circleci.com/project-id"  = "fd5dc210-23ad-42e5-b01e-417320fc3945"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

resource "vault_jwt_auth_backend_role" "fieldguide_dev" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "fieldguide-dev-deploy"
  token_policies = ["nexus-deploy-access", "fieldguide-dev-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "[\"093549cb-82d4-48af-bd80-6c45ef7bbf07\"]"
    "oidc.circleci.com/project-id"  = "fd5dc210-23ad-42e5-b01e-417320fc3945"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}