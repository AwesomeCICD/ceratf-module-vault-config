
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
