
#
# FE Utilities in Default Namespace
#

resource "vault_policy" "fe-utilities" {
  name = "fe-utilities-deploy"

  policy = <<EOF
path "secret/*" {
  capabilities = ["list"]
}
path "secret/data/cluster/fe-utilities" {
  capabilities = ["list","read"]
}
path "secret/metadata/cluster/fe-utilities" {
  capabilities = ["list","read"]
}
EOF
}

resource "vault_jwt_auth_backend_role" "fe-utilities" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "fe-utilities-deploy"
  token_policies = ["nexus-deploy-access", "fe-utilities-deploy"]

  # Any job using `cera-vault-oidc` context
  bound_claims = {
    "oidc.circleci.com/context-ids" = "7cf67bf2-cf99-4cc7-8ae5-a0daf86ae02b"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

