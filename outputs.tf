output "receiver_prod1_private_ip" {
  description = "The private IP address for receiver-prod1"
  value       = ibm_is_instance.receiver-prod1.primary_network_interface[0].primary_ip.0.address
}

output "receiver_prod2_private_ip" {
  description = "The private IP address for receiver-prod2"
  value       = ibm_is_instance.receiver-prod2.primary_network_interface[0].primary_ip.0.address
}

output "receiver_prod3_private_ip" {
  description = "The private IP address for receiver-prod3"
  value       = ibm_is_instance.receiver-prod3.primary_network_interface[0].primary_ip.0.address
}
