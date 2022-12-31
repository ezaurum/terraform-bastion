module "bastion" {
  source = "../"

  tags = {
    name         = "test bastion"
    organization = "test"
    stage        = "dev"
  }

  vpc_id    = "testvpcid"
  subnet_id = "test subnet id"
}
