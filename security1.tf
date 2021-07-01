locals {
  common_tags = {
    Name = "jjtech"
    App_Name = "ovid"
    Cost_center = "xyz222"
    Business_unit = "GBS"
    Business_unit = "GBS"
    App_role = "web server"
    App_role = "web server"
    Environment = "dev"
    Security_Classification = "NA"
  }
  ports = [22, 23, 25, 53, 80, 123, 1241, 2049, 443, 3389, 8000]
}

resource "aws_eip" "lb" {
  vpc = "true"

}

output "eip" {
  value = aws_eip.lb.public_ip
}

output "eip1" {
  value = aws_eip.lb.id
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-0b1a467e85796eabc"

  dynamic "ingress" {
    for_each = local.ports
    content {
      description = "description${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks  = ["${aws_eip.lb.public_ip}/32"]
    }
  }

