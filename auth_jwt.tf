resource "vault_jwt_auth_backend" "awesomeci_oidc" {
  description        = "AwesomeCICD OIDC Integration"
  path               = "jwt"
  oidc_discovery_url = "https://oidc.circleci.com/org/efc130dc-284f-4533-964e-844f5c173860"
  bound_issuer       = "https://oidc.circleci.com/org/efc130dc-284f-4533-964e-844f5c173860"
}

resource "vault_jwt_auth_backend" "gha_oidc" {
  description        = "GitHub Actions OIDC Integration"
  path               = "jwt-gha"
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
}

resource "vault_jwt_auth_backend" "stone_monkeys_gitlab_oidc" {
  description        = "stone-monkeys-gitlab Integration"
  path               = "jwt-gitlab"
  oidc_discovery_url = "https://oidc.circleci.com/org/b06fed6f-34a7-4d56-995b-25317e0033c8"
  bound_issuer       = "https://oidc.circleci.com/org/b06fed6f-34a7-4d56-995b-25317e0033c8"
}

resource "vault_jwt_auth_backend" "circlecilabs_oidc" {
  description        = "CircleCI-Labs OIDC Integration"
  path               = "labs_jwt"
  oidc_discovery_url = "https://oidc.circleci.com/org/4ada2c32-f0c2-4b60-a6b8-af674858fd51"
  bound_issuer       = "https://oidc.circleci.com/org/4ada2c32-f0c2-4b60-a6b8-af674858fd51"
}

resource "vault_jwt_auth_backend" "ecap_oidc" {
  description        = "ECAP OIDC Integration"
  path               = "jwt-ecap"
  oidc_discovery_url = "https://oidc.circleci.com/org/f8b4466a-aaf8-41b4-8224-e1c24d295701"
  bound_issuer       = "https://oidc.circleci.com/org/f8b4466a-aaf8-41b4-8224-e1c24d295701"
}