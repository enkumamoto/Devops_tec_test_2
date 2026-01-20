location    = "eastus"
environment = "dev"

resource_group_name = "bastion"

vm_name = "bastion"
vm_size = "Standard_B2s"

admin_username = "azureuser"

generate_ssh_key       = true
ssh_public_key_path    = "~/.ssh/id_rsa.pub"
ssh_public_key_content = ""

enable_public_ip = false

allowed_source_ips = [
  "200.200.200.200/32"
]

os_disk_size_gb = 30
os_disk_type    = "StandardSSD_LRS"

pgadmin_enabled          = false
pgadmin_port             = 5050
pgadmin_default_email    = "admin@local"
pgadmin_default_password = "ChangeMe123!"

tags = {
  Environment = "dev"
  Project     = "devops-technical-test"
  ManagedBy   = "Terraform"
  Owner       = "Platform"
}
