
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

## used by side project to push our custom images to nexus


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
