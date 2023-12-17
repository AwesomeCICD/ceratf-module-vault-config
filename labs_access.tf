resource "vault_jwt_auth_backend" "circlecilabs_oidc" {
  description        = "CircleCI-Labs OIDC Integration"
  path               = "labs_jwt"
  oidc_discovery_url = "https://oidc.circleci.com/org/4ada2c32-f0c2-4b60-a6b8-af674858fd51"
  bound_issuer       = "https://oidc.circleci.com/org/4ada2c32-f0c2-4b60-a6b8-af674858fd51"
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
