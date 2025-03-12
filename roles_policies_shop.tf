
#
# Dr Demo Namespace Access
#

resource "vault_policy" "circle-shop" {
  name = "circle-shop-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/circle-shop" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/circle-shop" {
  capabilities = ["list","read"]
}
EOF
}

resource "vault_policy" "circle-shop-dev" {
  name = "circle-shop-dev-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/circle-shop-dev" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/circle-shop-dev" {
  capabilities = ["list","read"]
}
EOF
}
resource "vault_jwt_auth_backend_role" "circle-shop" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "circle-shop-deploy"
  token_policies = ["nexus-deploy-access", "circle-shop-deploy", "circle-shop-dev-deploy"]

  bound_claims = {
    "oidc.circleci.com/project-id" = "909be1b0-e447-4eea-8cc1-5f04ebf803ed"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

