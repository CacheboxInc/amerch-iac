resource "ibm_is_ssh_key" "prod_dal_jumphost_ssh_key" {
  name           = "prod-dal-jumphost-ssh-key"
  resource_group = ibm_resource_group.default_rg.id
  public_key     = file("./prod_dal_jumphost_ssh_key")
}

