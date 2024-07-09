
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

resource "vault_jwt_auth_backend_role" "dc-db-demo-app" {
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


#
# Eddies Demo Namespace Access
#

resource "vault_policy" "eddies-demo" {
  name = "eddies-demo-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/eddies-demo" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/eddies-demo" {
  capabilities = ["list","read"]
}
EOF
}

resource "vault_jwt_auth_backend_role" "eddies-demo" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "eddies-demo-deploy"
  token_policies = ["nexus-deploy-access", "eddies-demo-deploy"]

  bound_claims = {
    "oidc.circleci.com/project-id" = "c45f4aa5-18b6-4b0a-805d-dd1dca8c775b"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}
