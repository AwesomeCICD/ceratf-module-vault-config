
# So thst other modules can share secrets to vault
output "vault_mount_path" {
  value = vault_mount.kvv2.path
}