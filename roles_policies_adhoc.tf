
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
# Working Title (Server Test Hack App)
#

resource "vault_jwt_auth_backend_role" "working-title" {
  backend        = vault_jwt_auth_backend.circlecilabs_oidc.path
  role_name      = "working-title-deploy"
  token_policies = ["nexus-deploy-access"]

  bound_claims = {
    "oidc.circleci.com/project-id" = "cb279ff5-ab6b-4c53-9728-ac63c8173bfb"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}
