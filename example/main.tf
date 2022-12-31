

module "bastion" {
    source = "../"

    organization = "test"
    stage        = "dev"
    aws_user     = "ec2-user"
    ssh_port = 22

    vpc_id       = "testvpcid"
    aws_subnet_public_a = "test subnet id"
}
