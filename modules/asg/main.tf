data "aws_availability_zones" "all" {}

resource "aws_launch_configuration" "tf" {
  image_id        = var.asg-image_id
  instance_type   = var.asg-instance_type
  key_name        = var.asg-key_name
  security_groups = [aws_security_group.tf-asg.id]
  #user_data = "#!/bin/bash \n set -euf -o pipefail \n exec 1> >(logger -s -t $(basename $0)) 2>&1 \n yum -y install nginx; chkconfig nginx on; service nginx start"
  user_data = "#!/bin/bash \n yum -y install nginx; service nginx start"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "tf-asg" {
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "tf-asg"
  }
}

resource "aws_autoscaling_group" "tf" {
  name                 = "tf"
  launch_configuration = aws_launch_configuration.tf.id
  availability_zones   = data.aws_availability_zones.all.names
  min_size             = var.asg-min_size
  max_size             = var.asg-max_size

  load_balancers    = [var.asg-elb-name]
  health_check_type = "ELB"

  #lifecycle {
  #  create_before_destroy = true
  #}    
}