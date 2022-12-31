resource "aws_security_group" "bastion" {
  vpc_id = var.vpc_id

  name        = "for bastion"
  description = "Allow SSH port from all"
}

resource "aws_security_group_rule" "bastion_ingress_rule_1" {
  type      = "ingress"
  from_port = var.ssh_port
  to_port = var.ssh_port
  protocol  = -1

  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion.id

  description = "ingress limit in ssh port"
}

resource "aws_security_group_rule" "bastion_egress_rule_1" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = -1

  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion.id
}
