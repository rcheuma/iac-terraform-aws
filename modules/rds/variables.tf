variable "rds-identifier" {
  default = "tf"
}

variable "rds-storage-size" {
  default = "5"
}

variable "rds-storage-type" {
  default = "gp2"
}

variable "rds-engine" {
  default = "postgres"
}

variable "rds-engine-version" {
  default = "9.5.2"
}

variable "rds-instance-class" {
  default = "db.t2.micro"
}

variable "rds-username" {
  default = "myusername"
}

variable "rds-password" {
  default = "mypassword"
}

variable "rds-port" {
  default = "5432"
}