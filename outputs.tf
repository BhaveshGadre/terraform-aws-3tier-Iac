output "vpc_id" {
  value = aws_vpc.main.id
}

output "alb_dns_name" {
  value = aws_lb.webapp_alb.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.mysql_db.endpoint
}

output "public_subnet_ids" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.pvt_a.id, aws_subnet.pvt_b.id]
}