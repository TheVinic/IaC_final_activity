output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "instanceFront_ips" {
  value = aws_instance.instanceFront.*.public_ip
}

output "instanceBack_ips" {
  value = aws_instance.instaceBack.*.private_ip
}

output "database_url" {
  value = aws_db_instance.main.address
}