
resource "vault_jwt_auth_backend_role" "training_prod" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "training-prod-deploy"
  token_policies = ["nexus-deploy-access", "training-prod-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "87c698a8-77fd-4ec0-935a-51ee55904aae"
    "oidc.circleci.com/project-id"  = "44fc5d2d-186d-44e6-9364-56d19b0a5ecb"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

resource "vault_jwt_auth_backend_role" "training_dev" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "training-dev-deploy"
  token_policies = ["nexus-deploy-access", "training-dev-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "7cf67bf2-cf99-4cc7-8ae5-a0daf86ae02b"
    "oidc.circleci.com/project-id"  = "44fc5d2d-186d-44e6-9364-56d19b0a5ecb5"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}





resource "vault_policy" "training_prod" {
  name = "training-prod-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/training" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/training" {
  capabilities = ["list","read"]
}
EOF
}

resource "vault_policy" "training_dev" {
  name = "training-dev-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/training-dev" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/training-dev" {
  capabilities = ["list","read"]
}
EOF
}
