resource "ibm_is_ssh_key" "prod_ssh_key" {
  name           = "${var.unique_id}1-ssh-key"
  resource_group = ibm_resource_group.default_rg.id
  public_key     = file("./ssh-pub-key")
}