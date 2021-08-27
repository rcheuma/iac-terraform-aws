resource "aws_db_instance" "tf" {
  identifier             = var.rds-identifier
  allocated_storage      = var.rds-storage-size
  storage_type           = var.rds-storage-type
  engine                 = var.rds-engine
  engine_version         = var.rds-engine-version
  instance_class         = var.rds-instance-class
  username               = var.rds-username
  password               = var.rds-password
  port                   = var.rds-port
  vpc_security_group_ids = [aws_security_group.tf.id]
  skip_final_snapshot    = true
}

resource "aws_security_group" "tf" {
  name = "tf"

  ingress {
    from_port   = var.rds-port
    to_port     = var.rds-port
    protocol    = "tcp"
    cidr_blocks = ["88.191.244.70/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}