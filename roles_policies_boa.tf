#
# DEPRECATION NOTICE:  The acronym BOA (from google's Bank of Anthos) is being retired in favor of CBA (Circle Bank App)
#



## Auth ROLES


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


## Policies (used by roles)




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
