

## Auth ROLES are what our application HTTP request will include, agaonst a shared backend based on org.


resource "vault_jwt_auth_backend_role" "ecap_dev" {
  backend        = vault_jwt_auth_backend.ecap_oidc.path
  role_name      = "ecap-dev-deploy"
  token_policies = ["nexus-deploy-access", "ecap-dev-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "d05c8c0b-5048-4dc6-a998-8c3d6bc672d5"
    "oidc.circleci.com/project-id"  = "a9d88e1c-c012-4304-95da-87259abfccdc"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

resource "vault_jwt_auth_backend_role" "ecap_prod" {
  backend        = vault_jwt_auth_backend.ecap_oidc.path
  role_name      = "ecap-prod-deploy"
  token_policies = ["nexus-deploy-access", "ecap-prod-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "136e5d23-920c-4304-9b96-c6792931d9b1"
    "oidc.circleci.com/project-id"  = "a9d88e1c-c012-4304-95da-87259abfccdc"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}


## Policies (used by roles)




resource "vault_policy" "ecap-dev" {
  name = "ecap-dev-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/ecap-dev" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/ecap-dev" {
  capabilities = ["list","read"]
}
EOF
}


resource "vault_policy" "ecap_prod" {
  name = "ecap-prod-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/ecap" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/ecap" {
  capabilities = ["list","read"]
}
EOF
}
