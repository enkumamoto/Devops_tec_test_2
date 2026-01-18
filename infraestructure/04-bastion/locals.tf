locals {
  effective_ssh_public_key = (
    var.generate_ssh_key == true
    ? try(tls_private_key.bastion[0].public_key_openssh, "ssh-rsa AAAAB3NzaC1yc2E...") # fallback
    : (
      var.ssh_public_key_content != null && var.ssh_public_key_content != ""
      ? var.ssh_public_key_content
      : try(file(var.ssh_public_key_path), "ssh-rsa AAAAB3NzaC1yc2E...")
    )
  )
}
