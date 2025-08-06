resource "aws_lb" "main" {
  name               = "main-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets = [
    for subnet in values(aws_subnet.public) : subnet.id
  ]
}
resource "aws_lb_target_group" "main" {
  name     = "tf-example-lb-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "main" {
  for_each         = aws_instance.webserver
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = each.value.id
  port             = 5000
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}