output "bastion_server_connect" {
  value = "ssh -p ${var.ssh_port} -i ${var.generated_key_name}.pem ${var.aws_user}@${aws_instance.bastion.public_dns}"
}

output "private_key" {
  value     = tls_private_key.generated_key.private_key_pem
  sensitive = true
}

output "public_key" {
  value     = aws_key_pair.generated_key.public_key
  sensitive = true
}
