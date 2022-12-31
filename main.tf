resource "tls_private_key" "generated_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.generated_key_name
  public_key = tls_private_key.generated_key.public_key_openssh

  provisioner "local-exec" {    # Generate "terraform-key-pair.pem" in current directory
    command = <<-EOT
      echo '${tls_private_key.generated_key.private_key_pem}' > ./'${var.generated_key_name}'.pem
      chmod 400 ./'${var.generated_key_name}'.pem
    EOT
  }
  tags = {
    Name = "${var.organization}-${var.stage}-keypair"
    Organization = var.organization
    Stage = var.stage
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = var.aws_subnet_public_a

  associate_public_ip_address = true

  key_name      = aws_key_pair.generated_key.key_name

  vpc_security_group_ids = [
    aws_security_group.bastion.id
  ]

  tags = {
    Name = "${var.organization}-${var.stage}-bastion"
    Organization = var.organization
    Stage = var.stage
  }
}
