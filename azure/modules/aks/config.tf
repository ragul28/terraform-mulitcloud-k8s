# SSH key pair 
resource "tls_private_key" "ssh_key_pair" {
  algorithm   = "RSA"
  rsa_bits = 4096
}

# resource "local_file" "ssh_pvtkey" {
#   content  = tls_private_key.ssh_key_pair.private_key_pem
#   filename = "output-files/${var.project}_ssh_key.pem"
#   file_permission = "600"
# }

# resource "local_file" "ssh_pubkey" {
#   content  = tls_private_key.ssh_key_pair.public_key_openssh
#   filename = "output-files/${var.project}_ssh.pub"
# }