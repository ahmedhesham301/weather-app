locals {
  azs = data.aws_availability_zones.available.names
}

resource "aws_instance" "webserver" {
  for_each               = { for i in range(var.instance_count) : "instance${i}" => i }
  ami                    = "ami-0c1b03e30bca3b373"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private[local.azs[each.value % length(local.azs)]].id
  vpc_security_group_ids = [aws_security_group.webserver.id]
  tags = {
    "Name" = "webserver${each.value}"
  }
  key_name = "jenkins-key"
}

resource "aws_instance" "bastion" {
  ami                    = "ami-0c1b03e30bca3b373"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public[local.azs[0]].id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  tags = {
    "Name" = "bastion"
  }
  key_name = "jenkins-key"
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum upgrade -y
              yum install ansible -y
              EOF

}