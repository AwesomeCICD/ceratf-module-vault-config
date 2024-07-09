
#
#  Policies for GHA, Gitlab, and non CCI Access
#


resource "vault_jwt_auth_backend_role" "boa_dev_fork" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "boa-dev-fork-deploy"
  token_policies = ["nexus-deploy-access", "boa-dev-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "7cf67bf2-cf99-4cc7-8ae5-a0daf86ae02b"
    "oidc.circleci.com/project-id"  = "7fe5f8d4-8930-4874-a8ce-71f233d16fe8"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

resource "vault_jwt_auth_backend_role" "boa_prod_fork" {
  backend        = vault_jwt_auth_backend.awesomeci_oidc.path
  role_name      = "boa-prod-fork-deploy"
  token_policies = ["nexus-deploy-access", "boa-prod-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "87c698a8-77fd-4ec0-935a-51ee55904aae"
    "oidc.circleci.com/project-id"  = "7fe5f8d4-8930-4874-a8ce-71f233d16fe8"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

resource "vault_jwt_auth_backend_role" "boa_dev_gha_fork" {
  backend        = vault_jwt_auth_backend.gha_oidc.path
  role_name      = "boa-dev-gha-fork-deploy"
  token_policies = ["nexus-deploy-access", "boa-dev-deploy"]

  bound_claims = {
    "repository" : "AwesomeCICD/github-actions-bank-of-aion"
  }
  user_claim              = "actor"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

resource "vault_jwt_auth_backend_role" "boa_prod_gha_fork" {
  backend        = vault_jwt_auth_backend.gha_oidc.path
  role_name      = "boa-prod-gha-fork-deploy"
  token_policies = ["nexus-deploy-access", "boa-prod-deploy"]

  bound_claims = {
    "repository" : "AwesomeCICD/github-actions-bank-of-aion"
  }
  user_claim              = "actor"
  role_type               = "jwt"
  user_claim_json_pointer = true
}




#
# db-demo-app-gitlab Namespace Access -> Gitlab projectID
#

resource "vault_policy" "db-demo-app-gitlab" {
  name = "db-demo-app-gitlab-deploy"

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

resource "vault_jwt_auth_backend_role" "db-demo-app-gitlab" {
  backend        = vault_jwt_auth_backend.stone_monkeys_gitlab_oidc.path
  role_name      = "db-demo-app-gitlab-deploy"
  token_policies = ["nexus-deploy-access", "db-demo-app-gitlab-deploy"]

  bound_claims = {
    "oidc.circleci.com/project-id" = "2985ffa4-367c-4050-8c19-1b598298cceb"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}