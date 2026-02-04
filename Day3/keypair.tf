# resource "tls_private_key" "example" {
#     algorithm = "RSA"
#     rsa_bits  = 2048
# }

# resource "local_file" "private_key" {
#     content  = tls_private_key.example.private_key_pem
#     filename = "${path.module}/private_key.pem"
# }

# resource "local_file" "public_key" {
#     content  = tls_private_key.example.public_key_pem
#     filename = "${path.module}/public_key.pem"
# }