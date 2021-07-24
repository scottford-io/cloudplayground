output "amazon2_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = module.amazon2_instances.public_ip
}

output "ubuntu2004_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = module.ubuntu2004_instances.public_ip
}