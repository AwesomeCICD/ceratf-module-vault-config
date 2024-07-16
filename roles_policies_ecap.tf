

## Auth ROLES are what our application HTTP request will include, agaonst a shared backend based on org.


resource "vault_jwt_auth_backend_role" "ecap_dev" {
  backend        = vault_jwt_auth_backend.ecap_oidc.path
  role_name      = "ecap-dev-deploy"
  token_policies = ["nexus-deploy-access", "cba-dev-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "f5643782-9c02-48a8-b59b-bc7eb6e45f8d"
    "oidc.circleci.com/project-id"  = "5f5f503c-dd77-4ee9-b436-7e032538e2be"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}

resource "vault_jwt_auth_backend_role" "ecap_prod" {
  backend        = vault_jwt_auth_backend.ecap_oidc.path
  role_name      = "ecap-prod-deploy"
  token_policies = ["nexus-deploy-access", "cba-prod-deploy"]

  bound_claims = {
    "oidc.circleci.com/context-ids" = "8c0765c6-b93c-4e15-aa29-b8dc24ea8c1f"
    "oidc.circleci.com/project-id"  = "5f5f503c-dd77-4ee9-b436-7e032538e2be"
  }
  user_claim              = "sub"
  role_type               = "jwt"
  user_claim_json_pointer = true
}


## Policies (used by roles)
