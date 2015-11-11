variable "vpc_id" { }
variable "vpc_cidr_block" { }

variable "allocated_storage" {
  default = "32"
}
variable "engine_version" {
  default = "9.4.4"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "storage_type" {
  default = "gp2"
}
variable "database_name" { }
variable "database_password" { }
variable "database_username" { }
variable "backup_retention_period" {
  default = "30"
}
variable "backup_window" {
  # 12:00AM-12:30AM ET
  default = "04:00-04:30"
}
variable "maintenance_window" {
  # SUN 12:30AM-01:30AM ET
  default = "sun:04:30-sun:05:30"
}
variable "multi_availability_zone" {
  default = false
}
variable "storage_encrypted" {
  default = false
}

variable "private_subnet_ids" { }

variable "parameter_group_family" {
  default = "postgres9.4"
}
