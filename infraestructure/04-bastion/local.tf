locals {
  effective_ssh_public_key = var.generate_ssh_key
    ? tls_private_key.bastion[0].public_key_openssh
    : (
        var.ssh_public_key != ""
        ? var.ssh_public_key
        : file(var.ssh_public_key_path)
      )
}
