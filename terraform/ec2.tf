locals {
  azs = data.aws_availability_zones.available.names
}

resource "aws_instance" "webserver" {
  for_each               = { for i in range(var.instance_count) : "instance${i}" => i }
  ami                    = "ami-09c6c60df90f53603"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private[local.azs[each.value % length(local.azs)]].id
  vpc_security_group_ids = [aws_security_group.webserver.id]
  tags = {
    "Name" = "webserver${each.value}"
  }
  key_name = "jenkins-key"
}