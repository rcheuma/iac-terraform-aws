data "aws_availability_zones" "all" {}

resource "aws_elb" "tf" {
  name               = "tf"
  security_groups    = [aws_security_group.tf.id]
  availability_zones = data.aws_availability_zones.all.names

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
    interval            = 30
    target              = "HTTP:80/"
  }

  #tags = {
  # Name = "tf"
  #}
}

resource "aws_security_group" "tf" {
  name = "tf-elb"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}