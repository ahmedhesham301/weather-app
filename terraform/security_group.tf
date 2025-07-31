resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "allow_http" {
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "allow_ssh" {
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  security_group_id = aws_security_group.main.id
}

resource "aws_security_group_rule" "allow_egress" {
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
  security_group_id = aws_security_group.main.id
}