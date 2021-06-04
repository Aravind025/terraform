provider "aws"{
  region = "us-east-2"
}

resource "aws_key_pair" "firstkey" {
  key_name   = "my-first-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCi8h55kYA6ajEpZtvwS67RSQ6V5CZngMKsO8PG149J                                                                                        Z8CNOZaXtZcPjBD64aZ7sVOZyLamS6V9hT2g1a+IxFaM1ZZD7nZaUGAxSqlolCYmeou6mY37eUIxYvTX                                                                                        iqAMEB+MApnQGhpUhIFx5nPvkrrXIPE2bkSiKkkH/aL1O+3BxuEiJAexkFowB0tbRwyUo9hTKVJZg0E4                                                                                        Eknl0XTVx81xaFSNH8J/L+tjCbGw26bcZmapQWsl9/tXmNUtMU7sTEvmIe48viTWvlU0/56uWBOHhnUJ                                                                                        OmGzDqdhOwL2ATrijNsYV7m+gkN2IPhvU31O85vlvUtF2bgj2vO50kY5BdPJ root@ip-172-31-26-9                                                                                        6.us-east-2.compute.internal"
}

resource "aws_security_group" "firstkeysg" {
  name        = "my first keysg"
  description = "Allow ssh traffic"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami = "ami-077e31c4939f6a2f3"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["$(aws_security_group.firstkey.id)"]
  key_name = "$(aws_key_pair,firstkey.id)"
  tags = {
    Name = "my-first-ec2-instance"
  }
}
 
