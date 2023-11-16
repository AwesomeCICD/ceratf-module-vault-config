resource "vault_jwt_auth_backend" "awesomeci_oidc" {
  description        = "AwesomeCICD OIDC Integration"
  path               = "jwt"
  oidc_discovery_url = "https://oidc.circleci.com/org/efc130dc-284f-4533-964e-844f5c173860"
  bound_issuer       = "https://oidc.circleci.com/org/efc130dc-284f-4533-964e-844f5c173860"
}

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
path "secret/data/cluster/boa" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/boa" {
  capabilities = ["list","read"]
}
EOF
}


resource "vault_policy" "fieldguide_prod" {
  name = "fieldguide-prod-deploy"

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
  name = "fieldguide-dev-deploy"

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
    "oidc.circleci.com/context-ids" = "7cf67bf2-cf99-4cc7-8ae5-a0daf86ae02b"
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
    "oidc.circleci.com/context-ids" = "87c698a8-77fd-4ec0-935a-51ee55904aae"
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
    "oidc.circleci.com/context-ids" = "87c698a8-77fd-4ec0-935a-51ee55904aae"
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
    "oidc.circleci.com/context-ids" = "7cf67bf2-cf99-4cc7-8ae5-a0daf86ae02b"
    "oidc.circleci.com/project-id"  = "fd5dc210-23ad-42e5-b01e-417320fc3945"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

resource "vault_jwt_auth_backend_role" "rollouts_demo" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "rollouts-deploy"
  token_policies = ["nexus-deploy-access"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "7cf67bf2-cf99-4cc7-8ae5-a0daf86ae02b"
    "oidc.circleci.com/project-id"  = "1acd25fb-b342-4aa9-b8e3-a572bfecbf31"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}


#
# Scara Namespace Access
#

resource "vault_policy" "scara" {
  name = "scara-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/scara" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/scara" {
  capabilities = ["list","read"]
}
EOF
}

resource "vault_jwt_auth_backend_role" "scara" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "scara-deploy"
  token_policies = ["nexus-deploy-access", "scara-deploy"]

  bound_claims = {
    "oidc.circleci.com/project-id" = "b17e553d-f590-48d6-a90d-cbf099bc17f2"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

#
# Dr Demo Namespace Access
#

resource "vault_policy" "dr-demo" {
  name = "dr-demo-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/dr-demo" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/dr-demo" {
  capabilities = ["list","read"]
}
EOF
}

resource "vault_jwt_auth_backend_role" "dr-demo" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "dr-demo-deploy"
  token_policies = ["nexus-deploy-access", "dr-demo-deploy"]

  bound_claims = {
    "oidc.circleci.com/project-id" = "c45f4aa5-18b6-4b0a-805d-dd1dca8c775b"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

#
# DC-DB-Demo-App Namespace Access
#

resource "vault_policy" "dc-db-demo-app" {
  name = "dc-db-demo-app-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/dc-db-demo-app" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/dc-db-demo-app" {
  capabilities = ["list","read"]
}
EOF
}

resource "vault_jwt_auth_backend_role" "scara" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "dc-db-demo-app-deploy"
  token_policies = ["nexus-deploy-access", "dc-db-demo-app-deploy"]

  bound_claims = {
    "oidc.circleci.com/project-id" = "70862590-d318-41ed-b64a-15162a6bb77a"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}
