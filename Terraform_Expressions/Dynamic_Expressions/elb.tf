resource "aws_elb" "my_elb" {
  name = "my-elb"
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  instances          = aws_instance.my_ec2[*].id
  count              = (var.high_availability == true ? 1 : 0)
  tags               = local.common_tags
  availability_zones = var.availability_zones
}
