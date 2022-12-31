output "bastion_server_connect" {
  value = module.bastion.bastion_server_connect
}

output "private_key" {
  value = module.bastion.private_key
  sensitive = true
}

output "public_key" {
  value = module.bastion.public_key
  sensitive = true
}
