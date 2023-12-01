# resource "ibm_is_share" "file-share" {
#   access_control_mode = "security_group"
#   name                = "${var.unique_id}1-file-share"
#   size                = 100
#   profile             = "dp2"
#   zone                = "us-east-1"
#   iops                = 6000
# }