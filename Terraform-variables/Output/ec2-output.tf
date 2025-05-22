output "ec2-instance-public-ip" {
  description = "Ec2-Insatnec Public Ip"
  value       = aws_instance.demo1-ec2.public_ip
}

output "ec2-instance-private-ip" {
  description = "Ec2-Instance_Private IP"
  value       = aws_instance.demo1-ec2.private_ip

}

output "ec2-instance-security-groups" {
  description = "Security Groups associated with the ec2-instance"
  value       = aws_instance.demo1-ec2.security_groups
}

output "ec2-public-dns" {
  description = "Ec2 Public DNS"
  value       = "https://${aws_instance.demo1-ec2.public_dns}"
}
