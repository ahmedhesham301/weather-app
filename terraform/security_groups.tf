resource "aws_security_group" "webserver" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "lb" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "bastion" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "allow_egress" {
  for_each = {
    webserver = aws_security_group.webserver,
    bastion   = aws_security_group.bastion
  }
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
  security_group_id = each.value.id
}

resource "aws_security_group_rule" "allow_ssh_from_bastion" {

  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  type                     = "ingress"
  security_group_id        = aws_security_group.webserver.id
  source_security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "lb" {
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  security_group_id = aws_security_group.lb.id
}

resource "aws_security_group_rule" "allow_ssh_to_bastion" {

  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "allow_5000_from_lb" {
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  type                     = "ingress"
  security_group_id        = aws_security_group.webserver.id
  source_security_group_id = aws_security_group.lb.id
}

resource "aws_security_group_rule" "allow_lb_to_app" {
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  type                     = "egress"
  security_group_id        = aws_security_group.lb.id
  source_security_group_id = aws_security_group.webserver.id
}