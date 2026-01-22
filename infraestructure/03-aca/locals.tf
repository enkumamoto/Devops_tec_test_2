locals {
  aca_subnet_id = try(
    data.terraform_remote_state.network.outputs.aca_subnet_id,
    null
  )
}

locals {
  aca_subnet_cidr = try(
    data.terraform_remote_state.network.outputs.aca_subnet_address_prefixes[0],
    null
  )
}
