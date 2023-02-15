# Provider
provider "aws" {
  shared_config_files      = ["/home/serhii/.aws/config"]
  shared_credentials_files = ["/home/serhii/.aws/credentials"]
}

resource "aws_instance" "dev_server" {
  ami             = "ami-06c39ed6b42908a36"
  instance_type   = "t2.micro"
  key_name        = "aws_userkey"
  security_groups = ["Security_group-SSH-HTTP-HTTPS"]

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name    = "dev_server"
    Owner   = "Serhii Razlom"
    Project = "PetClinic"
  }
}

resource "aws_instance" "prod_server" {
  ami             = "ami-06c39ed6b42908a36"
  instance_type   = "t2.micro"
  key_name        = "aws_userkey"
  security_groups = ["Security_group-SSH-HTTP-HTTPS"]

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name    = "prod_server"
    Owner   = "Serhii Razlom"
    Project = "PetClinic"
  }
}
