resource "aws_instance" "tf" {
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.tf.id]
  subnet_id              = var.ec2_subnet_id
  user_data              = <<-EOF
      #!/bin/bash
      sudo amazon-linux-extras install -y nginx1.12
      echo "<h1>Helloworld</h1>" | sudo tee /usr/share/nginx/html/index.html
      sudo service nginx start
  EOF
  key_name               = var.ec2_instance_key_name

  #tags = {
  # Name = var.ec2-instance_name
  #}
}

resource "aws_security_group" "tf" {
  name   = "HTTP & SSH access"
  vpc_id = var.ec2_vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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