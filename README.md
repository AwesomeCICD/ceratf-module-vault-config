# ceratf-module-vault-config
Configures Vault for use with CERA, Nexus, and BOA.

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

No requirements.
## Usage
Basic usage of this module is as follows:
```hcl
module "vault_config" {
  source = "git@github.com:AwesomeCICD/ceratf-module-vault-config"
}
```
## Resources

| Name | Type |
|------|------|
| [vault_jwt_auth_backend.awesomeci_oidc](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.boa_dev](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_jwt_auth_backend_role.boa_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_jwt_auth_backend_role.fieldguide_dev](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_jwt_auth_backend_role.fieldguide_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_kv_secret_backend_v2.example](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_backend_v2) | resource |
| [vault_mount.kvv2](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.boa-dev](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.boa_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.fieldguide_dev](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.fieldguide_prod](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.nexus_access](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
## Inputs

No inputs.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vault_mount_path"></a> [vault\_mount\_path](#output\_vault\_mount\_path) | n/a |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->