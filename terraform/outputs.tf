output "ips" {
  value = { for i in aws_instance.webserver : i.tags["Name"] => i.private_ip }
}

output "bastion_ip" {
  value = aws_instance.bastion.public_ip
}

output "lb_ip" {
  value = aws_lb.main.dns_name
}