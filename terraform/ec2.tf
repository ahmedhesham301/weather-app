resource "aws_instance" "webserver" {
  for_each               = { for i in range(2) : "instance${i}" => i }
  ami                    = "ami-09c6c60df90f53603"
  instance_type          = "t2.micro"
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    "Name" = "webserver${each.value}"
  }
  key_name = "jenkins-key"
}