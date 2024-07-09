

## Auth ROLES are what our application HTTP request will include, agaonst a shared backend based on org.


resource "vault_jwt_auth_backend_role" "cba_dev" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "cba-dev-deploy"
  token_policies = ["nexus-deploy-access", "cba-dev-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "7cf67bf2-cf99-4cc7-8ae5-a0daf86ae02b"
    "oidc.circleci.com/project-id"  = "788dd296-2fca-4718-82f8-07db1637a58e"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

resource "vault_jwt_auth_backend_role" "cba_prod" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "cba-prod-deploy"
  token_policies = ["nexus-deploy-access", "cba-prod-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "87c698a8-77fd-4ec0-935a-51ee55904aae"
    "oidc.circleci.com/project-id"  = "788dd296-2fca-4718-82f8-07db1637a58e"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}


## Policies (used by roles)




resource "vault_policy" "cba-dev" {
  name = "cba-dev-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/cba-dev" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/cba-dev" {
  capabilities = ["list","read"]
}
EOF
}


resource "vault_policy" "cba_prod" {
  name = "cba-prod-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/cba" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/cba" {
  capabilities = ["list","read"]
}
EOF
}
