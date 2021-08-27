resource "aws_key_pair" "terraform" {
  key_name   = "key_ssh"
  public_key = file(var.key_pair_public_key_file)
}